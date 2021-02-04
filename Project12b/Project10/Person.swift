//
//  Person.swift
//  Project10
//
//  Created by mengxiangjian on 2021/2/2.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
