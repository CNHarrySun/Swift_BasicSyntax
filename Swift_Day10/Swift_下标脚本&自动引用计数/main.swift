//
//  main.swift
//  Swift_下标脚本&自动引用计数
//
//  Created by HarrySun on 2017/2/9.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import Foundation


// ==========下标脚本
// 下标脚本是访问对象、集合或者序列的快捷方式，开发者不需要调用实例指定的赋值和访问语法，就可以直接访问所需的数值，例如perArray[index]、perDictionary[index]

// 现在在类中我们定义一个小标语法，用关键字subscript
class NumberOfPeople{
    
    var principalNumber:Int = 0
    var teacherNumber:Int = 0
    var studentNumber:Int = 0
    
    subscript(index:Int) -> Int{
        
        get{
            switch index{
            case 0:
                return principalNumber
            case 1:
                return teacherNumber
            case 2:
                return studentNumber
            default:
                return 0
            }
        }
        
        set{
            switch index{
            case 0:
                return principalNumber = newValue
            case 1:
                return teacherNumber = newValue
            case 2:
                return studentNumber = newValue
            default:
                return
            }
        }
    }
}

// 实例对象
var personNumber = NumberOfPeople()

// 下角标的使用
personNumber[0] = 1
personNumber[1] = 20
personNumber[2] = 100

for i in 0...2{
    
    print(personNumber[i])
}


print("-----------")

// ==========自动引用计数
// 1.引用简介
class Person{
    
    var name:String
    init(name:String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitalized")
    }
}

// 定义三个可选类型的Person，初始化自动为nil
var person1:Person?
var person2:Person?
var person3:Person?

person1 = Person(name:"Harry")  // 引用数量为1
person2 = person1   // 引用数量为2
person3 = person1   // 引用数量为3


// 此时Person的实例person已经有了三个强引用了
person1 = nil   // 引用数量为2
person2 = nil   // 引用数量为1
person3 = nil   // 引用数量为0 此时最后一个抢引用断开，所以就会调用析构函数deinit


// 2.类实例之间的循环强引用
// 在上面的例子中，ARC会跟踪你所创建的Person实例的引用数量，并且会在Person实例不再被需要时销毁它
class Person2{
    
    let name:String
    init(name:String) {
        
        self.name = name
    }
    var apartment:Apartment2?
    deinit {
        print("\(name) is being deinitialized")
    }
}
class Apartment2 {
    
    let unit:String
    init(unit:String) {
        
        self.unit = unit
    }
    var tenant:Person2?
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

var john:Person2?
var unit4A:Apartment2?

john = Person2(name:"John Appleseed")
unit4A = Apartment2(unit:"4A")

// 这里就造成了循环引用
john!.apartment = unit4A
unit4A!.tenant = john

john = nil      // 这里由于强引用互相持有，不能释放

// 3.弱引用
// 不幸的是，这两个实例关联后会产生一个循环强引用，对象各自之间相互持有，我们可以用弱引用或无主引用
// swift提供了两种办法用来解决你在使用类的属性时所遇到的循环强引用问题：弱引用（weak reference）和无主引用（unowned reference）。弱引用不会对其引用的实例保持强引用，因为不会阻止ARC销毁被引用的实例。这个特性阻止了引用变为循环强引用。声明属性或者变量时，在前面加上weak关键字表明这是一个弱引用。
class ApartmentL{
    
    let unit:String
    init(unit:String) {
        self.unit = unit
    }
    weak var tenant:PersonL?    // 注意这里是一个weak 表示弱引用
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

class PersonL {
    
    let name:String
    init(name:String) {
        self.name = name
    }
    
    var apartment:ApartmentL?
    deinit {
        print("\(name) is being deinitialized")
    }
}

var johnl:PersonL?
var unit4Al:ApartmentL?

johnl = PersonL(name:"John Appleseed --- l")
unit4Al = ApartmentL(unit:"4A")

johnl!.apartment = unit4Al
unit4Al!.tenant = johnl

johnl = nil     // 这里的johnl就可以释放掉了
unit4Al = nil
// PersonL实例依然保持对ApartmentL实例的强引用，但是ApartmentL实例只是对PersonL实例的弱引用。这意味着当你断开johnl变量所保持的强引用时，再也没有指向PersonL实例的强应用了


// 4.无主引用
// 和弱引用类似，无主引用不会牢牢保持住引用的实例。和弱引用不同的是，无主引用是永远有值的。因此，无主引用总是被定义为非可选类型（nonoptional type）。你可以在声明属性或者变量时，在前面加上关键字unowned表示这是一个无主引用。
// 由于无主引用是非可选类型，你不需要在使用它的时候将它展开。无主引用总是可以被直接访问。不过ARC无法在市里被销毁后将无主引用设为nil，因此非可选类型的变量不允许被赋值为nil

class Customer{
    
    let name:String
    var card:CreditCard?
    init(name:String) {
        
        self.name = name
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

class CreditCard{
    
    let number:UInt64
    unowned let customer:Customer
    init(number:UInt64,customer:Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("Card #\(number) is being deinitalized")
    }
}

var johns:Customer?
johns = Customer(name:"John Appleseed --- s")
johns!.card = CreditCard(number:1234_5678_9012_3456,customer:johns!)
johns = nil




