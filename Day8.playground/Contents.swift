import UIKit

var str = "Hello, playground"

// 创建struct

struct Sport {
    // 存储属性 stored property
    var name: String
    var isOlympicSport: Bool
    
    // 计算属性 computed property。必须使用var声明，不能用let。
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is a olympic sport"
        } else {
            return "\(name) is not a olympic sport"
        }
    }
}
var tennis = Sport(name: "Tennis", isOlympicSport: true)
tennis.name
tennis.name = "hh, tennis"
tennis.name

// 计算属性（感觉是类似一个方法，此方法肯定有返回值且没有参数）
print(tennis.olympicStatus)

// 属性观察者 property observer
struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 60
progress.amount = 100

// 方法 method
struct City {
    var population: Int
    
    func collectTaxes() -> Int {
        return population * 1000
    }
}

let london = City(population: 200)
london.collectTaxes()

// mutating 声明方法。这样，constant 实例不能调用该方法，var 实例可以调用。方法内部可以更改属性值

struct Person {
    var name: String
    mutating func makeAnonymous() {
        name = "anonymous"
    }
}

// let 声明常量不能调用mutating的实例
//let me = Person(name: "me")
//me.makeAnonymous()

var you = Person(name: "you")
you.makeAnonymous()
you.name
