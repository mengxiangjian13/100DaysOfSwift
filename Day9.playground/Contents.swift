import UIKit

var str = "Hello, playground"

// struct 第二部分 part2

// initializer 初始化

// struct 默认生成初始化方法。参数是所有的property.
struct User {
    var name: String
    var age: Int = 20
}

let me = User(name: "meng")
me.name

// 也可以自己加入初始化方法，但自己初始化方法会覆盖默认初始化方法，默认初始化方法将不再有效。
// 如果想自定义初始化方法，又想保留默认初始化方法，将自定义初始化方法写在extension里面就可以
// 自定义方法，init之前不需要写func关键字
extension User {
    init() {
        name = "guo"
    }
}
let guo = User()
guo.name

// self。在初始化方法中，区分属性和方法参数，可以用self

// lazy 类似计算属性，但与计算属性不同的是，第一次获取之后再获取不用重新计算，只是晚一些存储.
// lazy 只能用在var属性上，而且实例也必须是var，不能用let声明。
struct Sport {
    var name: String
    lazy var goal = "GOGOGOGO"
}
var football = Sport(name: "football")
print(football.goal)

// static property method。用于全局变量

struct Fruit {
    static var count = 0
    var name: String
    init(name: String) {
        self.name = name
        Fruit.count += 1
    }
    static func totalCount() {
        print("we have \(count) fruits")
    }
}

let apple = Fruit(name: "apple")
let banana = Fruit(name: "banana")
let pear = Fruit(name: "pear")
let orange = Fruit(name: "orange")
let coconut = Fruit(name: "coconut")
let watermelon = Fruit(name: "watermelon")

Fruit.totalCount()
Fruit.count




