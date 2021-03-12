//
//  ScoreKeeper.swift
//  NobleBout
//
//  Created by Lee Davis on 3/7/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

protocol ScoreKeeperDelegate {
    func matchPoint()
}

protocol ScoreKeeperUIDelegate {
    func updateRoundScore(p1: Int, p2: Int)
    func bout(winner: RuleBook.Winner)
}

final class ScoreKeeper {
    private var p1Score: Int = 0
    private var p2Score: Int = 0
    
    var delegate: ScoreKeeperDelegate?
    var delegateUI: ScoreKeeperUIDelegate?
    
    init() {}
    
    func bout(winner: RuleBook.Winner) {
        delegateUI?.bout(winner: winner)
    }
    
    func awardPoint(to winner: RuleBook.Winner) {
        switch winner {
        case .pOne:
            p1Score += 1
        case .pTwo:
            p2Score += 1
        case .draw:
            break
        }
        
        if (p1Score.isMatchPoint() == true) || (p2Score.isMatchPoint() == true) {
            reset()
            delegate?.matchPoint()
        }
        else {
            delegateUI?.updateRoundScore(p1: p1Score, p2: p2Score)
        }
    }
    
    private func reset() {
        p1Score = 0
        p2Score = 0
    }
}
