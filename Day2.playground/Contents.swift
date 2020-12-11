import UIKit

var str = "Hello, playground"

// Array
let paul = "Paul"
let nick = "Nick"
let tim = "Tim"
let array = [paul, nick, tim]

// set 使用array进行初始化。
// set的特点，1.无序 2.元素只能出现一次，不能重复出现。
let set = Set(array)
let set2 = Set([1,2,3,4,3,2,5])

// tuple 元组。元组的特点是，元组的size不能改变，一旦创建之后，不能添加或移除item;
// 元组一旦创建类型就确定了，修改的时候不能修改其类型。
var name = (first: "Xiangjian", last: "Meng")
name.first
name.last
name.0
name.1
name.first = "Zhenyan"
name.first

// 总结：1. 数组有序 2. set无序，且元素只能出现一次 3. 元组 size不可变，内部每一个元素类型不可变

// dictionary

let dict = ["name": "mengxiangjian", "age": "30"]
let myname = dict["name"] // Optional

// 初始化空的各种collection
let emptyDict = [String: Int]()
let emptyDict2 = Dictionary<String, Int>()
let emptyArray = Array<Int>()
let emptyArray2 = [Int]()
let emptySet = Set<Int>()

// Enums

enum Direction {
    case east
    case west
    case north
    case south
}

Direction.east

// Enums associated values

enum Activity {
    case running(km: Int)
    case talking(topic: String)
    case coding(language: String)
}

let coding = Activity.coding(language: "Swift")

print("coding enums raw value is \(coding)")

// Enums raw value
// 有类型的enums才有 rawValue，像上面的没有类型的，没有rawValue
enum Planet: Int {
    case earth = 1
    case mars
    case venus
}

let earth = Planet(rawValue: 1)

