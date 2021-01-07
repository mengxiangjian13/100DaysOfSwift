import UIKit

var str = "Hello, playground"

// class

// class must has a initializer，没有默认初始化方法

class User {
    var name: String
    init(name: String) {
        self.name = name
    }
    
    func callMe() {
        print("call me user")
    }
}
let me = User(name: "meng")
me.name

// 继承。子类的初始化方法必须调用super.init。但子类可以没有自己的初始化方法，直接继承父类的也可以。

class Admin: User {
    init() {
        super.init(name: "admin")
    }
    
    // 重写方法 override
    override func callMe() {
        print("call me administrator")
    }
}

let admin = Admin()
admin.callMe()

// final class 不能集成，不能重写
final class FinalClass {
    func cannotOverride() {
        print("cannot override this class")
    }
}

//class HAHA: FinalClass {
//
//}

// class是引用类型，struct是值类型。
// 根据你的类型到底要不要被shared，来确认使用class还是struct
class Singer {
    var name = "Taylor"
    
    deinit {
        print("\(name) is released")
    }
}

var taylor = Singer()
taylor.name
var biber = taylor
biber.name = "biber"
taylor.name

// deinitializer 相当于dealloc
for _ in 1...5 {
    let singer = Singer()
    singer.name = "hh"
}

// 可变性。class实例，即使使用let声明，也是可以修改property的.
// 但struct，使用let声明的，就不能有任何改动，包括property；如果用var声明的，改动property是需要加mutating关键字的
let user = User(name: "User")
user.name
user.name = "HAHA"
user.name

