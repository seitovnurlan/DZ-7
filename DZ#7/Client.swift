//
//  Client.swift
//  DZ#7
//
//  Created by Nurlan Seitov on 3/2/23.
//

import Foundation

class Client {
    var firstName: String
    var lastName: String
    var cards: [Card]
    
    init(firstName: String, lastName: String, cards: [Card]) {
        self.firstName = firstName
        self.lastName = lastName
        self.cards = cards
    }
    
    func showInfo() {
        print(firstName, lastName)
        for card in cards {
            print(card.bill, card.cardNumber, card.bankName)
        }
    }
}
