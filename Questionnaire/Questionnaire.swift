//
//  Questionnaire.swift
//  
//
//  Created by Andrei Mirzac on 03/08/2016.
//  Copyright © 2016 company. All rights reserved.
//

import Foundation
import SwiftyJSON

final class Questionnaire: JSONAbleArray {

	static let NoQuestionId = 0
	var questions: [Question]
	var showedQuestions: [Question]!

    static func fromJSON(_ dictionary: [AnyObject]) -> Questionnaire {
		let json = JSON(dictionary)
		
		var questions = [Question]()
		for(_, subJson) in json {
            if let dictionary = subJson.dictionaryObject {
                let question = Question.fromJSON(dictionary as [String : AnyObject])
                questions.append(question)
            }
		}
		return Questionnaire(questions: questions)
	}

	init(questions: [Question]) {
		self.questions = questions
		self.showedQuestions = independentQuestions
	}
	
	private var independentQuestions: [Question] {
		var array = [Question]()
		for item in questions {
			if item.isDependent == false {
				array.append(item)
			}
		}
		return array
	}
}

extension Questionnaire: JSONEncodable {
	func toJSON() -> AnyObject? {
		var answeredQuestion = [AnyObject]()
		for question in showedQuestions {
			if let _ = question.selectedAnswer { //filter questions that are only answered
				guard let question = question.toJSON() else {return nil}
				answeredQuestion.append(question)
			}
		}
        return answeredQuestion as AnyObject
	}
}
