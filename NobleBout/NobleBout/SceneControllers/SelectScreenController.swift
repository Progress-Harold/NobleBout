//
//  SelectScreenController.swift
//  NobleBout
//
//  Created by Anthony Torres on 9/25/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import SpriteKit

class SelectScreenController: SKScene {
    
    var charArray: [SKSpriteNode] = []
    var charPlaceholderSprite: SKSpriteNode = SKSpriteNode()
    
    // MARK: - Scene Life Cycle
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        getCharButtons()
        setupUI()
    }
    
    
    // MARK: - Setup Functions
    
    func setupUI() {
        guard let cam = camera else { return }
        
        if let placeholder = cam.childNode(withName: charPlaceholder) as? SKSpriteNode {
            charPlaceholderSprite = placeholder
        }
    }
    
    func getCharButtons() {
        guard let camChildren = camera?.children else { return }
        
        for node in camChildren {
            if rsCharStr.contains(node.name ?? "") {
                if let cNode = node as? SKSpriteNode {
                  charArray.append(cNode)
                }
            }
        }
    }
    
    
    // MARK: - Handle Touches
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            for character in charArray {
                if character.contains(location) {
                    if let name = character.name {
                        charPlaceholderSprite.texture = SKTexture(imageNamed: name.convertName())
                    }
                }
            }
        }
    }
}
