//
//  PlayerInfo.swift
//  NobleBout
//
//  Created by Lee Davis on 1/9/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

import SpriteKit

class PlayerInfo {
    enum PlayerType: String {
        case p1
        case p2
    }
    
    var playerIcon: SKSpriteNode?
    var playerHealthbar: SKSpriteNode?
    var playerHP: SKLabelNode?
    var winPointEmitterOne: SKNode?
    var winPointEmitterTwo: SKNode?
    let type: PlayerType
    
    init(type: PlayerType, infoNode: SKNode) {
        self.type = type
        
        configure(node: infoNode)
        style()
    }
    
    private func configure(node: SKNode) {
        playerHealthbar = node.childNode(withName: UserInterface.healthBar) as? SKSpriteNode
        playerHP = node.childNode(withName: "hp") as? SKLabelNode
        
        winPointEmitterOne = node.childNode(withName: "point1")
//        winPointEmitterOne?.isHidden = true
        
        winPointEmitterTwo = node.childNode(withName: "point2")
//        winPointEmitterTwo?.isHidden = true
    }
    
    private func style() {
        playerHealthbar?.texture = Textures.healthBar
        
        winPointEmitterOne?.addChild(SKEmitterNode().summonEmitter(with: "winSpark"))
        winPointEmitterTwo?.addChild(SKEmitterNode().summonEmitter(with: "winSpark"))
    }
}
