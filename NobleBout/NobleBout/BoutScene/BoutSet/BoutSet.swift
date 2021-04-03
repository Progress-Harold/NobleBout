//
//  BoutSet.swift
//  NobleBout
//
//  Created by Lee Davis on 1/2/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

import SpriteKit

protocol BoutSetDelegate {
    func returnToStartMenu()
}

final class BoutSet {
    var delegate: BoutSetDelegate?
    
    var playerInfo: PlayerInfoHUD?
    var playerInterface: PlayerInterface?
    var playerInteraction: PlayerInteraction?
    
    let scoreKeeper = ScoreKeeper()
    
    init(_ dict: [String: Any]) {
        guard let playerOneInfo = dict["playerOneInfo"] as? SKNode,
              let playerTwoInfo = dict["playerTwoInfo"] as? SKNode,
              let avatarOne = dict["p1"] as? SKSpriteNode,
              let avatarTwo = dict["p2"] as? SKSpriteNode
        else {
            print("No good, could not find some assets in scene.")
            return
        }
                
        playerInfo = PlayerInfoHUD(playerOneInfo, playerTwoInfo)
        playerInfo?.delegate = self
        playerInterface = PlayerInterface(avatarOne, avatarTwo)
        
        let buttons = dict.filter { key, value -> Bool in
            return buttonStrs.contains(key)
        }.compactMap { _, value -> Button? in
            return value as? Button
        }
        
        playerInteraction = .init(buttons: buttons)
        
        configure()
    }
    
    func configure() {
        scoreKeeper.delegateUI = playerInfo
    }
}

extension BoutSet: PlayerInfoHUDDelegate {
    func roundEnd() {
        delegate?.returnToStartMenu()
    }
}
