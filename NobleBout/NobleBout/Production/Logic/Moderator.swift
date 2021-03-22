//
//  Moderator.swift
//  NobleBout
//
//  Created by Lee Davis on 3/7/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

protocol ModeratorDelegate {
    func didDetermineBout(winner: RuleBook.Winner)
    func updateRoundScore(p1: Int, p2: Int)
}

final class Moderator {
    var delegate: ModeratorDelegate?
    private let ruleBook = RuleBook()
    
     
    func bout(choice1: RuleBook.Choice, choice2: RuleBook.Choice) {
        delegate?.didDetermineBout(winner: ruleBook.compare(combo: (choice1, choice2)))
    }
}
//
//extension Moderator: ScoreKeeperUIDelegate  {
//    func bout(winner: RuleBook.Winner) {
//        
//    }
//    
//    func updateRoundScore(p1: Int, p2: Int) {
//        delegate?.updateRoundScore(p1: p1, p2: p2)
//    }
//}

