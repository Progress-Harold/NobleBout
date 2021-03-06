//
//  PlayerInfo.swift
//  NobleBout
//
//  Created by Lee Davis on 1/9/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

import SpriteKit

class PlayerInfo {
    enum PlayerType {
        case p1
        case p2
    }
    
    let type: PlayerType
    var playerIcon: SKSpriteNode?
    var playerHealthbar: SKSpriteNode?
    
    init(type: PlayerType, infoNode: SKShapeNode) {
        self.type = type
        
//        configure(node: infoNode)
    }
    
    func configure(node: SKNode) {
        node.children.forEach { (node) in
            
        }
    }
}
