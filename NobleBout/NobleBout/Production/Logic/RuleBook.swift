//
//  RuleBook.swift
//  NobleBout
//
//  Created by Lee Davis on 3/7/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

struct RuleBook {
    enum Winner: String {
        case pOne, pTwo, draw
    }

    enum Choice: String {
        case paper, rock, scissor
    }
    
    typealias JankenCombo = (Choice, Choice)
    private let choices: [Choice] = [.paper, .rock, .scissor]
    private let maxPoints: Int = 2
    
    private let resultsDict: [String: Winner] = {
        return [
            // - Paper:
            "paperVrock": .pOne,
            "paperVscissor": .pTwo,
            "paperVpaper": .draw,
            // - Scissors:
            "scissorVrock": .pTwo,
            "scissorVpaper": .pOne,
            "scissorVscissor": .draw,
            // - Rock
            "rockVscissor": .pOne,
            "rockVpaper": .pTwo,
            "rockVrock": .draw,
        ]
    }()
    
    func compare(combo: JankenCombo) -> Winner {
        return resultsDict["\(combo.0)V\(combo.1)"] ?? .draw
    }
    
    func reachedMax(points: Int) -> Bool {
        return points == maxPoints
    }
}
