//
//  main.swift
//  Swift_字符&字符串
//
//  Created by HarrySun on 2017/1/16.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import Foundation

//1.Character 字符类型

let avr:Character = "值"
print(avr)
let ch:Character = "A"

let ch2:Character = "\\"

//2.String 类型

let str1 = "HelloWorld"
var str2 = String()  //通过创建实例的方式初始化字符串
print(str1)
print(str2)

//判断字符串为空

if str2.isEmpty {
    print("空的")
}

//3.swift中计算字符串的长度和oc不一样
print(str2.characters.count) //字符串的长度

//4.遍历字符串
for c in str1.characters {
    print(c)
}

//5.连接字符串 (比oc简单很多)
str2 = ",Coder_Sun"
var str3 = str1 + str2
print(str3)
str3 += ",haihai"
print(str3)

str3.append(avr)

//6.字符串的插值
//通过占位符给字符串加入一段字符串或值

let num = 10
let message = "\(num)乘以2.5等于\(Double(num)*2.5)"
print(message)

//7.格式化字符串

let hour = 8
let minute = 10
let seconds = 56
let time = String(format:"%02d:%02d:%02d",hour,minute,seconds)
print(time)

//8.字符串的截取
//swift 字符串截取比较麻烦所有转化为oc中的NSString
let subStr3 = (str3 as NSString).substring(with: NSMakeRange(1,5))
print(subStr3)

//9.用等号判断两个字符串是否相等

let name1 = "浩子"
let 😁 = "浩子"
let name3 = "昊子"

let 名字 = "皓子"

if 😁 == name1 {
    print("同一名字")
}

//10.比较字符串的前缀和后缀


let strName = "CoderSun"
let strName2 = "zhangsan"
let strName3 = "liuwu"


// 字符串a前缀是否包含b
if strName.hasPrefix("Coder") {
    print("开发")
}

if strName3.hasPrefix("liu") {
    print("刘")
}

// 字符串a后缀时候包含字符串b
if strName2.hasSuffix("san") {
    print("三")
}

// String和NSString
// 1.String是一个结构体类型，而NSString是一个继承自NSObject对象
// 2.二者都可以使用自己的类名来直接进行初始化，表面上看写法相同，但是NSString的意思是初始化了一个指针方向了这个字符串，但是String是把字符串的字面量赋值给常量或变量


