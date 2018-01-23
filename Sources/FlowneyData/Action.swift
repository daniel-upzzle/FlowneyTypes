//
//  Action.swift
//  Recompte
//
//  Created by Daniel Valls Estella on 11/1/18.
//

import Foundation


enum Currency: Int, Codable {
	case Euro
}


public struct Action: Codable{
	
	
	enum Status: String, Codable {
		case CreatedBySender
		case CreatedByReceiver
		case Accepted
		case RejectedBySender
		case RejectedByReceiver
		case Accounted
		case Unknown
	}
	
	let id: Int?
	let sender: User
	let receiver: User
	let date: Date
	let concept: String
	let amount: Float
	let currency: Currency = .Euro
	let status: Status
	let counterPart: Id? = nil

	var isCompensation: Bool{
		return counterPart != nil
	}
	
	var isSaved: Bool{
		return id != nil
	}
	
	
	func wichOther(me: User) -> User? {
		
		if self.sender.id == me.id {
			return self.receiver
		}
		
		if self.receiver.id == me.id {
			return self.sender
		}
		
		return nil
	}
}




