//
//  main.swift
//  Swift_函数
//
//  Created by HarrySun on 2017/2/6.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import Foundation


// 1.写一个函数
func sum(x:Int,y:Int) -> Int{
    
    return x + y
}
// sum是一个函数名，剩下（ ）里是参数和对应的参数所属的类型，->是返回参数类型

let num = sum(x: 100, y: 300)
print(num)  // 打印   400


// 2.无参函数
// 无参函数就是在小括号里不谢参数就行
func sayHello() -> String{
    
    return "hello"
}

print(sayHello())   // 打印   hello


// 3.无返回值函数
// 无返回值函数有三种写法
func test1(){
    
    print("无返回值写法一")
}

func test2() -> (){
    
    print("无返回值写法二")
}

func test3() -> Void {
    
    print("无返回值写法三")
}

test1()   // 打印   无返回值写法一
test2()   // 打印   无返回值写法二
test3()   // 打印   无返回值写法三



// 4.多个返回值的函数
// 这里就会体现我们学元祖的价值了，使用元祖类型作为函数返回值，可以让多个值作为一个复合值返回
func studentInfo(id:String) -> (name:String,age:Int,gender:String){
    
    var name = "no"
    var age = 0
    var gender = "no"
    
    
    if id == "HarrySun" {
        
        name = "HarrySun"
        age = 21
        gender = "man"
        
    }
    return (name,age,gender)
}


let stu = studentInfo(id: "HarrySun")
print(stu)  // 打印   ("HarrySun", 21, "man")


// 5.前面的我们定义的函数参数名x,y或者是id，都只是在函数内部使用，这些叫局部参数名
// 如果我们在这些参数名前面再加一个参数名，那前面加的这个参数名就是要给外部参数，用的时候必须显示出来

// 例如 上面的加法函数，没法在外部使用其参数x,y
// 但是可以这样
func sum2(num1 x:Int,num2 y:Int) -> Int{
    
    return x + y
}

// 这里的num1，num2是外包参数名，先了解一下
print(sum2(num1: 2, num2: 3))      // 打印    5


// 6.含有默认参数的函数
func sayHi(message:String,name:String = "小明"){
    
    print("\(message),\(name)")
}

sayHi(message: "欢迎")      // 打印    欢迎，小明
sayHi(message: "欢迎", name: "花花")      // 打印    欢迎，花花




// 7.可变参数的函数
// 一个可变参数可以接受零个或者多个指定类型的值，函数调用时，使用可变参数来指定函数参数可以被传入
func allSum(numbers:Double...) -> Double{
    
    var total:Double = 0
    for i in numbers {
        total += i
    }
    
    return total
}

print(allSum(numbers: 1,2,3,4,5))      // 打印    15.0



// 8.In-Out（输入输出）函数
// 一般参数仅仅是在函数内可以改变的，当一个函数执行完后变量就会被销毁，如果想要通过一个函数可以修改参数的值，并且让这些参数调用结束后然后存在
func testInout(a: inout Int,b: inout Int){
    
    a = 1
    b = 2
}

var numa = 100
var numb = 20
testInout(a: &numa, b: &numb)  // 希望规定这个函数的inout参数前加&
print(numa,numb)    // 打印   1 2


// 9.嵌套函数
// 前面定义的函数都是一个全局函数，定义在全局的作用域中，那我们还有一种函数是定义在另一个函数里面，对外是不可见的，但是可以被外围函数调用的。
// 例一
func getMaxFromArray(array:Array<Int>) -> Int{
    
    func compareMax(a:Int,b:Int) -> Int {
        
        if a > b {
            
            return a
        }
        return b
    }
    
    var numa = 0
    for i in array {
        numa = compareMax(a: i, b: numa)
    }
    
    return numa
}

var array:Array<Int> = [1,2,3,4,10,44,30,23]
print(getMaxFromArray(array: array))    // 打印   44


// 例二
func calculate(str:String) -> (Int,Int) ->Int {
    
    func add(a:Int,b:Int) -> Int{
        
        return a + b
    }
    func sub(a:Int,b:Int) -> Int{
        
        return a - b
    }
    
    var result:(Int,Int) -> Int;
    
    switch str {
    case "+":
        result = add;
    case "-":
        result = sub;
    default:
        result = add;
    }
    
    return result;
    
}

print(calculate(str: "+")(1,2))     // 打印   3



