//
//  AttemptsTableViewCell.swift
//  QuizApp
//
//  Created by Чингиз Азимбаев on 30.01.2021.
//

import UIKit

class AttemptsTableViewCell: UITableViewCell {

    @IBOutlet weak var attemptTextLabel: UILabel!
    @IBOutlet weak var attemptScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
