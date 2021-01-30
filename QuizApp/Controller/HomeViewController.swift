//
//  HomeViewController.swift
//  QuizApp
//
//  Created by Чингиз Азимбаев on 27.01.2021.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func letsGoAction(_ sender: Any) {
        let questionsViewController = self.storyboard?.instantiateViewController(identifier: "QuestionsViewController") as! QuestionsViewController
        self.navigationController?.pushViewController(questionsViewController, animated: true)
    }
}
