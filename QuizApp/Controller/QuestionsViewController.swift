//
//  QuestionsViewController.swift
//  QuizApp
//
//  Created by Чингиз Азимбаев on 27.01.2021.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    var questionArray = [Question]()
    var currentQuestionIndex = 0
    var userScore = 0;
    
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var firstOption: UIButton!
    @IBOutlet weak var secondOption: UIButton!
    @IBOutlet weak var thirdOption: UIButton!
    @IBOutlet weak var fourthOption: UIButton!
    
    var options: [UIButton] = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateArray()
        options = [firstOption, secondOption, thirdOption, fourthOption]
        
        updateViewControllerContent()
    }
    
    @IBAction func getNextQuestion(_ sender: Any) {
        guard currentQuestionIndex != questionArray.count - 1 else {
            return
        }
        
        currentQuestionIndex += 1
        
        updateViewControllerContent()
    }
    
    @IBAction func getPreviousQuestion(_ sender: Any) {
        guard currentQuestionIndex != 0 else {
            return
        }
        
        currentQuestionIndex -= 1
        
        updateViewControllerContent()
    }
    
    @IBAction func submitAnswer(_ sender: UIButton) {
        guard let userAnswer = sender.titleLabel?.text else {
            return
        }
        
        questionArray[currentQuestionIndex].userAnswer = userAnswer
        
        if userAnswer == questionArray[currentQuestionIndex].correctAnswer {
            userScore += 1
        }
        
        updateViewControllerContent()
    }
}

extension QuestionsViewController {
    
    func populateArray() {
        questionArray.append(Question(questionText: "What is your age?", answers: ["12", "23", "31", "5"], correctAnswer: "12", userAnswer: nil))
        questionArray.append(Question(questionText: "How much is your outfit?", answers: ["1400$", "200₽", "1000₸", "🤷🏻‍♂️"], correctAnswer: "🤷🏻‍♂️", userAnswer: nil))
        questionArray.append(Question(questionText: "🤡?", answers: ["😎", "🗿", "🦾", "👺"], correctAnswer: "🗿", userAnswer: nil))
        questionArray.append(Question(questionText: "😎?", answers: ["𒀝 𒅗 𒁺 𒌑", "ሰላም አለይኩም ወንድም", "你好", "안녕하세요"], correctAnswer: "你好", userAnswer: nil))
        questionArray.append(Question(questionText: "雪花飘飘北风萧萧 天地一片苍茫", answers: ["🥴", "🤯", "🤠", "☠️"], correctAnswer: "🤠", userAnswer: nil))
    }
    
    func returnOptionsToOriginalState() {
        for button in options {
            button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            button.isEnabled = true
        }
    }
    
    func updateViewControllerContent() {
        let question = questionArray[currentQuestionIndex]
        
        progressLabel.text = "\(currentQuestionIndex + 1) / \(questionArray.count)"
        questionLabel.text = question.questionText
        
        for index in 0..<self.options.count {
            // Почему-то при изменении Title'а Button'a происходит какая-то заддержка...
            self.options[index].setTitle(question.answers[index], for: .normal)
        }
    
        returnOptionsToOriginalState()
        
        if question.userAnswer != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.updateOptionsIfUserAlreadyAnswered(question: question)
            }
        }
    }
    
    func updateOptionsIfUserAlreadyAnswered(question: Question) {
        let userAnswer = question.userAnswer
        let correctAnswer = question.correctAnswer
        
        for index in 0..<options.count {
            print(question.answers[index] ?? "", "- должны быть равными -", options[index].titleLabel?.text ?? "")
        }
        
        for button in options {
            if button.titleLabel?.text == correctAnswer {
                button.backgroundColor = #colorLiteral(red: 0.1502517027, green: 1, blue: 0, alpha: 1)
            }
            
            if userAnswer != correctAnswer {
                if button.titleLabel?.text == userAnswer {
                    button.backgroundColor = #colorLiteral(red: 1, green: 0.1217626589, blue: 0, alpha: 1)
                }
            }
            
            button.isEnabled = false
        }
        
        /*
         // 1 Вариант
         if userAnswer == correctAnswer {
             // Searching for a UIButton with correct answer
             for button in self.options {
                 if button.titleLabel?.text == correctAnswer {
                     button.backgroundColor = #colorLiteral(red: 0.1502517027, green: 1, blue: 0, alpha: 1)
                 }
                 
                 button.isEnabled = false
             }
         } else {
             // Searching for a UIButtons with both correct and uncorrect answers
             for button in self.options {
                 if button.titleLabel?.text == correctAnswer {
                     button.backgroundColor = #colorLiteral(red: 0.1502517027, green: 1, blue: 0, alpha: 1)
                 }
                 
                 if button.titleLabel?.text == userAnswer {
                     button.backgroundColor = #colorLiteral(red: 1, green: 0.1217626589, blue: 0, alpha: 1)
                 }
                 
                 button.isEnabled = false
             }
         }
         
         // 2 Вариант
         if userAnswer == correctAnswer {
             // Searching for a UIButton with correct answer
             if button.titleLabel?.text == correctAnswer {
                 button.backgroundColor = #colorLiteral(red: 0.1502517027, green: 1, blue: 0, alpha: 1)
             }
         } else {
             // Searching for a UIButtons with both correct and uncorrect answers
             if button.titleLabel?.text == correctAnswer {
                 button.backgroundColor = #colorLiteral(red: 0.1502517027, green: 1, blue: 0, alpha: 1)
             }
             
             
             if button.titleLabel?.text == userAnswer {
                 button.backgroundColor = #colorLiteral(red: 1, green: 0.1217626589, blue: 0, alpha: 1)
             }
         }
         
         // 3 Вариант
         for button in options {
             if button.titleLabel?.text == correctAnswer {
                 button.backgroundColor = #colorLiteral(red: 0.1502517027, green: 1, blue: 0, alpha: 1)
             }
             
             if userAnswer != correctAnswer {
                 if button.titleLabel?.text == userAnswer {
                     button.backgroundColor = #colorLiteral(red: 1, green: 0.1217626589, blue: 0, alpha: 1)
                 }
             }
             
             button.isEnabled = false
         }
         */
    }
}
