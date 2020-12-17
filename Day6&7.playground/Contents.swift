import UIKit

var str = "Hello, playground"

// closure 闭包

let driving = {
    print("I'm driving in my car")
}
driving()

// 闭包参数，使用括号添加参数，后面用 in 关键字与闭包body分割
let drivingTo = { (to: String) in
    print("I'm driving \(to)")
}
drivingTo("London") // 调用闭包，参数没有形参（标签）

// 闭包返回值。在参数后，in关键字前面，写返回值类型
let drivingToPlace = { (place: String) -> String in
    return "I'm driving to \(place)"
}
print(drivingToPlace("Beijing"))

// 闭包作为参数传递到函数中，写好闭包类型 ()->Void，(参数以及类型)->返回值类型
func doAction(action: () -> Void) {
    print("I'm prepared")
    action()
    print("I'm arrived")
}
doAction(action: driving)

// 尾部闭包
doAction {
    print("I'm driving in my car")
}

// 闭包可以作为参数传递到函数中。并且此闭包也可以带参数
func travel(action: (String) -> Void) {
    print("I'm prepared")
    action("London")
    print("I'm arrived")
}

travel { (action) in
    print("I'm driving to \(action)")
}

// 闭包也可以有返回值

// 闭包的参数可以简化，可以用$0,$1来代替第1、2个参数。如果闭包只有一行代码，可以不写return
