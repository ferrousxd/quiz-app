//
//  AttemptsTableViewController.swift
//  QuizApp
//
//  Created by Чингиз Азимбаев on 30.01.2021.
//

import UIKit

class AttemptsTableViewController: UIViewController {

    @IBOutlet var attemptsTableView: UITableView!
    
    let cellId = "AttemptsTableViewCell"
    var attemptArray = [Int]()
    
    func populateAttemptArray() {
        guard let attemptArray = UserDefaults.standard.array(forKey: "attemptArray") as? [Int] else {
            return
        }
        self.attemptArray = attemptArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateAttemptArray()
        
        self.title = "Attempts"
        
        attemptsTableView.delegate = self
        attemptsTableView.dataSource = self
        attemptsTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        attemptsTableView.tableFooterView = UIView()
        attemptsTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension AttemptsTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attemptArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AttemptsTableViewCell
        let item = attemptArray[indexPath.row]

        cell.attemptTextLabel.text = "Attempt № \(indexPath.row + 1)"
        cell.attemptScoreLabel.text = "\(item) %"

        return cell
    }
}
