//
//  main.swift
//  Swift_继承、重写的综合例子
//
//  Created by HarrySun on 2017/2/21.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import Foundation

// 1.分别继承属性、下标脚本、方法、属性带观察器、还有增加新属性和方法
class Person {
    
    // 存储属性
    var name:String
    
    // 存储属性（带属性观察器）
    var age:Int = 20 {
        
        willSet{
            print("旧的年龄是\(age)")
            print("新的年龄是\(newValue)")
        }
        didSet{
            
            if age > oldValue {
                
                print("新年龄比旧年龄多了\(age - oldValue)岁")
            }else{
                
                print("新年龄比旧年龄少了\(oldValue - age)岁")
            }
        }
    }
    
    // 构造方法
    init(age:Int,name:String) {
        
        self.age = age
        self.name = name
    }
    
    
    // 实例方法
    func sayHi() {
        
        print("hello")
    }
    func printOwnInfo() {
        
        print("姓名:\(name),年龄:\(age)")
    }
    
    // 类方法
    static func printPeronInfo() {
        
        print("我是人类")
    }
    
    // 下标脚本
    subscript(i:Int) -> String {
        
        get{
            switch i {
                
            case 0:
                return "我的姓名是\(name)"
                
            case 1:
                return "我的年龄是\(age)"
            default:
                return "我的信息"
            }
        }
    }
    
}

// 使用方法
Person.printPeronInfo()     // 打印   我是人类
// 初始化一个实例
var person = Person(age:21,name:"HarrySun")
// 调用实例方法
person.printOwnInfo()       // 打印   姓名:HarrySun,年龄:21
person.sayHi()      // 打印   hello
// 调用实例的下标脚本
print(person[0])        // 打印   我的名字是HarrySun
print(person[1])        // 打印   我的年龄是21
// 给带有属性观察器的属性赋值
person.age = 22



// 定义一个学生继承人类
class Student:Person {
    
    // 新加属性
    var studentId:String = ""
    var schoolName:String = ""
    
    
    // 新加实例方法
    func printSchoolName() {
        
        print("我的学校是\(schoolName)")
    }
    
    // 重写父类方法
    override func printOwnInfo() {
        
        // 调用父类的方法
        super.printOwnInfo()
        print("我的学号是:\(studentId)")
        print("我的学校是:\(schoolName)")
    }
    
    
    // 重写构造函数
    override init(age:Int,name:String) {
        
        super.init(age: age, name: name)
        self.studentId = "112122"
        self.schoolName = "清华附中"
    }
    
    
    // 自定义构造函数
    init(age:Int,name:String,studentId:String,schoolName:String) {
        
        super.init(age: age, name: name)
        self.studentId = studentId
        self.schoolName = schoolName
    }
}


// 定义了一个继承人类的学生，学生有父类的一切属性，而且把父类的打印个人信息方法给重写了
Student.printPeronInfo()        // 打印   我是人类
var student = Student(age:12,name:"小马")
student.printOwnInfo()


student.studentId = "1234567"
student.schoolName = "沂南一中"
// 调用子类的方法
student.printSchoolName()       // 打印   我的学校是沂南一中
// 调用继承父类的方法
student.sayHi()     // 打印   hello
// 调用重写父类的方法
student.printOwnInfo()



var student2 = Student(age:22,name:"月月",studentId:"111222",schoolName:"德大")
// 调用子类的方法
student2.printSchoolName()      // 打印   我的学校是德大
// 调用继承父类的方法
student2.sayHi()        // 打印   hello
// 调用重写父类的方法
student2.printOwnInfo()














