//
//  ViewController.swift
//  Project15
//
//  Created by mengxiangjian on 2021/3/3.
//

import UIKit

class ViewController: UIViewController {
    
    var imageView: UIImageView!
    var currentAnimation = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)
    }

    @IBAction func tapped(_ sender: Any) {
        if let button = sender as? UIButton {
            button.isHidden = true
        }
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: []) {
            switch self.currentAnimation {
            case 0:
                self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
            case 1:
                self.imageView.transform = .identity
            case 2:
                self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)
            case 3:
                self.imageView.transform = .identity
            case 4:
                self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            case 5:
                self.imageView.transform = .identity
            case 6:
                self.imageView.backgroundColor = .green
                self.imageView.alpha = 0.1
            case 7:
                self.imageView.backgroundColor = .clear
                self.imageView.alpha = 1
            default:
                break
            }
        } completion: { (finished) in
            if let button = sender as? UIButton {
                button.isHidden = false
            }
        }

        
        currentAnimation += 1
        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }
    
}

