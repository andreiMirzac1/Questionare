//
//  TextAnswerCell.swift
//  Questionnaire
//
//  Created by Andrei Mirzac on 28/08/2016.
//  Copyright © 2016 Andrei Mirzac. All rights reserved.
//

import UIKit

class TextAnswerCell: UITableViewCell {
	
	@IBOutlet weak var title: UILabel!
	
	func configure(answer: Answer) {
		self.title?.text = answer.text
	}
}