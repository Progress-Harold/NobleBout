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
    var windPointEmitteron: SKEmitterNode?
    var windPointEmitter: SKEmitterNode?
    let type: PlayerType
    
    init(type: PlayerType, infoNode: SKNode) {
        self.type = type
        
        configure(node: infoNode)
        style()
    }
    
    func configure(node: SKNode) {
        playerHealthbar = node.childNode(withName: UserInterface.healthBar) as? SKSpriteNode
        playerHP = node.childNode(withName: "hp") as? SKLabelNode
    }
    
    func style() {
        playerHealthbar?.texture = Textures.healthBar
    }
}
