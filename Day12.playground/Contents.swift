import UIKit

var str = "Hello, playground"

// optionals

// unwrap
let a :Int? = 3
if let aa = a {
    print("let's see aa is \(aa)")
}

// guard let 和 if let 最大的区别，就是guard let在其之后，还可以使用unwrap的值。

func guardlet() {
    var name: String? = nil
    name = "meng"
    guard let myname = name else {
        print("no name")
        return
    }
    
    print("my name is \(myname)")
}
guardlet()

// force unwrap !
let number = "5"
let n = Int(number)
print("\(n)")
n!

// implicitly unwrap optional
var iup: String! = nil
iup = "hh"

func username(for id:Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}

let user = username(for: 15) ?? "HAHA" // ?? 前面如果不是nil则unwrap，如果是nil则取后面的值

// optional chaining
let stringArray = ["a", "b", "c", "d"]
let firstOne = stringArray.first?.uppercased() // 如果first有值，则大写。如果没有值，则返回nil

// optional try. try? 使得函数返回值变成 optional
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    return true
}

if let result = try? checkPassword("password") {
    print("result was \(result)")
} else {
    print("D'oh")
}

try! checkPassword("33")

// failiable initializer 可失败的初始化方法
struct Person {
    var id: String
    init?(id: String) {
        if id.count == 3 {
            self.id = id
        } else {
            return nil
        }
    }
}
let person = Person(id: "ddd")
// person is optional
if let p = person {
    print("person id is \(p.id)")
}

// type casting
class Animal {
    
}
class Fish: Animal {
    
}
class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}
let pets = [Fish(), Dog(), Fish(), Dog()]
for pet in pets {
    // 解包class类型
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}
