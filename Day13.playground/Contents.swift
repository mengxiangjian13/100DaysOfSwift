import UIKit

var str = "Hello, playground"
str = "hello, world"

// types
var string = "hhhh"
var double = 2.033
var int = 3
var bool = true

// operator
var a = 10
a += 1
a -= 1
a *= a

var c = a % 9

var b = 10
a > b
a < b

string == "hhhh"

// string interpolation
var name = "meng"
var age = 32
var job = "soft engineer"
print("My name is \(name), I'm \(age). Now I'm a \(job).")

// array
var songs = ["Shake it Off", "You Belong with Me", "Love Story"]
songs[0]
type(of: songs)

var songs2 = ["Today was a Fairytale", "Welcome to New York", "Fifteen"]
var songs3 = [String]()

songs = songs + songs2 + songs3 // 将数组合并成了一个

// dictionary

var dict: Dictionary<String, Any> = ["name": "meng", "age": 3, "wife": ["name": "guo", "age": 32]]
type(of: dict)
dict["name"]
print(dict["name"] ?? "")

// condition

if true {
    print("It's true")
}

// loop
for _ in 0...5 {
    print("ok")
}

for song in songs {
    print("sing a song named:\(song)")
}

for key in dict {
    // 遍历dict，得到tuple
    print("dict key is \(key)")
}

myloop:
while true {
    if songs.count == 10 {
        break
    }
    for i in 1...5 {
        if i == 4 {
            break myloop
        }
    }
    songs.append("new song")
}
songs

switch songs.count {
case 6:
    print("one")
    print("two")
    fallthrough
default:
    print("default")
}

