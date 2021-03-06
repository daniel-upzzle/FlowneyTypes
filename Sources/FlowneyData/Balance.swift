//
//  Balance.swift
//  Recompte
//
//  Created by Daniel Valls Estella on 19/1/18.
//

import Foundation


public enum BalanceStatus : Codable {
	
	case IOwe(amount: Float)
	case OweMe(amount: Float)
	case Zero
	
	
	init(from decoder: Decoder) throws {
		
		let data :[String:Float] = try [String:Float].init(from:decoder)
		
		guard let caseString :String = data.keys.first, let amount :Float = data.values.first else {
			print("BalanceStatus error when init from decoder")
			self = .Zero
			return
		}
	
		switch caseString {
		case "IOwe":
			self = .IOwe(amount: amount)
		case "OweMe":
			self = .OweMe(amount: amount)
		default:
			self = .Zero
		}
	}
	
	func encode(to encoder: Encoder) throws {
		
		var container = encoder.singleValueContainer()

		switch self {
		case .IOwe(let amount):
			try container.encode( ["IOwe": amount] )
		case .OweMe(let amount):
			try container.encode( ["OweMe": amount] )
		case .Zero:
			try container.encode( ["Zero": 0] )
		}
		
	}
	
	public var absAmount: Float {
		switch self {
		case .IOwe(let amount):
			return amount
		case .OweMe(let amount):
			return amount
		case .Zero:
			return 0
		}
	}
}


public func +(a :BalanceStatus, b :BalanceStatus) -> BalanceStatus {
	
	switch (a,b) {
		
	case (.IOwe(let amountA), .IOwe(let amountB)):
		
		return .IOwe(amount: amountA+amountB)
		
	case (.IOwe(let amountA), .OweMe(let amountB)):
		
		if amountA == amountB {
			return .Zero
		}
		
		return (amountA > amountB) ? .IOwe(amount: amountA-amountB) : .OweMe(amount: amountB-amountA)

		
	case (.OweMe(let amountA), .IOwe(let amountB)):
		
		if amountA == amountB {
			return .Zero
		}
		
		return (amountA > amountB) ? .OweMe(amount: amountA-amountB) : .IOwe(amount: amountB-amountA)
		
	case (.OweMe(let amountA), .OweMe(let amountB)):
		
		return .OweMe(amount: amountA+amountB)
		
	case (.Zero, let b):
		
		return b
		
	case (let a, .Zero):
		
		return a
		
	}
	
}




public struct UsersBalance: Codable{
	
	//let me : User
	public let with : User
	public let status : BalanceStatus

}


extension UsersBalance{
	
	public func adding(status addingStatus: BalanceStatus) -> UsersBalance {
		//return UsersBalance(me: me, other: other, status: status + addingStatus )
		return UsersBalance(with: with, status: status + addingStatus )
	}
}



public struct GlobalBalance : Codable {
	
	public let status : BalanceStatus
	public let iOwe : BalanceStatus
	public let oweMe : BalanceStatus
	//let user : User
	
	public static var zero : GlobalBalance {
		return GlobalBalance(status: .Zero, iOwe: .Zero, oweMe: .Zero) //, user: user)
	}
	
	public func adding(balance : BalanceStatus) -> GlobalBalance {
		
		let newStatus = status + balance
		let newIOwe : BalanceStatus
		let newOweMe : BalanceStatus
		
		switch balance {
		case .IOwe:
			newIOwe = iOwe + balance
			newOweMe = oweMe
		case .OweMe:
			newIOwe = iOwe
			newOweMe = oweMe + balance
		case .Zero:
			newIOwe = iOwe
			newOweMe = oweMe
		}
		
		return GlobalBalance(status: newStatus, iOwe: newIOwe, oweMe: newOweMe) //, user: user)
	}
}

public struct BalanceResponse : Codable {
	
	public let global : GlobalBalance
	public let users : [UsersBalance]
}
