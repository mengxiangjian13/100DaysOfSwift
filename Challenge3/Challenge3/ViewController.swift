//
//  ViewController.swift
//  Challenge3
//
//  Created by mengxiangjian on 2021/1/29.
//

import UIKit

class ViewController: UIViewController {
    
    var chanceLabel: UILabel!
    var wordLabel: UILabel!
    var inputButton: UIButton!
    
    var chance = 7 {
        didSet {
            chanceLabel.text = "\(chance) chance(s) remain"
        }
    }
    
    var answer = "HAPPY" // change this answer to play again
    var currentAnswer = [String]()
    
    override func loadView() {
        super.loadView()
        
        chanceLabel = UILabel()
        chanceLabel.translatesAutoresizingMaskIntoConstraints = false
        chanceLabel.font = .systemFont(ofSize: 20)
        chanceLabel.textColor = .red
        chanceLabel.text = "\(chance) chance(s) remain"
        view.addSubview(chanceLabel)
        
        wordLabel = UILabel()
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.font = .systemFont(ofSize: 30)
        wordLabel.textColor = .black
        view.addSubview(wordLabel)
        
        inputButton = UIButton(type: .system)
        inputButton.translatesAutoresizingMaskIntoConstraints = false
        inputButton.setTitle("input", for: .normal)
        inputButton.addTarget(self, action: #selector(inputTapped(_:)), for: .touchUpInside)
        view.addSubview(inputButton)
        
        NSLayoutConstraint.activate([
            chanceLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            chanceLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -10),
            wordLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 100),
            wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputButton.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 20),
            inputButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func inputTapped(_ sender: UIButton) {
        let ac = UIAlertController(title: "Guess", message: "Input a letter once a time (case insensitive)", preferredStyle: .alert)
        ac.addTextField { textField in
            textField.placeholder = "Input one letter"
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {[weak self] _ in
            self?.check(text: ac.textFields?[0].text)
        }))
        present(ac, animated: true, completion: nil)
    }
    
    func check(text: String?) {
        if let text = text {
            if text.count == 1 {
                let input = text.uppercased()
                if answer.contains(input) && !wordLabel.text!.contains(input) {
                    for (index, c) in answer.enumerated() {
                        if String(c) == input {
                            currentAnswer[index] = String(c)
                        }
                    }
                    wordLabel.text = currentAnswer.joined()
                    if wordLabel.text! == answer {
                        let ac = UIAlertController(title: "Congratulation!", message: "You passed this game", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        present(ac, animated: true, completion: nil)
                    }
                } else {
                    chance -= 1
                    if chance == 0 {
                        let ac = UIAlertController(title: "Game Over", message: nil, preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        present(ac, animated: true, completion: nil)
                    } else {
                        let ac = UIAlertController(title: "Error", message: "The latter has been guessed or not include in answer", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        present(ac, animated: true, completion: nil)
                    }
                }
            } else {
                let ac = UIAlertController(title: "Error", message: "Please enter only one letter", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(ac, animated: true, completion: nil)
            }
        } else {
            let ac = UIAlertController(title: "Error", message: "Please enter a letter", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for _ in answer {
            currentAnswer += ["?"]
        }
        wordLabel.text = currentAnswer.joined()
    }


}

