import UIKit

var str = "Hello, playground"

// protocol

protocol Identifiable {
    var id: String {get set} // 不能只有set，可以set get，可以只有get。
}

struct User: Identifiable {
    var id: String
}

let me = User(id: "1")

func displayID(user: Identifiable) {
    print("my id is \(user.id)")
}

displayID(user: me)

// protocol可以继承，并且可以多继承
protocol Payable {
    func pay()
}
protocol HasVacation {
    func takeVacation()
}
protocol Employee: Payable, HasVacation {
}

struct Employer: Employee {
    func pay() {
        print("pay me 10000000 dollors")
    }
    func takeVacation() {
        print("I have 300 days holidays")
    }
}

// extension
extension Int {
    func square() -> Int {
        return self * self
    }
}

3.square()

// protocol extension 可以为实现此protocol的类型添加方法
extension Employee {
    func dowork() {
        print("I'm very happy to do my work")
    }
}
let e = Employer()
e.dowork()
