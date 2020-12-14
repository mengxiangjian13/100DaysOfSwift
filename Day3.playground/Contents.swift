import UIKit

var str = "Hello, playground"

// + 操作符 在不同类型数据的不同意义 operator overloading

let i1 = 1
let i2 = 2
let i = i1 + i2

let s1 = "hello"
let s2 = "world"
let s = s1 + s2

let a1 = [2,3]
let a2 = [1,4]
let a = a1 + a2

// 复合操作符 += -=

var ss = "i love"
ss += " China"

// 比较操作符
i1 < i2
s1 >= s2

// enum也可以比较
enum Direction: Comparable {
    case east
    case west
    case north
    case south
}

// 因为north在east后面声明
Direction.north > Direction.east

/// 条件 if else if else
/// 联合条件 && ||

/// 三元操作符
let tri = i1 > 3 ? "hello" : "world"

/// switch

/// range 条件 ... ..<
switch i {
case 1..<5:
    print("i 小于5")
default:
    print("i 大于等于5")
}

a[1..<3]
a[1...]
