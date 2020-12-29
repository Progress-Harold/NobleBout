//
//  TestUIEndingScreen.swift
//  NobleBout
//
//  Created by Lee Davis on 10/11/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import Foundation
import SpriteKit

struct TestUIEndingScreen {
    var mainNode: SKNode = SKNode()
    
    private var gameOverLabel: SKLabelNode = SKLabelNode()
    private var backgroundSprt: SKSpriteNode = SKSpriteNode()
    
    init() {
        self.setupUI()
    }
    
    mutating func setupUI() {
        // Background
        let label = SKLabelNode(text: gameOverStr)
        label.alpha = 0
        gameOverLabel = label
        
        let bg = SKSpriteNode(texture: nil, color: .black, size: CGSize(width: 0, height: 0))
        bg.alpha = 0
        backgroundSprt = bg
        
        mainNode.addChild(backgroundSprt)
        backgroundSprt.addChild(gameOverLabel)
    }
    
    
    func presentWithAnim(completion:@escaping()->()) {
        let group = SKAction.group([.fadeAlpha(to: 1, duration: 0.4), .resize(toWidth: 640, height: 960, duration: 0.5)])
        backgroundSprt.run(group) {
            gameOverLabel.run(.fadeAlpha(to: 1, duration: 0.6)) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    completion()
                }
            }
        }
    }
}
