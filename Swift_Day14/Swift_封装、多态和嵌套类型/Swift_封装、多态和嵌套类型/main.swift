//
//  main.swift
//  Swift_封装、多态和嵌套类型
//
//  Created by HarrySun on 2017/2/28.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import Foundation


// 封装
// 通常把隐藏属性、方法与方法实现细节的过程称为封装

// 1.隐藏属性和方法
// 使用访问控制修饰符将类和其属性方法封装起来，常用的有public、internal、private
// public：从外部模块和本模块都能访问
// internal：只有本模块能访问
// private：只有本文件可以访问，本模块的其他文件不能访问

public class Student{
    
    public var name:String
    internal var age:Int
    private var score:Int
    
    init(name:String,age:Int,score:Int) {
        
        self.age = age
        self.name = name
        self.score = score
    }
    
    public func sayHi(){
        
        print("大家好")
    }
    
    private func getScore(){
        
        print("我的分数是：\(score)")
    }
}

// Student可以被模块外部访问，也可以在模块内部访问
// 属性name和方法sayHi可以在模块外部访问也可以在模块内部被访问
// 属性age只能在模块内部被访问
// 属性score和方法getScore只能在本文件内被访问

let student = Student.init(name: "CoderSun", age: 21, score: 99)
student.sayHi()     // 打印   大家好
//student.getScore()        // 这里不能访问getScore，因为这个方法是私有的





// 多态
// 多态是指允许使用一个父类类型的变量或者常量来引用一个子类类型的对象，根据被引用子类对象特征的不同，得到不同的运行结果，即使用父类的类型来调用子类的方法

// 定义一个动物
class Animal{
    
    func shout(){
        
        print("动物发出叫声")
    }
}

class Cat: Animal {
    
    override func shout() {
        
        print("猫在喵喵叫")
    }
}

class Dog: Animal {
    
    override func shout() {
        
        print("狗在汪汪叫")
    }
}

let animal1:Animal = Cat()  // 用子类构造函数定义一个父类Animal类型的常量，这和oc不一样
let animal2:Animal = Dog()  // 用子类构造函数定义一个父类Animal类型的常量，这和oc不一样
// animal1和animal2都是父类类型，引用了子类的对象
print(animal1)      // 打印   Swift_封装_多态和嵌套类型.Cat
print(animal2)      // 打印   Swift_封装_多态和嵌套类型.Dog

animal1.shout()     // 打印   猫在喵喵叫
animal2.shout()     // 打印   狗在汪汪叫





// 嵌套类型
// swift允许在一个类型中嵌套定义另一个类型，可以在枚举类型、类和结构体中定义支持嵌套的类型

struct Car {
    
    var brand:String?
    var color:Color
    
    enum Color {
        case Red,White,Orange,Green,Gray
    }
}

let car = Car(brand:"比亚迪",color:Car.Color.Gray)
print(car.color)    // 打印 Gray

