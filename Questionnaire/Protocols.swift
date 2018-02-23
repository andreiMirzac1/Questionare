//
//  JSONAble.swift
//  
//
//  Created by Andrei Mirzac on 14/07/2016.
//  Copyright © 2016 company. All rights reserved.
//

import Foundation

protocol JSONAbleType {
	static func fromJSON(_: [String: AnyObject]) -> Self
}
protocol JSONAbleArray {
	static func fromJSON(_: [AnyObject]) -> Self
}
protocol JSONEncodable {
	func toJSON() -> AnyObject?
}
