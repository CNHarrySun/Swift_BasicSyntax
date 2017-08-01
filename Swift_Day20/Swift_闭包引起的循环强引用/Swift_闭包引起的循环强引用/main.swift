//
//  main.swift
//  Swift_闭包引起的循环强引用
//
//  Created by HarrySun on 2017/7/24.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import Foundation

// 除了类的实例之间会产生循环强引用之外，在闭包和类之间也可能产生强引用。这种强引用出现在将闭包赋值给类的属性，同时在闭包内部引用了这个类的实例时。究其原因，是因为闭包也是引用类型，当在闭包内部引用类的实例属性和方法时，闭包默认对类的实例拥有强引用。要解决这个问题，需要使用闭包捕获对象。

// 下面这个例子是一个实例和闭包相互之间的强引用
class Student{
    
    var name:String?
    var score:Int
    lazy var level:(Void) -> String = {
        
        switch self.score{
            
        case 0..<60:
            return "C"
        case 60..<85:
            return "B"
        case 85..<100:
            return "A"
        default:
            return "D"
        }
    }
    
    init(name:String,score:Int){
        
        self.name = name
        self.score = score
    }
    
    deinit {
        print("Student 对象：\(name!)被销毁了")
    }
}

var xiaoMing:Student? = Student(name:"小明",score:86)
print("\(xiaoMing!.name!)成绩水平为：\(xiaoMing!.level())")
xiaoMing = nil
// 当实例被赋予nil时，没有调用析构函数


// 解决这个问题我们使用捕获列表
//[weak self,unowned delegate = self.delegate]


// 下面重新写一个
class Student2{
    
    var name:String?
    var score:Int
    
    lazy var level:(Void) -> String = {
        
        [weak self] in
        switch self!.score{
            
        case 0..<60:
            return "C"
        case 60..<85:
            return "B"
        case 85..<100:
            return "A"
        default:
            return "D"
        }
    }
    
    init(name:String,score:Int){
        
        self.name = name
        self.score = score
    }
    
    deinit {
        print("Student对象：\(name!)被销毁了")
    }
}

var xiaoMing2:Student2? = Student2(name:"小明",score:86)
print("\(xiaoMing2!.name!)成绩水平为：\(xiaoMing2!.level())")
xiaoMing2 = nil

// 通过[weak self] in 在闭包创建时增加了捕获列表的定义。并且由于self可能为nil，因为是weak的弱引用，因此需要叹号解包self使用，



