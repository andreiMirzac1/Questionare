//
//  FileManager.swift
//  Questionnaire
//
//  Created by Andrei Mirzac on 28/08/2016.
//  Copyright © 2016 Andrei Mirzac. All rights reserved.
//

import Foundation
import SwiftyJSON

class Helper {
	static func getQuestionnaire() -> [AnyObject] {
        let filePath = Bundle.main.path(forResource: "Questionnaire", ofType:"json")!
		let jsonData = NSData(contentsOfFile: filePath)!
        let jsonObj = try! JSON(data: jsonData as Data)
        return  jsonObj["Questionnaire"].arrayObject! as [AnyObject]
	}
}
