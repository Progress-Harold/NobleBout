//
//  BoutSceneCotroller.swift
//  NobleBout
//
//  Created by Lee Davis on 1/2/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

import SpriteKit

class BoutSceneController: SceneController {
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        assistantDirector = BoutAssistantDirector(childMapDict)
        sceneDelegate = assistantDirector as? SceneControllerDelegate
    }
}
