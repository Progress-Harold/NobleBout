//
//  PlayerInterface.swift
//  NobleBout
//
//  Created by Lee Davis on 1/2/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

import SpriteKit

final class PlayerInterface {
    var status: SKLabelNode?
    var playerAvatarOne: SKSpriteNode!
    var playerAvatarTwo: SKSpriteNode!
    
    init(_ avatarOne: SKSpriteNode,_ avatarTwo: SKSpriteNode) {
        self.playerAvatarOne = avatarOne
        self.playerAvatarTwo = avatarTwo
    }
}
