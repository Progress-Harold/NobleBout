//
//  PlayerInterface.swift
//  NobleBout
//
//  Created by Lee Davis on 1/2/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

import SpriteKit

final class PlayerInterface {
    enum Player { case p1, p2 }
    enum Move: String {
        case p = "Punch"
        case r = "Kick"
        case s = "Ability"
    }
    
    var status: SKLabelNode?
    var playerAvatarOne: SKSpriteNode!
    var playerAvatarTwo: SKSpriteNode!
    
    init(_ avatarOne: SKSpriteNode,_ avatarTwo: SKSpriteNode) {
        self.playerAvatarOne = avatarOne
        self.playerAvatarTwo = avatarTwo
    }
    
    func animate(player: Player, with move: Move, completion: @escaping(()->())) {
        let playerAvatar = (player == .p1) ? playerAvatarOne : playerAvatarTwo
        let moveForward: SKAction = .moveTo(x: 150, duration: 0.6)
        let moveBackwards: SKAction = .moveTo(x: -150, duration: 0.6)
        
        playerAvatar?.run((player == .p1) ? moveForward : moveBackwards) {
            completion()
            playerAvatar?.run(SKAction.getAction(by:(player == .p1) ? SpriteActionsName.masa.mPunch : SpriteActionsName.tetsu.mPunch)) {
                playerAvatar?.run((player == .p1) ? moveBackwards : moveForward)
            }
        }
    }
}
