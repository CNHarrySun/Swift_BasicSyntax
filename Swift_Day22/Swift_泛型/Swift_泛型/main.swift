//
//  main.swift
//  Swift_泛型
//
//  Created by HarrySun on 2017/9/19.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import Foundation

// 泛型

// 泛型的本质是参数化类型，也就是说所有操作的数据类型被制定为一个参数，这种参数类型可以用在类型、函数和方法中。


// 1.泛型函数--泛型可以用于函数的参数和返回值等，使用了泛型的函数通常称为泛型函数。下面看3个普通函数
// 1.1关于Int类型的交换函数
func exchangeInt(a:inout Int,b:inout Int){
    let temp = a
    a = b
    b = temp
}

var numb1 = 100
var numb2 = 200
print("交换前 numb1 = \(numb1) and numb2 = \(numb2)")
exchangeInt(a: &numb1, b: &numb2)
print("交换后 numb1 = \(numb1) and numb2 = \(numb2)")

// inout在写法上与C语言传递地址的写法十分类似，在调用函数传入参数是带有前缀&，就好像取地址传进去了一样，实则不然。


// 1.2关于Double类型的交换函数
func exchangeDouble(a:inout Double,b:inout Double){
    let temp = a
    a = b
    b = temp
}

var numbA = 30.5
var numbB = 107.77
print("交换前 numb1 = \(numbA) and numb2 = \(numbB)")
exchangeDouble(a: &numbA, b: &numbB)
print("交换后 numb1 = \(numbA) and numb2 = \(numbB)")


// 1.3关于String类型的交换函数
func exchangeString(a:inout String,b:inout String){
    let temp = a
    a = b
    b = temp
}

var strA = "Harry"
var strB = "Sun"
print("交换前 numb1 = \(strA) and numb2 = \(strB)")
exchangeString(a: &strA, b: &strB)
print("交换后 numb1 = \(strA) and numb2 = \(strB)")


// 上面这三个函数实现都是相同的，唯一不同的是传入的参数类型不同，这样显得代码比较冗余，所以我们使用泛型函数

print("下面是泛型结果输出")

func exchange<T>(a:inout T,b:inout T){
    let temp = a
    a = b
    b = temp
}
// 这样对于任何类型都是可以的
numb1 = 100
numb2 = 200
print("交换之前 numb1 = \(numb1) and numb2 = \(numb2)")
exchange(a: &numb1,b: &numb2)
print("交换之后 numb1 = \(numb1) and numb2 = \(numb2)")
numbA = 30.5
numbB = 107.77
print("交换之前 numb1 = \(numbA) and numb2 = \(numbB)")
exchange(a: &numbA,b: &numbB)
print("交换之后 numb1 = \(numbA) and numb2 = \(numbB)")

strA = "Harry"
strB = "Sun"
print("交换之前 numb1 = \(strA) and numb2 = \(strB)")
exchange(a: &strA,b: &strB)
print("交换之后 numb1 = \(strA) and numb2 = \(strB)")





// 2.泛型类型
// swift不但允许定义泛型函数，而且还允许定义泛型类型。这些自定义泛型类型可以是类、结构体和枚举，能适用于任何类型，如同A仍然有何Dictionary的用法一样

// 先定义一个普通类型的栈
struct IntStack {
    var items = [Int]()
    mutating func push(item:Int){
        items.append(item)
    }
    mutating func po() -> Int{
        return items.removeLast()
    }
    
}

// 再定义一个泛型类型的栈，从泛型的栈中可以看出泛型类型
struct Stack<Element> {
    var items = [Element]()
    
    mutating func push(item:Element){
        items.append(item)
    }
    mutating func pop() -> Element{
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push(item: "A")
stackOfStrings.push(item: "B")
stackOfStrings.push(item: "C")
stackOfStrings.push(item: "D")

let fromTheTop = stackOfStrings.pop()
print("fromTheTop的值是\(fromTheTop)")

// 扩展泛型栈
extension Stack{
    var topItem:Element?{
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem{
    print("栈顶的元素是\(topItem)")
}


// 3.类型约束
// 默认情况下，泛型函数和泛型类型可作用于任何类型，不过，有时候需要对泛型函数和泛型类型中的类型做一些强制约束，例如，swift的Dictionary类型对字典的键类型做出约束，要求键类型是可哈希的，下面举一个例子更好的理解类型约束
func findStringIndex(array:[String],valueToFind:String) -> Int?{
    for(index,value) in array.enumerated(){
        if value == valueToFind {
            return index
        }
    }
    return nil
}
let strings = ["Beijing","Shanghai","Guangzhou","Shangdong","Zhengzhou"]
if let foundIndex = findStringIndex(array: strings, valueToFind: "Shanghai"){
    print("Shanghai在数组中的位置是\(foundIndex)")
}

// findStringIndex这个函数只能查找字符串在数组中的索引，用处不是很大，下面写出相同功能的泛型函数findIndex(_,_)用占位类型T替换String
func findIndex<T:Equatable>(array:[T],valueToFind:T) -> Int? {
    for (index,Value) in array.enumerated() {
        if(Value == valueToFind){
            return index
        }
    }
    return nil
}

// 这里我们使用了Equatable协议作为限定，在swift标准库中定义了一个Equatable协议，该协议要求其遵守者必须实现等式符(==)，从而能使用==对符合该协议的类型值进行比较，因为很多类型和自定义的类型都没有遵守该协议
let doubleIndex = findIndex(array:[3.14159,0.1,0.25], valueToFind: 9.3)
print("9.3在数组中的位置是\(String(describing: doubleIndex))")


let stringIndex = findIndex(array: ["ios","android","h5"], valueToFind: "ios")
print("ios在数组中的位置是\(String(describing: stringIndex))")

