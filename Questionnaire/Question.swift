//
//  Question.swift
//  QuestionsGenearator
//
//  Created by Mirzac Andrei on 28.01.16.
//  Copyright © 2016 Andrei Mirzac. All rights reserved.


import Foundation
import UIKit
import SwiftyJSON

final class Question: Equatable, JSONAbleType {
	
	let qId: Int
	let text: String
	let answers: [Answer]
	let isDependent: Bool
	
	weak var selectedAnswer: Answer? //weak because it will point to [answers]
	
	init(qId: Int, text: String, answers: [Answer], isDependent: Bool) {
		self.text = text
		self.answers = answers
		self.qId = qId
		self.isDependent = isDependent
	}
	
    static func fromJSON(_ dictionary: [String : AnyObject]) -> Question {
		let json = JSON(dictionary)
		var answers = [Answer]()
		for (_, subJson) in json["answers"] {
            if let dict = subJson.dictionary {
                let answer = Answer.fromJSON(dict as [String : AnyObject])
				answers.append(answer)
			} else {
				assertionFailure("Could not get DictionaryObject from answers JSON")
			}
		}
		
		let questionId: Int
		questionId = json["question_id"].intValue
		
		let questionText = json["question_text"].stringValue
		let isDependent = json["is_dependent"].boolValue
		
		return Question(qId:questionId, text:questionText, answers:answers, isDependent:isDependent)
	}
}

func == (lhs: Question, rhs: Question) -> Bool {
	return lhs.qId == rhs.qId
}

extension Sequence where Iterator.Element == Question {
	func with(idd: Int) -> Question? {
		return self.filter { (item) -> Bool in
			return item.qId == idd
			}.first
	}
}

extension Question: JSONEncodable {
	func toJSON() -> AnyObject? {
		var answer = [String: AnyObject]()
		
		guard let selAnswer = self.selectedAnswer else {return nil }
        answer["answer_id"] = selAnswer.answerId as AnyObject
        answer["free_type_text"] = selAnswer.text as AnyObject
        answer["question_id"] = self.qId as AnyObject
        return answer as AnyObject
	}
}

extension Bool {
	init(_ string: String) {
		self.init(string == "yes")
	}
}

