import UIKit

var str = "Hello, playground"

// func 函数
func sayHello() {
    print("Hello, world.")
}
sayHello()

// 带参数的函数
func printsquare(number: Int) {
    print(number * number)
}
printsquare(number: 4)

// 返回值
func square(number: Int) -> Int {
    return number * number
}
let i = square(number: 5)
print(i)

// 如果函数内只有一行表达式，是可以不写return的，当然也可以写
func square2(number: Int) -> Int {
    number * number
}
square2(number: 6)

func nametext(name: String) -> String {
    name == "Meng Xiangjian" ? "Wow" : name
}
nametext(name: "Meng Xiangjian")

// 多返回值最好使用元组
func getUserName() -> (first: String, last: String) {
    (first: "Talor", last: "Swift")
}
getUserName().last

// 函数参数标签。可以使函数更加清晰
func setAge(for person:String, to age:Int) {
    print("set \(person) the age \(age)")
}
setAge(for: "meng", to: 32)

// 使用 _ 去掉参数标签
func greet1(_ name: String) {
    print("hello, \(name)")
}
greet1("Talor")

// 默认参数 在参数类型后面加 = {default value}
func greet(_ person: String, nicely: Bool = true) {
    if nicely {
        print("hello, \(person)")
    } else {
        print("oh, \(person) again")
    }
}

greet("Talor")
greet("Brace", nicely: false)

// 可变参数。可变参数都是一样的类型
print("hello", "world")
func squareSomeInt(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}
squareSomeInt(numbers: 1,2,3,4,5)

// throw error 在函数返回类型前面加 throws，而且throw只能是Error类型
// 谨慎使用，少用throw，在必须的时候使用。
enum SomeError: Error {
    case stupid
}

func throwAErrorWhenNecessary() throws {
    throw SomeError.stupid
}

// 调用throw函数。

do {
    try throwAErrorWhenNecessary()
} catch SomeError.stupid {
    print("stupid error")
}

// inout参数。在参数类型前加inout关键字。传入inout的参数，必须是var类型，因为可变。传递参数时使用&符号
func changeNumber(number: inout Int) {
    number *= 2
}
var num = 5 // 必须是var 不能是let
changeNumber(number: &num)
num
