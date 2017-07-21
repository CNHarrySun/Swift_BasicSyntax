//
//  main.swift
//  Swift_闭包
//
//  Created by HarrySun on 2017/2/7.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import Foundation

// 闭包是一个功能性的自包含模块，可以在代码中被当做参数传递和直接使用，类似于C中的匿名函数和OC中的block

// 1.写一个闭包
let sumFunc = {
    (x:Int,y:Int)->Int
    in
    return x + y
}
// in 关键字表示闭包的参数和返回值类型定义已经完成

print(sumFunc(10,20))      // 打印   30

// 2.尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用
func calculate(opr:String,funN:(Int,Int) -> Int){
    
    switch opr {
    case "+":
        print(funN(10,5))
    default:
        print(funN(10,5))
    }
}


calculate(opr: "+"){ (a:Int,b:Int) -> Int in
    
    return a + b
}      // 打印   15


calculate(opr: "-"){ (a:Int,b:Int) -> Int in
    
    return a - b
}      // 打印   5


// 要使用尾随闭包，则必须是参数列表的最后一个参数，如果不是最后一个参数，是无法使用尾随闭包写法的

// 3.使用闭包表达式
/*
{
    (a:Int,b:Int) -> Int
    in
    return a + b
}
*/
// 这就是一个标准类型的闭包表达式


// 4.根据上下文推断 -> 做出省略
// 可以简写为{a,b in return a - b}，希望系统可以根据a，b的类型推断返回值的类型，所以Int可以省略

func calculate2(str:String) -> (Int,Int) -> Int {
    
    var result:(Int,Int) -> Int
    switch str {
    case "+":
        result = {a,b in return a + b}
    default:
        result = {a,b in return a - b}
    }
    return result
}


let f1 = calculate2(str: "+")
let sum = f1(100,200) // 使用
print(sum)      // 打印   300

//print(calculate2(str: "+")(100,200))


// 5.单行闭包表达式可以省略return关键字
// 如果在闭包中只含有一条语句，可以把return省略，所以{a,b in return a + b}，可以省掉return 可以进一步简写
func calculate3(str:String) -> (Int,Int) -> Int {
    
    var result:(Int,Int) -> Int
    switch str {
    case "+":
        result = {a,b in a + b}
    default:
        result = {a,b in a - b}
    }
    return result
}

print(calculate3(str: "-")(10,3))      // 打印   7



// 6.参数名称缩写
// swift提供了参数名称的缩写功能，用$0,$1,$2来表示调用闭包中参数，同时关键字也可以省略
func calculate4(str:String) -> (Int,Int) -> Int {
    
    var result:(Int,Int) -> Int
    switch str {
    case "+":
        result = {$0 + $1}
    default:
        result = {$0 - $1}
    }
    return result
}

print(calculate4(str: "-")(10,4))      // 打印   6

// 7.捕获
// 捕获函数或者闭包可以在其定义的上下文中捕获常量和变量，即使定义的这些变量或者常量的原作用域不在，仍然可以在闭包函数体内引用和修改这些变量和常量
func makeArray() -> (String) -> [String]{
    
    var array:[String] = [String]()
    func addElement(element:String) -> [String]{
        
        array.append(element)
        return array
    }
    return addElement
}

let fn = makeArray()
print(fn("小二"))      // 打印   ["小二"]
print(fn("小马"))      // 打印   ["小二", "小马"]
print(fn("小明"))      // 打印   ["小二", "小马", "小明"]
print(fn("小五"))      // 打印   ["小二", "小马", "小明", "小五"]


// 这个稍微有点绕，但是多看多练就好了

