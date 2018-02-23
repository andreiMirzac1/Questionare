//
//  Answer.swift
//  QuestionsGenearator
//
//  Created by Mirzac Andrei on 28.01.16.
//  Copyright © 2016 Andrei Mirzac. All rights reserved.


import Foundation
import UIKit
import SwiftyJSON

final class Answer: Equatable, JSONAbleType {
	var text: String
	
	let answerId: Int
	let nextQuestionId: Int
	
	init(text: String,
	     answerId: Int,
	     nextQuestionId: Int) {
		self.text = text
		self.answerId = answerId
		self.nextQuestionId = nextQuestionId
	}
	
    static func fromJSON(_ dictionary: [String:AnyObject]) -> Answer {
		let json = JSON(dictionary)
		let text = json["answer"].stringValue
		let answerId = json["answer_id"].intValue
		
		let nextQuestionId  = json["next_question_to_show"].intValue
		return Answer(text: text,
		              answerId: answerId,
		              nextQuestionId : nextQuestionId)
	}
}
func == (lhs: Answer, rhs: Answer) -> Bool {
	return lhs.text == rhs.text && lhs.nextQuestionId  == rhs.nextQuestionId
}
