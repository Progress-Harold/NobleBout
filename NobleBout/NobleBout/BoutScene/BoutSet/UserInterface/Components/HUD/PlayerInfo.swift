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
    let type: PlayerType
    
    init(type: PlayerType, infoNode: SKNode) {
        self.type = type
        
        configure(node: infoNode)
    }
    
    func configure(node: SKNode) {
        playerHP = node.childNode(withName: type.rawValue) as? SKLabelNode
    }
}
