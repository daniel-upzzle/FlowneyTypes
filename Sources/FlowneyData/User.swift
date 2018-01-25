//
//  User.swift
//  Recompte
//
//  Created by Daniel Valls Estella on 12/1/18.
//

import Foundation

typealias Id = String
typealias Email = String

public struct User: Codable{
	public let id :Id
	public let name :String
	public let email :Email
}


