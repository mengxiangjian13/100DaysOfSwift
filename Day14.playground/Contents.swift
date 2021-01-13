import UIKit

var str = "Hello, playground"

func getStatus() -> String? {
    return "Happy"
}

var status = getStatus()
print(status ?? "happy")

enum WeatherType {
    case sunny
    case cloud
    case rain
    case wind(speed: Int)
    case snow
}

func getHaterStatus(weather: WeatherType) -> String? {
    switch weather {
    case .sunny:
        return nil
    case .wind(let speed) where speed < 10:
        return "ok"
    case .cloud, .wind:
        return "dislike"
    case .rain, .snow:
        return "hate"
    }
}

print(getHaterStatus(weather: .wind(speed: 6)) ?? "ok")

// struct
struct Person {
    var clothes: String
    var shoes: String
}

var taylor = Person(clothes: "T-shirt", shoes: "Sneaker")
taylor.clothes = "short skirt"
print(taylor.clothes)

var taylorCopy = taylor
taylorCopy.shoes = "high heel"
print(taylor.shoes)
print(taylorCopy.shoes)
