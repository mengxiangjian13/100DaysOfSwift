import UIKit

var str = "Hello, playground"

/// Loops

let range = 1...5
for item in range {
    print("item is \(item)")
}

// 不关心循环的常量，用 _ 代替
for _ in range {
    print("hello, world")
}

// 元组不能for循环
//for i in (1,2,3) {
//    print(i)
//}

// swift 的 do-while：repeat-while
repeat {
    print("hello, world")
} while false

// 退出 循环 break

// 退出多个循环，break nested loop
outerLoop: for i in 1...10 {
    for j in i...10 {
        print("\(i) * \(j) = \(i*j)")
        if i == 5 && j == 5 {
            break outerLoop
        }
    }
}

// 跳过 continue

// 无限循环
