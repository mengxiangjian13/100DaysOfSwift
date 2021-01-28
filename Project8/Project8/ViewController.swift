//
//  ViewController.swift
//  Project8
//
//  Created by mengxiangjian on 2021/1/26.
//

import UIKit

class ViewController: UIViewController {
    
    // UI
    var clueLabel: UILabel!
    var answerLabel: UILabel!
    var scoreLabel: UILabel!
    var currentAnswer: UITextField!
    var letterButtons = [UIButton]()
    
    // 数据相关
    var activatedButtons = [UIButton]()
    var solutions = [String]()

    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadLevel()
    }
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        clueLabel = UILabel()
        clueLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        clueLabel.translatesAutoresizingMaskIntoConstraints = false
        clueLabel.font = .systemFont(ofSize: 24)
        clueLabel.text = "CLUES"
        clueLabel.numberOfLines = 0
        view.addSubview(clueLabel)
        
        answerLabel = UILabel()
        answerLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.font = .systemFont(ofSize: 24)
        answerLabel.text = "ANSWERS"
        answerLabel.numberOfLines = 0
        answerLabel.textAlignment = .right
        view.addSubview(answerLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = .systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped(_:)), for: .touchUpInside)
        view.addSubview(submit)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped(_:)), for: .touchUpInside)
        view.addSubview(clear)
        
        let buttonView = UIView()
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonView)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            clueLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answerLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            
            clueLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            clueLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            
            answerLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answerLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            answerLabel.heightAnchor.constraint(equalTo: clueLabel.heightAnchor),
            
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: clueLabel.bottomAnchor, constant: 20),
            
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
            
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44),
            
            buttonView.widthAnchor.constraint(equalToConstant: 750),
            buttonView.heightAnchor.constraint(equalToConstant: 320),
            buttonView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        
        let width = 150
        let height = 80
        
        for row in 0..<4 {
            for col in 0..<5 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = .systemFont(ofSize: 36)
                letterButton.setTitle("WWW", for: .normal)
                letterButton.frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterButton.layer.borderWidth = 1
                letterButton.layer.borderColor = UIColor.lightGray.cgColor
                buttonView.addSubview(letterButton)
                letterButton.addTarget(self, action: #selector(letterTapped(_:)), for: .touchUpInside)
                letterButtons.append(letterButton)
            }
        }
    }

    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
    }
    
    @objc func submitTapped(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else { return }
        
        if let index = solutions.firstIndex(of: answerText) {
            activatedButtons.removeAll()
            
            var splitAnswers = answerLabel.text?.components(separatedBy: "\n")
            splitAnswers?[index] = answerText
            answerLabel.text = splitAnswers?.joined(separator: "\n")
            
            currentAnswer.text = ""
            score += 1
            
            for button in letterButtons {
                if !button.isHidden {
                    return
                }
            }
            
            let ac = UIAlertController(title: "Well done!", message: "Are you ready for next level?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
            present(ac, animated: true, completion: nil)
            
        } else {
            score -= 1
            let ac = UIAlertController(title: "You are wrong!", message: "Reset to guess again", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak self] _ in
                self?.clearTapped(sender)
            }))
            present(ac, animated: true, completion: nil)
        }
    }
    
    func levelUp(action: UIAlertAction) {
        level += 1
        solutions.removeAll(keepingCapacity: true)

        loadLevel()

        for btn in letterButtons {
            btn.isHidden = false
        }
    }
    
    @objc func clearTapped(_ sender: UIButton) {
        currentAnswer.text = ""
        for button in activatedButtons {
            button.isHidden = false
        }
        activatedButtons.removeAll()
    }
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        DispatchQueue.global().async {
            if let fileURL = Bundle.main.url(forResource: "level1", withExtension: "txt") {
                if let levelContents = try? String(contentsOf: fileURL) {
                    var lines = levelContents.components(separatedBy: "\n")
                    lines.shuffle()
                    
                    for (index, line) in lines.enumerated() {
                        let parts = line.components(separatedBy: ": ")
                        let answer = parts[0]
                        let clue = parts[1]
                        
                        clueString += "\(index + 1). \(clue)\n"
                        
                        let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                        solutionString += "\(solutionWord.count) letters\n"
                        self.solutions.append(solutionWord)
                        
                        let bits = answer.components(separatedBy: "|")
                        letterBits += bits
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.clueLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
                self.answerLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
                
                if letterBits.count == self.letterButtons.count {
                    for i in 0..<self.letterButtons.count {
                        self.letterButtons[i].setTitle(letterBits[i], for: .normal)
                    }
                }
            }
        }
    }
}

