//
//  SceneController.swift
//  NobleBout
//
//  Created by Lee Davis on 12/28/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import SpriteKit

public protocol SceneControllerDelegate {
    var assistantDirector: AssistantDirector! { get }
    var childMapDict: [String: Any] { get set }
}

class SceneController: SKScene, SceneControllerDelegate {
    var assistantDirector: AssistantDirector!
    
    var childMapDict: [String: Any] = [:]
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        children.forEach { node in
            if let name = node.name {
                childMapDict[name] = node
            }
        }
    }
}
