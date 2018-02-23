//
//  QuestionnaireViewModel.swift
//  AffinityApp
//
//  Created by Andrei Mirzac on 25/04/2016.
//  Copyright © 2016 company. All rights reserved.
//

import Foundation
import UIKit

class QuestionnaireViewModel {

	fileprivate var quest: Questionnaire

	required init(quest: Questionnaire) {
		self.quest = quest
	}
}

extension QuestionnaireViewModel {

	subscript(section: Int) -> Question {
		get {
			return quest.showedQuestions[section]
		}
	}
}

extension QuestionnaireViewModel {

	var showedQuestions: [Question] {
		return quest.showedQuestions
	}

	func selected(indexPath: NSIndexPath) {
		// save selected Answer
		let answerRow = indexPath.row - 1
		let selectedAnswer = quest.showedQuestions[indexPath.section].answers[answerRow]
		quest.showedQuestions[indexPath.section].selectedAnswer = selectedAnswer
	}

	//will return section nr or nil if there are no question to insert
	func insertNextQuestionBasedOn(answerIndex: NSIndexPath) -> Int? {
		let newSection = answerIndex.section + 1
		let question = quest.showedQuestions[answerIndex.section] //asnwered question
		let selAnswer = question.selectedAnswer

        guard let questionToShow = quest.questions.with(idd: selAnswer!.nextQuestionId) else {return nil}
        quest.showedQuestions.insert(questionToShow, at: newSection)
		return newSection
	}
}
