//
//  ViewController.swift
//  Project2
//
//  Created by mengxiangjian on 2021/1/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let checkAnswerCount = {
            self.answeredCount += 1
            if self.answeredCount == 10 {
                let ac = UIAlertController(title: "Your final score is \(self.score)", message: nil, preferredStyle: .alert)
                self.present(ac, animated: true, completion: nil)
            } else {
                let ac = UIAlertController(title: self.title, message: "Your score is \(self.score)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: {_ in
                    self.askQuestion()
                }))
                self.present(ac, animated: true, completion: nil)
            }
        }
        if sender.tag == correctAnswer {
            score += 1
            title = "Correct"
            checkAnswerCount()
        } else {
            score -= 1
            title = "Wrong"
            let ac = UIAlertController(title: "Wrong", message: "This is Flag of \(countries[sender.tag])", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                checkAnswerCount()
            }))
            present(ac, animated: true, completion: nil)
        }
    }
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var answeredCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(itemTapped))
        for button in [button1, button2, button3] as! [UIButton] {
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion()
    }

    func askQuestion() {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased() + "(score:\(score))"
    }
    
    @objc func itemTapped() {
        let ac = UIAlertController(title: "Your current score is \(score)", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }

}

