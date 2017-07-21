//
//  main.swift
//  Swift_条件语句&循环语句
//
//  Created by HarrySun on 2017/1/4.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import Foundation

////------条件语句---------
//// swift的条件语句在写法和新功能有什么特殊的来了解一下
//
//// 1.if语句
//// if 条件语句 {}  这里条件语句的值必须是Bool类型，Bool类型就两个值，要么是true和false，这和c/oc不一样，不像他们非0就真，这里必须是一个Bool值
//
//let result:Bool = true
//
//if result {
//    
//    print("有结果的")
//}
//
//// 这里条件语句可以不用小括号（）包起来，当然包起来也是可以编译通过的，下面例子
//
//if (result) {
//    
//    print("有结果的")
//}
//
//
//// 这里的{}是不能省略的，这和oc不一样，oc是在条件语句之后如果只有一条执行语句的时候，可以省去{},但是在swift里。不管几条执行语句必须带有{}
//
//// if result
//// print("hi")
//
//
//// 2.if else   这块看一眼就行，很简单
//
//if result {
//    print("有结果的")
//}else{
//    print("没结果的")
//}
//
//
//// 3.else-if
//
//var age = 20
//
//if age > 65 {
//    
//    print("老年人")
//}else if age > 40{
//    
//    print("中年人")
//}else if age > 20{
//    
//    print("青年人")
//}else{
//    
//    print("少年")
//}
//
//// 4.if let
//// if let 在上次的可选类型中说到，是对可选类型判断使用的
//// if let 常量名 = 可选类型变量或常量{}，  在{}中用常量名参与使用
//
//
//let oAge:Int? = 20
//
//if let age = oAge {
//    
//    print("有值")
//}
//
//
//
//// 5.guard语句,学这个语句开始貌似没啥用处，但是网上看到一个哥们提到：guard只有在条件不满足的时候才会执行这段代码。你可以把guard近似的看做是Assert，但是你可以优雅的退出而非崩溃。
//
//
//var numA = 10
//
////guard numA > 100 else {
////
////    print("numA 不大于100")
////    break
////}
//
//
//
//func getAge(age:Int?)
//{
//    if age == nil || age! < 0 {
//        
//        return
//    }
//}
//
//
//func getAge2(age:Int?)
//{
//    guard age! < 0 else {
//        print("xxxxxx");
//        return;
//    }
//}
//
//var age3:Int? = 30
//getAge2(age: age3)
//
/////////-------------------------------------
//
//
//
//func getName(name:String)
//{
//    
//    if name.characters.count > 100 {
//        
//    }else{
//        
//        print("字符串太长")
//    }
//}
//
//
//func getName2(name:String)
//{
//    
//    guard name.characters.count < 100 else {
//        return
//    }
//    print("字符串太长")
//    
//}
//
//getName2(name: "HarrySun")
//
//// guard 在else中一定要有返回语句，与return、break、continue、throw要退出的关键字结合使用
////--------------------------------------------








//-------switch------
// swift会自动在case结尾处加上break
/*
 switch (表达式) {
 case 常量表达式1:
 语句1
 case 常量表达式2:
 语句2
 case 常量表达式3:
 语句3
 default:
 语句n
 }
 
 表达式可以为多种数据类型，整形、字符串、布尔、浮点型、元组等，也支持区间运算符
 */

let coordinate1 = (0,1)

switch coordinate1 {
case (0,0):
    print("原点")
case (_,0):
    print("x轴")
case (0,_):
    print("x轴")
default:
    print("没有到达这个区域")
}
// 如果上面的case没有列举完全，那就必须用default包含未包含的部分,如果把下面的default注释掉会报错

// 下面在不用default的条件下把所有情况包括


// 支持元组类型
switch coordinate1 {
case (0,0):
    print("原点")
case (let x,0):
    print("x轴")
case (0,let y):
    print("x轴")
case (let x,let y):
    print("非原点和x轴有轴之外的点")
    
}


// 下面这个代码
switch coordinate1 {
case (let x,let y):
    print("所有区域")  // 被输出  // 下面case不被执行
case (0,0):         // Case will never be executed
    print("原点")
case (let x,0):
    print("x轴")
case (0,let y):
    print("x轴")
}


// 字符串
let str:String = "HarrySun"
switch str {
case "lianglinag":
    print("liangliang")
case "HarrySun":
    print("HarrySun") // 被输出
default:
    print("haozi")
}


// 浮点
let width = 2.4
switch width {
case 1.4:
    print(1.4)
case 2.4:
    print(2.4) // 被输出
case 3.4:
    print(3.4)
default:
    print("没找到")
}


// 区间
var i = 15
switch i {
case 0 ... 10:
    print("0~10")
case 11 ... 20:
    print("11~20") // 被输出
default:
    print("default")
}





print("------------------------------------------------------------------------------------")




//fallthrough 关键字表示继续往下判断
let age = 18

switch age {
case 10...20:
    print("1")        // 被输出
    fallthrough
case 15...30:
    print("2")        // 被输出
default:
    print("3")
}


//但是加了fallthrough语句后，【紧跟的后一个】case条件不能定义常量和变量


switch coordinate1 {
case (0,0):
    print("原点")
//    fallthrough //加了fallthrough 紧跟后面的一个case有定义常量，就会报错
    
// 'fallthrough' cannot transfer control to a case label that declares variables
case (let x,0):
    print("x轴")
case (0,let y):
    print("x轴")
case (let x,let y):
    print("非原点和x轴有轴之外的点")
    
}










