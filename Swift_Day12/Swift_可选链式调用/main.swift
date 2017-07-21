//
//  main.swift
//  Swift_可选链式调用
//
//  Created by HarrySun on 2017/2/10.
//  Copyright © 2017年 Mobby. All rights reserved.
//

import Foundation

// 1.可选链式调用属性

// 可选链式调用（Optional Chaining）是一种可以在当前值可能为nil的可选值上请求和调用属性、方法以及下标的方法。如果可选值有值，那么调用就会成功；如果可选值是nil，那么调用将返回nil。多个调用可以连接在一起形成一个调用链，如果其中任何一个节点为nil，整个调用链都会失效，即返回nil

//class Person{
//    
//    var residence:Residence?
//}
//// Person具有一个可空的residence属性，其类型为Residence？
//
//class Residence{
//    
//    var numberOfRooms = 1
//}
//let john = Person()
//
//// 如果使用感叹号（!）强制展开获得这个john的residence属性中的numberOfRooms，会触发运行时错误，因为这时residence没有可以展开的值；
////let roomCount = john.residence!.numberOfRooms  // 如果residance是空，这里就会报错
//
//
//// 通过在想调用的属性、方法或下标的可选值（optional value）后面放一个问号（?）
//let roomCount1 = john.residence?.numberOfRooms  // 返回一个nil
//
//
//// 在不确定residence有没有值的时候要判断一下
//if let roomCount = john.residence?.numberOfRooms {
//    
//    print("John's residence has \(roomCount) rooms.")
//}else{
//    
//    print("Unable to retrieve the number of rooms.")
//}
//
//// 下面进行赋值
//john.residence = Residence()
//// 这样就可以正常访问了
//let roomCount = john.residence!.numberOfRooms
//print(roomCount)




// ------------------------------------------------------------------------------



// 2. 可选链式调用定义模型类
// 通过使用可选链式调用可以调用多层属性、方法和下标。这样可以在复杂的模型中向下访问各种子属性，并且判断能否访问子属性的属性、方法或下标。

class Person{
    
    var residence:Residence?
}

class Residence{
    
    var rooms = [Room]()
    
    var numberOfRooms:Int{
        
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        
        get{
            return rooms[i]
        }
        set{
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms(){
        
        print("The number of rooms is \(numberOfRooms)")
    }
    
    var address:Address?
}

class Room{
    
    let name:String
    init(name:String) {
        self.name = name
    }
}

class Address{
    
    var buildingName:String?
    var buildingNumber:String?
    var street:String?
    
    func buildingIdentifier() -> String? {
        
        if buildingName != nil {
            
            return buildingName
        }else if buildingNumber != nil && street != nil{
            
            return "\(buildingNumber)\(street)"
        }else{
            
            return nil
        }
    }
}





// 3.通过可选链式调用访问属性
let john = Person()
john.residence = Residence()

if let roomCount = john.residence?.numberOfRooms {
    
    print("John's residence has \(roomCount) rooms.")
}else{
    
    print("Uable to retrieve the number of rooms")
    // 因为john的residence属性是nil 所以走下面这个
}


let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress

// 因为john.residence为nil，所以这个可选链式调用依旧会像先前一样失败
func createAddress() -> Address{
    
    print("Function was called.")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}

john.residence?.address = createAddress()
// 因为john.residence为nil，所以这个可选链式调用依旧会像先前一样失败

// 可选链式调用失败时，等号右侧的代码不会被执行


print("--------------------------")



// 4.通过可选链式调用方法
// 如果在可选值上通过可选链式调用来调用这个方法，该方法的返回值会是Void?，而不是Void，因为通过可选链式调动得到的返回值都是可选的
// 这样通过判断返回值是否为nil可以判断调用是否成功。
if john.residence?.printNumberOfRooms() != nil{
    
    print("It was possible to print the number of rooms.")
}else{
    
    print("It was not possible to print the number of rooms.")
}

if (john.residence?.address = someAddress) != nil{
    
    print("It was possible to set the address.")
}else{
    
    print("It was not possible to set the address.")
}


print("--------------------------")



//// 5.通过可选链式调用访问下标
//if let firstRoomName = john.residence?[0].name{
//    
//    print("The first room name is \(firstRoomName).")
//}else{
//    
//    print("Unable to retrieve the first room name/")
//}
// john.residence为nil，所以下标调用失败了
//john.residence?[0] = Room(name:"Bathroom")
// 这次赋值同样会失效，因为residence目前是nil

// 如果你创建一个Residence实例，并为其rooms数组添加一些Room实例，然后将Residence实例赋值给john.residence，那就可以通过可选链式和下标来访问数组中的元素。
let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name:"Living Room"))
johnsHouse.rooms.append(Room(name:"Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name{
    
    print("The first room name is \(firstRoomName).")
}else{
    
    print("Unable to retrieve the first room name.")
}


print("--------------------------")



// 6.访问可选类型的下标
// 如果下标返回可选类型值，比如Swift中Dictionary类型的键的下标，可以在下标的结果括号后面放一个问号来在其可选返回值上进行可选链式调用。
var testScores = ["Dave":[86,82,84],"Bev":[79,94,81]]
testScores["Dave"]?[0] = 91 // 调用成功
testScores["Bev"]?[0] += 1  // 调用成功
testScores["Brian"]?[0] = 72    // 调用失败，testScores字典中没有“Brian”这个键
print(testScores)


print("--------------------------")



// 7.连接多层可选链式调用
// 可以通过连接多个可选链式调用在更深的模型层级中访问属性、方法以及下标。然而，多层可选链式调用不会增加返回值的可选层级
/*
 也就是说：
 如果你访问的值不是可选的，可选链式调用调用将会有可选值。
 如果你访问的值就是可选的，可选链式调用不会让可选返回值变得“更可选”。
 因此：
    通过可选链式调用访问一个Int值，将会返回Int?，无论使用了多少层可选链式刁颖。
    类似的，通过可选练市调动访问Int?值，依旧会返回Int?值，并不会返回Int??。
 */

if let johnSterrt = john.residence?.address?.street{
    
    print("John's street name is \(johnSterrt).")
}else{
    
    print("Unable to retrieve the address.")
}
// 打印 Unable to retrieve the address.




// 未看

let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john.residence?.address = johnsAddress   //residence在上面已经创建过了，john.residence包含一个有效的Residence实例，所以对john.residence的address属性赋值将会成功。

if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}



print("--------------------------")




//8.在方法的可选返回值上进行可选链式调用
//我们还可以在一个可选值上通过可选链式调用来调用方法
if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}



if let beginsWithThe =
    john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier does not begin with \"The\".")
    }
}






