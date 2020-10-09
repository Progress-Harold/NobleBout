//
//  Ex+SKNode.swift
//  NobleBout
//
//  Created by Anthony Torres on 10/9/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import Foundation
import SpriteKit

extension SKNode {
    
    func findNode(name: String) -> SKSpriteNode {
        guard let spriteNode = self.childNode(withName: name) as? SKSpriteNode else {
            return SKSpriteNode()
        }
        
        return spriteNode
    }
}
