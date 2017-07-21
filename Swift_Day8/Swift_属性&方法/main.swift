//
//  main.swift
//  Swift_属性&方法
//
//  Created by HarrySun on 2017/2/8.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import Foundation

// 属性
// 属性用于描述类、结构体或枚举的值。在swift中属性分为：存储属性、计算属性、类属性三种

// 1.存储属性
struct Person{
    
    let name:String // 存储属性
    var age:Int     // 存储属性
}

var person = Person(name:"HarrySun",age:21)
print(person.name,person.age)   // 打印   HarrySun 21
person.age = 19
print(person.age)   // 打印   19

//person.name = "lisa"  // 报错因为结构体是值类型


// 2.计算属性
// 计算属性，不存储值，而是提供了一个getter和setter方法来分别进行获取值和设置其他属性的值，getter使用get关键字，setter使用set关键字。
class Student{
    
    var lenght:Int = 10
    
    var age:Int{
        get{
            return lenght * 2
        }
        set{
            lenght = newValue / 2
        }
    }
    
    var height:Int{
        get{
            return lenght * 4
        }   // 只读计算属性
    }
    
    var weight:Int{
        return lenght * 10
    }   // 只读计算属性可以省略掉get
}

var student = Student()
print(student.weight)   // 打印   100     // 调用计算属性，weight只读，值是由存储属性的lenght也被改变
print(student.age)   // 打印   20
print(student.lenght)   // 打印   10


student.age = 30    // 调用计算属性，因为支持读和写，所有内部的存储属性lenght也被改变
print(student.age)  // 打印   30
print(student.lenght)   // 打印   15


// 3.类型属性
// 类型属性一般是与具体的实例个体没有关系，比如一个学生的学费，这是所有学生都一样了，所以这和学生个例没有关系，那这就要声明成类型的属性，一般是在声明属性前面加一个关键字static，结构体和枚举也是有类型属性

struct Studeng2 {
    
    static var diriction:String = "北京"
    var name:String = ""
    var age:Int = 1
}
print(Studeng2.diriction)  // 打印   北京      // 访问类型属性

// 用类定义
class Student3{
    
    static var diriction:String = "上海"
    var name:String = ""
    var age:Int = 0
}
print(Student3.diriction)  // 打印   上海


// 4.懒存储属性
// 懒存储属性是在使用的时候才计算提供
// 在声明属性前加lazy来标识
class PersonInfo{
    var personFileName = "personInfo.txt"
}

class PersonDataManager{
    lazy var personInfo = PersonInfo()
    var data = String()
}

let manager = PersonDataManager()
manager.data += "some data"
print(manager.data)     // 打印   some data
print(manager.personInfo.personFileName)     // 打印   personInfo.txt  //在此刻用的时候才创建personInfo属性


print("-----------------------------")


// 5.属性观察器
// 用willSet和didSet
class Person2{
    var name:String?
    var age:Int = 0{
        willSet{
            print("将要设置年龄值为\(newValue)")
        }
        
        didSet{
            
            if age < 10 {
                name = "lucy"
            }else{
                name = "lily"
            }
             print("\(name!)的年龄从\(oldValue)改为\(age)")
        }
    }
}

// 思考一下打印结果
let per = Person2()
per.age = 0
per.age = 20

// 结果照片
// 这里注意，当设置的新值和旧值相同时也会被调用





// 方法
// 方法其实就是定义在类、结构体和枚举中的函数
class Person3 {
    var country = "北京"
    var age = 0
    
    // 实例方法
    func goBack(){
        print("回\(country)")
    }
    
    // 类型方法
    static func getInfo(name:String) -> String{
        
        return name
    }
}

var person3 = Person3()
// 实例方法的调用
person3.goBack()     // 打印   回北京

// 类型方法的调用
print(Person3.getInfo(name: (name:"HarrySun")))     // 打印   HarrySun




