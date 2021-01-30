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
    
    var options = [UIButton]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        options = [firstOption, secondOption, thirdOption, fourthOption]
        setViewControllerToInitialState()
    }
    
    // Basically, when user leaves QuestionViewController all values will reset to their initial state, just in case user wants to pass quiz again
    override func viewDidDisappear(_ animated: Bool) {
        setViewControllerToInitialState()
    }
    
    @IBAction func getNextQuestion(_ sender: Any) {
        guard currentQuestionIndex != questionArray.count - 1 else {
            submitQuiz()
            return
        }
        currentQuestionIndex += 1
        
        updateViewControllerContentForQuestionWith(questionIndex: currentQuestionIndex)
    }
    
    @IBAction func getPreviousQuestion(_ sender: Any) {
        guard currentQuestionIndex != 0 else {
            quitFromQuiz()
            return
        }
        currentQuestionIndex -= 1
        
        updateViewControllerContentForQuestionWith(questionIndex: currentQuestionIndex)
    }
    
    @IBAction func submitAnswer(_ sender: UIButton) {
        guard let userAnswer = sender.titleLabel?.text else {
            return
        }
        questionArray[currentQuestionIndex].userAnswer = userAnswer
        
        if userAnswer == questionArray[currentQuestionIndex].correctAnswer {
            userScore += 1
        }
        
        updateViewControllerContentForQuestionWith(questionIndex: currentQuestionIndex)
    }
}

extension QuestionsViewController {
    
    func populateQuestionArray() {
        questionArray.append(Question(questionText: "What is your age?", answers: ["12", "23", "31", "5"], correctAnswer: "12", userAnswer: nil))
        questionArray.append(Question(questionText: "How much is your outfit?", answers: ["1400$", "200₽", "1000₸", "🤷🏻‍♂️"], correctAnswer: "🤷🏻‍♂️", userAnswer: nil))
        questionArray.append(Question(questionText: "🤡?", answers: ["😎", "🗿", "🦾", "👺"], correctAnswer: "🗿", userAnswer: nil))
        questionArray.append(Question(questionText: "😎?", answers: ["𒀝 𒅗 𒁺 𒌑", "ሰላም አለይኩም ወንድም", "你好", "안녕하세요"], correctAnswer: "你好", userAnswer: nil))
        questionArray.append(Question(questionText: "雪花飘飘北风萧萧 天地一片苍茫", answers: ["🥴", "🤯", "🤠", "☠️"], correctAnswer: "🤠", userAnswer: nil))
        questionArray.append(Question(questionText: "¿Quieres?", answers: ["Si", "No", "Gracias", "Muchas gracias"], correctAnswer: "Muchas gracias", userAnswer: nil))
        questionArray.append(Question(questionText: "𓀿?", answers: ["𓀲", "𓆲", "𓈪", "𓂀"], correctAnswer: "𓂀", userAnswer: nil))
        questionArray.append(Question(questionText: "ᠮᠣᠩᠭᠣᠯ ᠬᠡᠯᠡ?", answers: ["Тийм ээ", "Үгүй", "Би мэдэхгүй байна", "Найз руугаа залгаарай"], correctAnswer: "Тийм ээ", userAnswer: nil))
        questionArray.append(Question(questionText: "𒀝 𒅗 𒁺 𒌑?", answers: ["𒁀𒉡𒌑", "𒍝𒇴 𒀭𒌍 𒀭𒊩𒌆𒃲", "𒀀𒈾 𒀾𒊑𒋙 𒇷𒌁", "𒀭𒂊 𒅇 𒌗𒁈"], correctAnswer: "𒀭𒂊 𒅇 𒌗𒁈", userAnswer: nil))
        questionArray.append(Question(questionText: "When did the WW2 start?", answers: ["1939", "1914", "1954", "1941"], correctAnswer: "1939", userAnswer: nil))
    }
    
    func returnButtonsToInitialState() {
        for button in options {
            button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            button.isEnabled = true
        }
    }
    
    func changeLabelsAndButtonsValuesFor(question: Question) {
        progressLabel.text = "\(currentQuestionIndex + 1) / \(questionArray.count)"
        questionLabel.text = question.questionText
        
        for index in 0..<options.count {
            options[index].setTitle(question.answers[index], for: .normal)
        }
    }
    
    func setViewControllerToInitialState() {
        questionArray = [Question]()
        currentQuestionIndex = 0
        userScore = 0;
        
        populateQuestionArray()
        returnButtonsToInitialState()
        
        let question = questionArray[currentQuestionIndex]
        changeLabelsAndButtonsValuesFor(question: question)
    }
    
    func updateButtonsValuesIfUserAlreadyAnswered(question: Question) {
        let userAnswer = question.userAnswer
        let correctAnswer = question.correctAnswer
        let userAnsweredCorrectly = userAnswer == correctAnswer

        for button in options {
            if !userAnsweredCorrectly {
                if button.titleLabel?.text == userAnswer {
                    button.backgroundColor = #colorLiteral(red: 1, green: 0.1217626589, blue: 0, alpha: 1)
                }
            }
            
            if button.titleLabel?.text == correctAnswer {
                button.backgroundColor = #colorLiteral(red: 0.1502517027, green: 1, blue: 0, alpha: 1)
            }

            button.isEnabled = false
        }
    }
    
    // This function is called when the user submits his answer or navigates through the questions
    func updateViewControllerContentForQuestionWith(questionIndex: Int) {
        let question = questionArray[questionIndex]
        changeLabelsAndButtonsValuesFor(question: question)
    
        returnButtonsToInitialState()
        
        if question.userAnswer != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.updateButtonsValuesIfUserAlreadyAnswered(question: question)
            }
        }
    }
    
    func quitFromQuiz() {
        let quitFromQuizAlert = UIAlertController(title: "Quit From Quiz", message: "Are you sure about getting back to the main page and cancelling the quiz?", preferredStyle: .alert)
        
        quitFromQuizAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
        }))

        quitFromQuizAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            return
        }))

        present(quitFromQuizAlert, animated: true)
    }
     
    func getAttemptArrayFromUserDefaults(defaults: UserDefaults) -> [Int] {
        guard let attemptArray = defaults.array(forKey: "attemptArray") as? [Int] else {
            defaults.set([Int](), forKey: "attemptArray")
            return []
        }
        return attemptArray
    }
    
    func submitQuiz() {
        let submitQuizAlert = UIAlertController(title: "Submit Quiz", message: "Are you sure about submitting the quiz?", preferredStyle: .alert)
        
        submitQuizAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            let defaults = UserDefaults.standard
            let userScoreInPercents = 100 * self.userScore / self.questionArray.count
            var attemptArray = self.getAttemptArrayFromUserDefaults(defaults: defaults)
            
            attemptArray.append(userScoreInPercents)
            defaults.removeObject(forKey: "attemptArray")
            defaults.set(attemptArray, forKey: "attemptArray")
            
            let resultsViewController = self.storyboard?.instantiateViewController(identifier: "ResultsViewController") as! ResultsViewController
            resultsViewController.userScoreInPercents = userScoreInPercents
            self.navigationController?.pushViewController(resultsViewController, animated: true)
        }))

        submitQuizAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            return
        }))

        present(submitQuizAlert, animated: true)
    }
}
