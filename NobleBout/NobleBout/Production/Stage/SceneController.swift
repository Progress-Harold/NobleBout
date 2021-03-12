//
//  SceneController.swift
//  NobleBout
//
//  Created by Lee Davis on 12/28/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import SpriteKit

@objc protocol SceneControllerDelegate {
    // MARK: - Touches
    @objc optional func sceneDidLoad()
    @objc optional func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    @objc optional func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?, scene: SKScene)
}

class SceneController: SKScene {
    var assistantDirector: AssistantDirector?
    
    var childMapDict: [String: Any] = [:]
    
    var sceneDelegate: SceneControllerDelegate?
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        children.forEach { node in
            if let name = node.name {
                childMapDict[name] = node
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sceneDelegate?.touchesBegan?(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        sceneDelegate?.touchesEnded?(touches, with: event, scene: self)
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        if motion == .motionShake {
            guard let scene = debugModeOn ? TestMatchSceneController(fileNamed: testSceneStr): SelectScreenController(fileNamed: selectScreenStr)  else {
                return
            }
            
            scene.scaleMode = .aspectFill
            self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 0.4))
        }
    }
}
