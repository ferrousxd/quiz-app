//
//  ResultsViewController.swift
//  QuizApp
//
//  Created by Чингиз Азимбаев on 28.01.2021.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var userScoreInPercents: Int?
    
    @IBOutlet weak var userScoreLabel: UILabel!
    @IBOutlet weak var userScoreCommentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userScoreInPercents = userScoreInPercents {
            userScoreLabel.text = "\(userScoreInPercents) %"
            
            var comment = ""
            
            switch true {
            case 0 <= userScoreInPercents && userScoreInPercents < 20:
                comment = "Fail"
            case 20 <= userScoreInPercents && userScoreInPercents < 40:
                comment = "Poor"
            case 40 <= userScoreInPercents && userScoreInPercents < 60:
                comment = "Satisfactory"
            case 60 <= userScoreInPercents && userScoreInPercents < 80:
                comment = "Good"
            case 80 <= userScoreInPercents && userScoreInPercents <= 100:
                comment = "Excellent"
            default:
                break
            }
            
            userScoreCommentLabel.text = comment
        }
    }
    
    @IBAction func tryAgainAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homePageAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
