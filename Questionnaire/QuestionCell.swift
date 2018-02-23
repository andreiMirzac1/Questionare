//
//  QuestionTableViewCell.swift
//  AffinityApp
//
//  Created by Andrei Mirzac on 11/03/2016.
//  Copyright © 2016 company. All rights reserved.
//

import UIKit


class QuestionCell: UITableViewCell {

	@IBOutlet weak var question: UILabel!
	@IBOutlet weak var answer: UILabel!

    func configure(question: Question) {
		self.question.text = question.text
		self.answer.text = "Answer:"

		if let answer = question.selectedAnswer {
			self.answer.text = "Answer:" + answer.text
		}
	}
}

