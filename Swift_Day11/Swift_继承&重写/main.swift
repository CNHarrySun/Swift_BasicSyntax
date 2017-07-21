//
//  main.swift
//  Swift_继承&重写
//
//  Created by HarrySun on 2017/2/9.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import Foundation

// 继承
// 继承就是子类继承父类的属性、方法、下角标
class Person{
    
    var name:String
    var age:Int
    init(name:String,age:Int) {
        
        self.name = name
        self.age = age
    }
    
    func printName(){
        print("姓名:\(name) 年龄:\(age)")
    }
}

var onePerson = Person(name:"HarrySun",age:21)
print(onePerson.name,onePerson.age)     // 打印   HarrySun 21


// 现在以父类Person继承一个子类教师
class Teacher:Person{
    
    var teacherID:Int = 0
    var schollName:String = ""
    
    func printSchoolName(){
        
        print("老师所在学校:\(schollName)")
    }
}
// 这里的老师类继承了属性name、age和方法printName，还有构造函数
var oneTeacher = Teacher(name:"刘老师",age:30)
oneTeacher.printName()  // 打印   姓名:刘老师 年龄:30
oneTeacher.schollName = "北京大学"
oneTeacher.printSchoolName()  // 打印   老师所在学校:北京大学

oneTeacher.name = "王老师"
oneTeacher.age = 40
print(oneTeacher.name,oneTeacher.age)   // 打印   王老师 40



// 我们可以继续再继承，往下可以定义一个英语老师
class EnglishTeacher:Teacher{
    
    var englisLevel:String = ""
    
    func printEnglishLevel(){
        
        print(englisLevel)
    }
}

// 英语老师继承了Teacher继承于人的所有东西和自己添加的新属性和方法
var oneEnglishTeacher = EnglishTeacher(name:"John",age:25)
oneEnglishTeacher.name = "LEO"
oneEnglishTeacher.printName()   // 打印   姓名:LEO 年龄:25
oneEnglishTeacher.englisLevel = "8级"
oneEnglishTeacher.schollName = "哈佛大学"
oneEnglishTeacher.teacherID = 20170209
oneEnglishTeacher.printEnglishLevel()   // 打印   8级
print(oneEnglishTeacher.teacherID)      // 打印   20170209



print("-----")


// 重写
// 子类可以为集成来的实例方法、类方法、实例属性或下标脚本提供自己的定制实现。我们把这种行为叫重写（overriding）。
// 要重写某个特性，在前面使用关键字override
class Person2{
    
    var name:String
    var age:Int
    init(name:String,age:Int) {
        
        self.name = name
        self.age = age
    }
    
    func printInfo(){
        
        print("姓名：\(name)，年龄：\(age)")
    }
}

class Teacher2: Person2 {
    
    var schoolName:String
    var teacherLevel:Int
    
    init(name:String,age:Int,schoolName:String) {
        
        
        self.teacherLevel = 10
        self.schoolName = schoolName    // 这个属性要写的前面
        super.init(name: name, age: age)
    }
    
    
    override var name: String{
        
        get{
            
            return super.name
        }
        set{
            
            super.name = "HarrySun"
        }
    }
    
    
    // 重写是方法名和参数还有返回值一致
    // 这个重写方法是加了一个学校信息的输出
    override func printInfo() {
        
        super.printInfo()
        print("学校名称：\(self.schoolName)")
    }
    
    // 用final定义表示防止子类重写
    final func printTeacherLevel(){
        
        print("老师等级\(self.teacherLevel)")
    }
}

var oneTeacher2 = Teacher2(name:"刘老师",age:30,schoolName:"清华大学")
oneTeacher2.printInfo()     // 打印姓名：刘老师，年龄：30   学校名称：清华大学
// 打印结果

class EnglishTeacher2: Teacher2 {
    
    var englishLevel:Int = 0
    
//    override func printTeacherLevel(){
//        
//        print("老师等级\(self.teacherLevel)")
//    }
//    // 这里会报错，因为这个printTeacherLevel在父类是禁止重写的
}

var oneEnglishTeacher2 = EnglishTeacher2(name:"John",age:32,schoolName:"临沂大学")
oneEnglishTeacher2.englishLevel = 8
print(oneEnglishTeacher2.englishLevel)  // 打印   8

oneEnglishTeacher2.name = "Sun"
print(oneEnglishTeacher2.name)  // 打印   HarrySun


