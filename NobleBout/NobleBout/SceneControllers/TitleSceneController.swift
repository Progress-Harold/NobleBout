//
//  TitleSceneController.swift
//  NobleBout
//
//  Created by Anthony Torres on 9/14/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import Foundation
import SpriteKit

class TitleSceneController: SKScene {
    
    var titleEmmiter: SKEmitterNode = SKEmitterNode()
    
    private var debugModeBtn: SKSpriteNode = SKSpriteNode()
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        titleEmmiter = getParticles(name: "Flames")
        
        if let emmiter = self.childNode(withName: "TitleParticles") as? SKEmitterNode {
            titleEmmiter.position = emmiter.position
            self.addChild(titleEmmiter)
        }
        
        if let dbgBtn = self.childNode(withName: debugModeStr) as? SKSpriteNode {
            debugModeBtn = dbgBtn
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var debugModeOn = false
        
        for touch in touches {
            let location = touch.location(in: self)
            
            debugModeOn = debugModeBtn.contains(location)
        }
        
        guard let scene = debugModeOn ? TestMatchSceneController(fileNamed: testSceneStr): SelectScreenController(fileNamed: selectScreenStr)  else {
            return
        }
        
        scene.scaleMode = .aspectFill
        self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 0.4))
    }
}
