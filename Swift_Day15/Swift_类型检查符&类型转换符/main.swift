//
//  main.swift
//  Swift_类型检查符&类型转换符
//
//  Created by HarrySun on 2017/3/27.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import Foundation


//// 类型检检查符is
//// 类型检查操作符is，可以检查一个对象是不是某个类的对象，如果是，则返回true，否则返回false
//class Person{
//    
//    var name:String?
//    init(name:String) {
//        
//        self.name = name;
//    }
//}
//
//class Employee: Person {
//    
//    var company:String
//    init(name:String,company:String) {
//        
//        self.company = company
//        super.init(name: name)
//    }
//}
//
//class Student: Person {
//    
//    var school:String?
//    init(name:String,school:String) {
//        
//        self.school = school
//        super.init(name: name)
//    }
//}
//
//let employee1 = Employee(name:"张三",company:"apple公司")
//let employee2 = Employee(name:"李四",company:"google公司")
//
//let student1 = Student(name:"小明",school:"中关村一小")
//let student2 = Student(name:"小花",school:"中关村二小")
//let student3 = Student(name:"小路",school:"中关村二小")
//
//let members = [employee1,employee2,student1,student2,student3];
//
//var employeeCount = 0
//var studentCount = 0
//
//for item in members{
//    
//    if item is Employee{
//        employeeCount += 1;
//    }else if item is Student{
//        studentCount += 1;
//    }
//    
//}
//
//print("职员的人数：\(employeeCount)人")        // 打印   职员的人数：2人
//print("学生的人数：\(studentCount)人")         // 打印   学生的人数：3人



// 类型转换as操作符
// 类型转换时将一个类型转换为另外一个类型，但是前提是有继承关系的，对象的类型之间才可以转换，将子类转换成父类，是向上转换，一般都会转换成功，将父类转换成子类是向下转换，可能会失败
// 类型转换的操作符有两种形式：as？和as！，条件形式as？返回目标类型的可选值，强制形式as！把向下转型和强制解包转型结果结合为一个操作

// as！操作符是类型转换的强制格式，优点在于代码简单，如果可以转换，则会返回转换了格式的对象，如果无法转换就会抛出运行时错误。因此除非百分之百确定可以转换，否则不应该使用as！来进行强制类型转换。

// 和is操作符非常类似，类型转换的规则是，某个类的对象可以转换为自己这个类（这个其实是废话），子类可以向上转换为超类，但超类不能向下（downcast）转换为子类。除非某个子类的对象表现形式为超类，但实际是子类，这时可以使用as！进行向下转换（downcast）。

class MediaItem{
    
    var name: String
    init(name: String) {
        
        self.name = name
    }
}

class Movie: MediaItem {
    
    var director: String
    init(name: String, director: String) {
        
        self.director = director
        super.init(name: name)
    }
}
class Song: MediaItem {
    
    var artist: String
    init(name: String, artist: String) {
        
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]


var movieCount = 0
var songCount = 0

for item in library {
    if let movie = item as? Movie {
        print("Movie: '\(movie.name)', dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: '\(song.name)', by \(song.artist)")
    }
}


// 首先试图将 item 下转为 Movie 。因为 item 是一个 MediaItem 类型的实例，它可能是一个 Movie ;同样，它也可能是一个 Song ，或者仅仅是基类 MediaItem 。因为不确定， as? 形式在试图下转时将返回 一个可选值。 item as? Movie 的返回值是 Movie? 或者说“可选 Movie ”。
// 当向下转型为 Movie 应用在两个 Song 实例时将会失败。为了处理这种情况，上面的例子使用了可选绑定(op tional binding)来检查可选 Movie 真的包含一个值(这个是为了判断下转是否成功。)可选绑定是这样写 的“ if let movie = item as? Movie ”，可以这样解读:
// “尝试将 item 转为 Movie 类型。若成功，设置一个新的临时常量 movie 来存储返回的可选 Movie 中的 值”
// 若向下转型成功，然后 movie 的属性将用于打印一个 Movie 实例的描述，包括它的导演的名字 directo r 。相似的原理被用来检测 Song 实例，当 Song 被找到时则打印它的描述(包含 artist 的名字)。


// 注意
// 转换没有真的改变实例或它的值。根本的实例保持不变;只是简单地把它作为它被转换成的类型来使用。



// as！使用场合
// 向下转型（Downcasting）时使用。由于是强制类型转换，如果转换失败会报运行错误。
class Animal {
    
}

class Cat: Animal {
    
}

let animal:Animal = Cat()
let cat = animal as! Cat
print("as! --- \(cat)")


// as？使用场合
// as? 和 as! 操作符的转换规则完全一样。但 as? 如果转换不成功的时候便会返回一个 nil 对象。成功的话返回可选类型值（optional），需要我们拆包使用。
// 由于 as? 在转换失败的时候也不会出现错误，所以对于如果能确保100%会成功的转换则可使用 as!，否则使用 as?

let animal1:Animal = Cat()
if let cat = animal1 as? Cat{
    
    print("as？ --- \(cat)")
}else{
    
    print("cat is nil")
}





