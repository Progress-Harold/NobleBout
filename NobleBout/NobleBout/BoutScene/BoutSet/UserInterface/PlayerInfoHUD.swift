//
//  PlayerInfoHUD.swift
//  NobleBout
//
//  Created by Lee Davis on 1/2/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

import SpriteKit

final class PlayerInfoHUD {
    
    private var animationInProgress: Bool = false
    
    private var playerOneInfo: PlayerInfo
    private var hp1: Int = 100 {
        didSet {
            playerOneInfo.playerHP?.updateHPLabel(hp1)
            
            animationInProgress = true
            playerOneInfo.playerHealthbar?.run(SKAction.getAction(by: SpriteActionsName.reduceHealth + "\(hp1)")) {
                self.animationInProgress = false
            }
        }
    }
    
    private var playerTwoInfo: PlayerInfo
    private var hp2: Int = 100 {
        didSet {
            playerTwoInfo.playerHP?.updateHPLabel(hp2)
            
            animationInProgress = true
            playerTwoInfo.playerHealthbar?.run(SKAction.getAction(by: SpriteActionsName.reduceHealth + "\(hp2)")) {
                self.animationInProgress = false
            }
        }
    }
    
    init(_ playerOneInfo: SKNode, _ playerTwoInfo: SKNode) {
        self.playerOneInfo = PlayerInfo(type: .p1, infoNode: playerOneInfo)
        self.playerTwoInfo = PlayerInfo(type: .p1, infoNode: playerTwoInfo)
    }
    
    enum Player { case playerOne, playerTwo }
    
    func decreaseHP(_ player: Player) {
        switch player {
        case .playerOne:
            hp1 -= 10
        case .playerTwo:
            hp2 -= 10
        }
    }
    
    func increaseHP(_ player: Player) {
        if animationInProgress == false {
            switch player {
            case .playerOne:
                hp1 += 10
            case .playerTwo:
                hp2 += 10
            }
        }
        else {
            print("animation is in progress")
        }
    }
}

extension PlayerInfoHUD: ScoreKeeperUIDelegate {
    func bout(winner: RuleBook.Winner) {
        switch winner {
        
        case .pOne:
            decreaseHP(.playerTwo)
        case .pTwo:
            decreaseHP(.playerOne)
            
        case .draw:
            return
        }
    }
    
    func updateRoundScore(p1: Int, p2: Int) {
        decreaseHP(.playerOne)
        print("test")
    }
}

