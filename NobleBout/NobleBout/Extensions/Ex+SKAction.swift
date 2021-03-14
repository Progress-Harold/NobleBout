//
//  Ex+SKAction.swift
//  NobleBout
//
//  Created by Lee Davis on 3/13/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

import SpriteKit

extension SKAction {
    
    static func getAction(by name: String) -> SKAction {
        guard let action = SKAction(named: name) else {
            return SKAction()
        }
        
        return action
    }
}
