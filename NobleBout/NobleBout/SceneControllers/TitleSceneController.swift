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
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        titleEmmiter = getParticles(name: "Flames")
        
        if let emmiter = self.childNode(withName: "TitleParticles") as? SKEmitterNode {
            titleEmmiter.position = emmiter.position
            self.addChild(titleEmmiter)
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let scene = SelectScreenController(fileNamed: "SelectScreen")  else {
            return
        }
        scene.scaleMode = .aspectFill
        self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 0.4))
    }
}
