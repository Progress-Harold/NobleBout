//
//  PlayerInfoHUD.swift
//  NobleBout
//
//  Created by Lee Davis on 1/2/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

import SpriteKit

protocol PlayerInfoHUDDelegate {
    func roundEnd()
}

final class PlayerInfoHUD {
    
    var delegate: PlayerInfoHUDDelegate?
    
    private var animationInProgress: Bool = false
    private var shouldResetP1: Bool = false
    private var shouldResetP2: Bool = false
    private var playerOneIsWinner: Bool = false
    
    private var playerOneInfo: PlayerInfo
    private var playerOnePoints: Int = 0
    private var hp1: Int = 100 {
        didSet {
            playerOneInfo.playerHP?.updateHPLabel(hp1)
            
            if !shouldResetP1 {
                animationInProgress = true
                playerOneInfo.playerHealthbar?.run(SKAction.getAction(by: SpriteActionsName.reduceHealth + "\(hp1)")) {
                    self.animationInProgress = false
                }
            }
            else {
                let animationGroup = healthBarActionArray()
                
                animationInProgress = true
                playerOneInfo.playerHealthbar?.run(.group(animationGroup)) { [weak self] in
                    guard let myself = self else { return }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        myself.shouldResetP1 = false
                        myself.animationInProgress = false
                    }
                }
            }
        }
    }
    
    private var playerTwoInfo: PlayerInfo
    private var playerTwoPoints: Int = 0
    private var hp2: Int = 100 {
        didSet {
            playerTwoInfo.playerHP?.updateHPLabel(hp2)
            
            if !shouldResetP2 {
                animationInProgress = true
                playerTwoInfo.playerHealthbar?.run(SKAction.getAction(by: SpriteActionsName.reduceHealth + "\(hp2)")) {
                    self.animationInProgress = false
                }
            }
            else {
                let animationGroup = healthBarActionArray()
                
                animationInProgress = true
                playerTwoInfo.playerHealthbar?.run(.group(animationGroup)) {[weak self] in
                    guard let myself = self else { return }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        myself.shouldResetP2 = false
                        myself.animationInProgress = false
                    }
                }
            }
        }
    }
    
    init(_ playerOneInfo: SKNode, _ playerTwoInfo: SKNode) {
        self.playerOneInfo = PlayerInfo(type: .p1, infoNode: playerOneInfo)
        self.playerTwoInfo = PlayerInfo(type: .p1, infoNode: playerTwoInfo)
    }
    
    enum Player { case playerOne, playerTwo }
    
    func decreaseHP(_ player: Player) {
        if animationInProgress == false {
            switch player {
            case .playerOne:
                if hp1 > 0 {
                    if hp1 == 10 {
                        hp1 -= 10
                        delegate?.roundEnd()
                        reset()
                    }
                    else {
                        hp1 -= 10
                    }
                }
            case .playerTwo:
                if hp2 > 0 {
                    if hp2 == 10 {
                        hp2 -= 10
                        delegate?.roundEnd()
                        reset()
                    }
                    else {
                        hp2 -= 10
                    }
                }
            }
        }
        else {
            print("animation is in progress")
        }
    }
    
    func increaseHP(_ player: Player) {
        // TODO: - Fix this up after adding a healing feature
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
    
    
    func healthBarActionArray() -> [SKAction] {
        var arr = [Int]()
        var currentPoint = 0
        
        while currentPoint < 100 {
            currentPoint += 10
            
            arr.append(currentPoint)
        }
        
        return arr.compactMap {
            print("\($0)")
            return SKAction.getAction(by: SpriteActionsName.reduceHealth + "\($0)").reversed()
        }
    }
    
    func reset() {
        shouldResetP1 = true
        shouldResetP2 = true
        hp1 = 100
        hp2 = 100
    }
}

extension PlayerInfoHUD: ScoreKeeperUIDelegate {
    // Remove code?
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
        
    
    }
}

