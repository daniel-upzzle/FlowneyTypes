//
//  Action.swift
//  Recompte
//
//  Created by Daniel Valls Estella on 11/1/18.
//

import Foundation


public enum Currency: Int, Codable {
	case Euro
}


public struct Action: Codable{
	
	
	public enum Status: String, Codable {
		case CreatedBySender
		case CreatedByReceiver
		case Accepted
		case RejectedBySender
		case RejectedByReceiver
		case Accounted
		case Unknown
	}
	
	public let id: Int?
	public let sender: User
	public let receiver: User
	public let date: Date
	public let concept: String
	public let amount: Float
	public let currency: Currency = .Euro
	public let status: Status
	public let counterPart: Id? = nil

	public var isCompensation: Bool{
		return counterPart != nil
	}
	
	public var isSaved: Bool{
		return id != nil
	}
	
	
	public func wichOther(me: User) -> User? {
		
		if self.sender.id == me.id {
			return self.receiver
		}
		
		if self.receiver.id == me.id {
			return self.sender
		}
		
		return nil
	}
}




