//
//  main.swift
//  Swift_基本数据类型1
//
//  Created by HarrySun on 2017/1/3.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import Foundation


////----------声明一个变量打印---------------------
//var start:String;
//start = "Hello world"
//print(start)
//start = "HarrySun"
//print(start)
//
//
////var name   // 这样声明编译报错，要么说明类型，要么赋值，让编译器自动判断类型。
//
//
//
//var start2 = "hello world"  //自动判断为String,
//print(start2)
////start = 10  //因为start被自动判断为String，所有start被赋值10，会编译出错
//
//
//
//let a:Int = 10
//let b = 10  //类型自动判断为Int
//let c = 100,d = 20, e = 30
//print(e)
//
//
//let width = 100.0  //类型自动判断为Double
//print(width)
//
//
////----------------数据类型的显式转换-----------------
//
//let numA = 10
//let numB = 20.5
////let num1 = numA + numB // 这里会系统自动报错因为，系统不会自己进行隐式类型转换，必须手动的进行显式转换。
//
//let num1 = numA + Int(numB)
//let num2 = Double(numA) + numB;
////此时得到的num1和num2类型完全不一样，num1是Int类型，而num2是Double类型的
//
////------在swift中，不允许任何形式的数据类型自动转换，只能强制转换---------
//
//
//
//
////常量和变量的输出
////--------------1.直接输出---------------------------
//let name = "HarrySun"
//print(name)
//
//let 浩子 = "haozi"  //汉字和图片表情都可以作为变量名
//print(浩子)
//
//var 😁 = "笑"          //汉字和图片表情都可以作为变量名
//print(😁)
//
//let 😭 = 100         //汉字和图片表情都可以作为变量名
//print(😭)
//
////--------------2.输出多个变量-----------------------
//
//print(😁,😭)
//print(name,浩子)
////--------------------------------------------------
//
//
//
//
////--------------3.使用占位符将变量或者常量加入到字符串中输出
//let city = "Beijing"
//print("welcome to \(city)")
//
//
//print("\(😁) 一个")
////--------------------------------------------------
//
//
////--------------4.将上面组合输出-------------
//print("欢迎来到\(city),来，\(😁)一个,",浩子)
//
////--------------------------------------------------





//
//
//
//
//
////--------------------简单数据类型----------------------
//
////1.整形:分为有符号和无符号的整形，也分为8位，16位，32位的，64位的，这不同位的和平台*没有*任何关系,只有Int和UInt与平台有关系
//
//let minA = UInt8.min  //获取无符号的8位数的最小值，
//let maxA = UInt8.max  //获取无符号的8位数的最小值，
//let numB:UInt16 = 100
//print(numB)
//
////var maxC:UInt8 = 289  //编译报错，因为289超出255最大值的值
//var maxC:UInt8 = 240
//print(maxC)
//
////浮点型 Double和Float,   Double是64位浮点型编译器根据自动判断的类型，也是系统默认的类型，如何要用Float（32位低精度浮点型）,在定义变量时必须说明Float
//let  width = 100.5   //width 默认Double
//let height:Float = 20  //height是Float的低精度浮点型，具体值是20.0
////----------------------------------------------------
//
//
////常见提示-------以下都是正确的表示，为了提高数值的易读性--------
//let a = 3_500_000  //此时的a是3500000下划线是分隔数值用的
//print(a)  //编译通过
//
//var b = 003.5  //此时的b是3.5
//
//var c = 1.25e2 //表示1.25 * 10^2 等于 1.25*100 就是125
////----------------------------------------------------
//
//
//
////Bool 布尔类型，在oc中非0即真，但是在swift只有2个值属于Bool类型 就是false和true
//let hasResult = true
//var hasError = false
////----------------------------------------------------











//------可选类型--------

//1.可选常量  let 常量名 :常量类型？ = 常量值
let a:Int?
//声明可选常量必须指定常量的常量类型，常量类型可以是任何类型的数值，也可以是nil，等以后再赋值
//print(a) 这里编译报错，因为可选常量a 没有赋值  在使用前必须进行赋值

//------2.可选变量--------
//var 变量名：变量类型 = 变量值
//var b:Int
//print(b)  这里会编译出错，因为b是Int没有赋值，使用时要赋值，如果是Int可选类型，这里就可以编译通过，表示nil

var c:Int?
print(c)

var d:Int? = 10  //给可选变量赋值以后，   它的值就是实际值
print(d)

var e:Int? = 10
e = nil

//只有可选类型可以赋值，非可选类型不能赋值,例如下班这个会报错
var f:Int = 100
//f = nil  此时编译报错   所有说只有可选型类型可以为nil 其他都不可以


//--------3.解包-------

var g:Int? = 10
//print(10 + g)  此时编译报错，可以可选类型不能直接参与计算
//此时就需要解包，“！”

print(g!+10) //这样就编译通过了进行解包就可以用参与运算，但是这里的前提是可选类型必须有实际值，如果为nil，就不能解包参与运算，例如下面

//print(10 + c!) 编译失败，因为c为nil ，所有在强制解包时 一定要保证可选类型非nil的，方法是通过if语句提前进行判断；不然解包不安全，程序会crash掉


var name: String? = "loveway"
if name != nil {
    print("My name is " + name!)
} else {
    print("name is nil")
}

//判空可以解决这个不安全问题，但是这样写比较麻烦，可以用if let 解包

var name2:String? = "HarrySun"
if let name3 = name2 {
    
    print("My name is " + name3)   //这里面只能用if let 解包后的常量名
}else
{
    print("name is nil")
}



var book:String? = nil
if let book2 = book {
    
    print("Book name is " + book2)   //这里面只能用if let 解包后的常量名
}else
{
    print("book name is nil")
}


//-------4.隐式解析可选类型-------
//对于可选类型每次解包再参与试用特别麻烦，所有就定了了一个隐式解析一下可选类型，
//隐式解析可选类型本质是一个可选类型，被当做一个自动解析的可选类型，然后就可以被当做非可选类型有值得时候

//下面是声明隐式解析的可选常量和变量

var numA:Int! = 10
let numB:Int! = 200

//下面看一下，可选类型的定义和使用，以及隐式解析可选类型的定义和使用
let schoolName:String? = "北京大学"
print(schoolName!)

let schoolName2:String! = "清华大学"
print(schoolName2)

//由于隐式解析可选类型本质是可选类型，除了在使用的时候不用每次解包取值之外，其他特征和
//隐式解析可选类型不能设为nil，使用的时候也要进行if判断

if schoolName2 != nil {
    print("学生名称")
}

//-------------空合并运算符 "？？"---------

let numC:Int? = nil
print(numC ?? 0) // 这里就是说明如果可选类型为nil时，numC就去后面的默认值0
//空合并运算符有2个条件：表达式a必须是可选型，默认值数据类型必须和a值的数据类型一致








