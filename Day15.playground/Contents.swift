import UIKit

var str = "Hello, playground"

// property

struct Person {
    static var favoriteSong = "You belong with me" // static property
    
    var name: String
    var age: Int
    
    var clothes: String {
        willSet {
            print("I'm changing from \(clothes) to \(newValue)")
        }
        didSet {
            print("I just changed from \(oldValue) to \(clothes)")
        }
    }
    
    // computed property
    var ageInDogsYear: Int {
        return age * 7
    }
}

var taylor = Person(name: "Taylor Swift", age: 20, clothes: "T-shirt") // 初始化方法不会触发 property observer
taylor.clothes = "short skirts"
Person.favoriteSong

struct TaylorFan {
    // access control
    private var name: String?
}
let fan = TaylorFan()

//
class Album {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getPerformance() -> String {
        return "The album \(name) sold a lot"
    }
}

class StudioAlbum: Album {
    var studio: String
    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The studio album \(name) sold a lot"
    }
}

class LiveAlbum: Album {
    var location: String
    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The live album \(name) sold a lot"
    }
}

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")

var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]

for album in allAlbums {
    print(album.getPerformance())
}

for album in allAlbums {
    // downcasting
    if let studio = album as? StudioAlbum {
        print(studio.studio)
    } else if let live = album as? LiveAlbum {
        print(live.location)
    }
}


class View {
    lazy var bgView: String = {
        return "lazy load view"
    }()
}

let view = View()
view.bgView
