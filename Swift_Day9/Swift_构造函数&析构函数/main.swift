//
//  main.swift
//  Swift_构造函数&析构函数
//
//  Created by HarrySun on 2017/2/8.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import Foundation


// 构造函数
// 构造函数是用来初始化对象的，为对象的属性设置初始值

// 1.系统默认提供了init构造函数
class Person{
    
    var name:String = "张三"
    var age:Int = 18
}

var person = Person()
print(person.name)      // 打印   张三
print(person.age)      // 打印   18

// 2.重写的init构造函数（override）
class Person2:NSObject{
    
    var name:String
    var age:Int
    
    // 重写构造函数
    override init(){
        
        name = "HarrySun"
        age = 21
        super.init()
    }
}

var person2 = Person2()     // 此时就调用了重写的init构造函数
print(person2.name)      // 打印   HarrySun
print(person2.age)      // 打印   21


// 3.重载构造函数
// 一个类中可以定义多个构造函数，与构造函数名字相同，但是参数个数、参数名字、类型和返回值不同，称为构造函数的重载
class Person3{
    
    var name:String
    var age:Int
    
    init(name:String,age:Int) {
        self.name = name
        self.age = age
    }
}

var person3 = Person3(name:"小花",age:12)

print(person3.name)     // 打印   小花
print(person3.age)     // 打印   12


// 4.制定构造函数
// 在子类构造过程中，要先调用父类构造函数初始化父类的存储类型
class Person4{
    
    var name:String
    
    // 这是制定构造函数
    init(name:String) {
        
        self.name = name
    }
}


// 5.便利构造函数
// 便利构造函数是调用同一个类中制定构造函数，并未其参数提供默认值，起到辅助作用，用convenience修饰
class Student{
    
    var name:String
    init(name:String) {
        self.name = name
    }
    
    convenience init(){
        
        self.init(name:"小明")
    }
}

let stu1 = Student(name:"HarrySun") //调用制定构造函数
let stu2 = Student() //调用便利构造函数

print(stu1.name)    // 打印   HarrySun
print(stu2.name)    // 打印   小明




// 析构函数
// 析构函数与构造函数相反，在一个类的实例被释放之前，析构函数被调用，析构函数使用关键字deinit来定义，类似于初始化函数用的init来定义，析构函数没有返回值，没有参数，不需要小括号，所以不能重载，每一个类最多有一个析构函数
class Circle{
    
    let π = 3.1415926
    var r:Double
    
    // 定义一个制定构造函数
    init(r:Double) {
        
        self.r = r
    }
    
    // 定义一个析构函数
    deinit {
        print("释放之前调用该析构函数")
    }
}

// 初始化一个可选性的圆实例，表示可以为nil
var circle:Circle? = Circle(r:3)
print("圆的面积为:\(2 * circle!.π * circle!.r * circle!.r)")

// 当实例为nil时，会调用析构函数
circle = nil
circle = Circle(r:10)
print("圆的周长：\(2 * circle!.π * circle!.r)")




