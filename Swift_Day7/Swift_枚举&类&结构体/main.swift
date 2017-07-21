//
//  main.swift
//  Swift_枚举&类&结构体
//
//  Created by HarrySun on 2017/2/7.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import Foundation

// ============= 枚举

enum WeekDay1:Int {
    case Monday1 = 1
    case Tuesday1 = 2
    case Wednesday1 = 3
    case Thursday1 = 4
    case Friday1 = 5
}

enum WeekDay2:Int {
    case Monday2 = 1
    case Tuesday2
    case Wednesday2
    case Thursday2
    case Friday2
}

print(WeekDay1.Friday1)     // 打印   Friday1
print(WeekDay2.Friday2)     // 打印   Friday2

// 编程题
// 1.编写一个求圆的面积函数，并调用该函数求一个半径为10的面积
func circleSquare(radius:Double) -> Double{
    
    let pi = 3.1415927
    return radius * radius * pi
    
}
print(circleSquare(radius: 10))      // 打印   314.15927


// 2.编写一段程序，在程序中设计一个函数，并调用这个函数，实现输出8的n次方的值
func calculateNumberProduct(n:Int) -> Int{
    
    let num = 8
    var total:Int = 1
    for _ in 1...n {
        
        total *= num
    }
    
    return total
}

print(calculateNumberProduct(n: 3))      // 打印   512



// 类和结构体
// 在swift中类和结构体类似，可以把结构体理解成是一种轻量级的类，在swift中结构体不仅可以定义成员变量还可以定义方法
// 类和结构体具体类似的定义方式，分别使用关键字class和struct

class 类名{
    // 在这里定义类的内容
}

struct 结构体名 {
    // 在这里定义结构体的内容
}


// ============= 类
// 1.类的定义
class Student{
    
    var number:Int = 0
    var name:String = ""
    var age:Int = 0
    var height:Int = 0
    var weight:Int = 0
    
    func demo() {
        print("我是一个学生")
    }
}

// 2.类的实例与访问
let stu = Student()
stu.name = "小明"
stu.age = 18
stu.demo()      // 打印   我是一个学生
print(stu.name)      // 打印   小明


// ============= 结构体
// 1.结构体的定义
struct Person{
    
    var name:String = "张三"
    var age:Int = 20
}

// 2.结构体的实例和访问
let per = Person()
print(per.name,per.age)     // 打印   张三 20

// 在swift中类是引用类型和值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝，因此，引用的是已存在的实例本身而不是起拷贝
// 如果结构体和类的属性没有设置默认值，那么必须使用结构体和类的构造函数来实例化结构和类


// 3.定义一个结构体汽车
struct Car{
    
    var name:String
    var year:Int
    var color:String
    
    // 结构体也可以定义方法
    func colorCar() -> String {
        
        return color
    }
}

var car = Car(name:"奔驰",year:2,color:"red")
// 这里使用逐一构造函数为Car的结构体赋属性值，需要注意，这里所赋值必须要和结构体中的成员顺序一致

// 结构体的方法必须用实例调用
print(car.colorCar())       // 打印   red


// >结构体是属于值类型的，和类不一样，类是术语引用类型，在swift中，整形、浮点型、布尔值、字符串、数组、字典都是值类型
// >在swift中只有类是引用类型，其余一切都是值类型，所有结构体的实例，以及实例中所包含的任何值类型属性，在代码中传递的时候都会被复制

var car2 = car
car2.color = "green"    // 因为是值的拷贝，不是引用所有car的color还是red，而car2是green了
print(car2.colorCar())       // 打印   green
print(car.colorCar())       // 打印   red

var student2 = stu
var student3 = Student()

if student2 === student3 {
    
    print("引用同一个实例")
}else{
    print("引用不同实例")       // 打印   引用不同实例
}







