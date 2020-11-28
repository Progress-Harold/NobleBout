//
//  MatchController.swift
//  NobleBout
//
//  Created by Lee Davis on 11/3/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import SpriteKit

class MatchController {
    private var playerOneUI: PlayerUIStruct
    private var playerTwoUI: PlayerUIStruct
    
//    private var currentBout
    
    private init(parent: SKScene) {
        self.playerOneUI = parent.childNode(withName: player1Lble) as? PlayerUIStruct ?? PlayerUIStruct()
        self.playerTwoUI = parent.childNode(withName: player2Lble) as? PlayerUIStruct ?? PlayerUIStruct()
    }
    
    
    func start() {}
    
    
    func checkScore() {}
    
    
    func declareWinner() {}
    
    
    func end() {}
}
