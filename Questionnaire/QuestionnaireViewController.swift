//
//  BaseSurveyViewController .swift
//  
//
//  Created by Andrei Mirzac on 19/08/2016.
//  Copyright © 2016 company. All rights reserved.


import UIKit
import QuartzCore

class BaseSurveyViewController: UITableViewController {
	
	//MARK:Private
	fileprivate var questViewModel: QuestionnaireViewModel
	fileprivate var quest: Questionnaire
	public  enum CellRow: Int {
		case Question = 0
		case Answer = 1
	}

	init(quest: Questionnaire) {
		self.quest = quest
		self.questViewModel = QuestionnaireViewModel(quest: quest)
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.estimatedRowHeight = 55
		self.tableView.rowHeight = UITableViewAutomaticDimension
		
		var nib = UINib(nibName: CellIdentifier.Question.rawValue, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CellIdentifier.Question.rawValue)
		
		nib = UINib(nibName: CellIdentifier.TextAnswer.rawValue, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CellIdentifier.TextAnswer.rawValue)
	}
}

//MARK: TableView Delegate
extension BaseSurveyViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellRow = CellRow(rawValue: indexPath.row) ?? .Answer
        
        switch cellRow {
        case .Answer:
            self.handleTapOnAnswerCell(indexPath: indexPath as NSIndexPath)
        case .Question:break
        }
    }
}

//MARK: TableView DataSource
extension BaseSurveyViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return questViewModel.showedQuestions.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let question = questViewModel.showedQuestions[section]
		guard let _ = question.selectedAnswer else {
			return question.answers.count + 1
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellRow = CellRow(rawValue: indexPath.row) ?? .Answer
        
        switch cellRow {
        case .Question:
            return questionCellAtIndexPath(indexPath: indexPath as NSIndexPath)
        case .Answer:
            return answerCellAtIndexPath(indexPath: indexPath as NSIndexPath)
        }
    }
}

extension BaseSurveyViewController {
	func questionCellAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
		let identifier = CellIdentifier.Question.rawValue
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath as IndexPath) as! QuestionCell
		let question = questViewModel[indexPath.section]
		cell.configure(question: question)
		return cell
	}
    
	func answerCellAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
		let identifier = CellIdentifier.TextAnswer.rawValue
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath as IndexPath) as! TextAnswerCell
		let question = questViewModel[indexPath.section]
		let answer = question.answers[indexPath.row - 1]
        cell.configure(answer: answer)
		return cell
	}
}

//MARK:Answer Action Handler
extension BaseSurveyViewController {
	
	func handleTapOnAnswerCell(indexPath: NSIndexPath) {
        self.questViewModel.selected(indexPath: indexPath)
        self.colapse(section: indexPath.section, animated: true)
        if let newSection = self.questViewModel.insertNextQuestionBasedOn(answerIndex: indexPath) {
            self.insertSection(section: newSection, animated: true)
		}
	}
}

//MARK:Cell Animations
extension BaseSurveyViewController {
	func colapse(section: Int, animated: Bool) {
        let animation: UITableViewRowAnimation = animated ? .fade : .none
        let nrRows = tableView.numberOfRows(inSection: section)
		var indexPaths = [NSIndexPath]()
		for row in 1...nrRows - 1 {
			let indexPath = NSIndexPath(row: row, section: section)
			indexPaths.append(indexPath)
		}
		tableView.beginUpdates()
        tableView.reloadRows(at: [NSIndexPath(row: 0, section: section) as IndexPath], with: animation)
        tableView.deleteRows(at: indexPaths as [IndexPath], with: animation)
		tableView.endUpdates()
	}
	func insertSection(section: Int, animated: Bool) {
		let animation: UITableViewRowAnimation = animated ? .fade : .none
		tableView.beginUpdates()
        tableView.insertSections(NSIndexSet(index: section) as IndexSet, with: animation)
		tableView.endUpdates()
	}
	func updateSection(section: Int, animated: Bool) {
		let animation: UITableViewRowAnimation = animated ? .fade : .none
		tableView.beginUpdates()
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: animation)
		tableView.endUpdates()
	}
}
