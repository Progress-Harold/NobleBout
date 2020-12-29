//
//  SelectScreenController.swift
//  NobleBout
//
//  Created by Anthony Torres on 9/25/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import SpriteKit

class SelectScreenController: SceneController {
    
    var charArray: [SKSpriteNode] = []
    // UI Properties
    var charPlaceholderSprite: SKSpriteNode = SKSpriteNode()
    var selectButton: SKSpriteNode = SKSpriteNode()
    
    var lastCharSelected: String = rsMasa.convertName()
    
    // MARK: - Scene Life Cycle
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        getCharButtons()
        setupUI()
    }
    
    
    // MARK: - Setup Functions
    
    func setupUI() {
        guard let cam = camera else { return }
        
        charPlaceholderSprite = cam.findNode(name: charPlaceholderStr)
        selectButton = cam.findNode(name: selectBtnStr)
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
            
            if selectButton.contains(location) {
                print(lastCharSelected)
            }
            
            // Detecting a selected character
            for character in charArray {
                if character.contains(location) {
                    if let name = character.name {
                        charPlaceholderSprite.texture = SKTexture(imageNamed: name.convertName())
                        lastCharSelected = name.convertName()
                    }
                }
            }
        }
    }
}
