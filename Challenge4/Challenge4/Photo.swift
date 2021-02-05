//
//  Photo.swift
//  Challenge4
//
//  Created by mengxiangjian on 2021/2/5.
//

import UIKit

class Photo: NSObject, NSCoding {
    
    func encode(with coder: NSCoder) {
        coder.encode(caption, forKey: "caption")
        coder.encode(image, forKey: "image")
    }
    
    required init?(coder: NSCoder) {
        caption = coder.decodeObject(forKey: "caption") as? String ?? ""
        image = coder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    var caption: String
    var image: String
    
    init(caption: String, image: String) {
        self.caption = caption
        self.image = image
        super.init()
    }
}
