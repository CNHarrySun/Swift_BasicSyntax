//
//  main.swift
//  Swift_数组&字典&集合
//
//  Created by HarrySun on 2017/1/16.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import Foundation


//swift提供了数组、Set、字典三种集合类型
//------------数组------------
//1.定义数组的2种方法
var array1:Array<String>  //定义一个String类型的
var array2:[String]  //定义一个String类型的

//2 创建一个空数组
var someInts = [Int]()
//3.使用字面量构造数组
let names:[String] = ["HarrySun","CoderSun","haozi"]

let array3 = ["浩子",18] as [Any]
//这个数组大家研究一下是不是对任意类型而言的
print(array3)

//4.两个数组相加
array1 = ["张三","李四"]
array2 = ["mik","wade"]
var array4 = array1 + array2
print(array4)

//5.获取数组的长度和遍历数组
print(array4.count)
for name in array4 {
    print(name)
}

//6.数组的增加、删除
// 6.1 元素增加
array4.append("长安")
print(array4)          // 打印 ["张三", "李四", "mik", "wade", "长安"]

// 6.2 插入到指定位置
array4.insert("haozi", at: 0)
print(array4)          // 打印 ["haozi", "张三", "李四", "mik", "wade", "长安"]

// 6.3 删除指定位置的元素
array4.remove(at: 0)
print(array4)          // 打印 ["张三", "李四", "mik", "wade", "长安"]

// 6.4 删除最后一个元素
array4.removeLast()
print(array4)          // 打印 ["张三", "李四", "mik", "wade"]

// 6.5 删除第一个元素
array4.removeFirst()
print(array4)          // 打印 ["李四", "mik", "wade"]

// 6.6 删除所有元素
array4.removeAll()
print(array4)          // 打印 []

//7.使用下标法修改数组元素


var array5 = ["北京","上海","天津","深圳"]
print("修改元素之前的array5：\(array5)")
array5[0] = "广东"
print("修改元素之后的array5：\(array5)")










//---------集合-字典---------

//1.字典的定义和创建
var airPorts:Dictionary<String,String> = ["TYO":"Tokyo","DUB":"Dublin"]
//2.字典的增加与替换
var dict = ["name":"刘德华","age":18,"height":180] as [String : Any]
print("dict：\(dict)")
//针对name的键修改
dict["name"] = "CoderSun"
print("修改name之后的dict：\(dict)")
//dict没有属性的直接加入
dict["gender"] = "男"
print("加入gender之后的dict：\(dict)")
//3.字典的合并
var dict2 = ["title":"老大"];

for (k,v) in dict2 {
    dict[k] = v;
}

print(dict)
//获取key对应的值
print("获取key对应的值：\(dict["gender"] ?? "nan")")
//移除一个key和其对应的值
dict.removeValue(forKey:"title")
print("移除一个元素之后的dict：\(dict)")

//的获取所有key和获取所有value // 
print("未强转之前的所有key:\(dict.keys)")    // 打印出来还是字典，所以这里需要强制转换下
print("强转之后的所有key:\(Array(dict.keys))")
print(Array(dict.values))

//4.编程题
//4.1创建一个数组，增加10个元素，然后遍历将每个元素输出

var array6 = [String]()
array6.append("1")
array6.append("2")
array6.append("3")
array6.append("4")
array6.append("5")
array6.append("6")
array6.append("7")
array6.append("8")
array6.append("9")
array6.append("10")
print("array6：\(array6)")


for i in array6 {
    print(i)
}

print("--------------")

//4.2创建一个整型的Set，并随机添加10个数字，然后将Set中的元素按顺序打印出来

var set1 = Set<String>()
set1.insert("1")
set1.insert("2")
set1.insert("3")
set1.insert("4")
set1.insert("5")
set1.insert("6")
set1.insert("7")
set1.insert("8")
set1.insert("9")
set1.insert("10")

for i in set1.sorted() {
    print(i)
}

print("--------------")

//4.3 创建一个字典，往里面添加5个学员的学好和姓名，然后按键值打印出来


var studentDic = Dictionary <String,String>()

studentDic["1"] = "Lucy"
studentDic["2"] = "John"
studentDic["3"] = "Smith"
studentDic["4"] = "Aimee"
studentDic["5"] = "Amanda"

for (id,name) in studentDic {
    print(id,name)
}




