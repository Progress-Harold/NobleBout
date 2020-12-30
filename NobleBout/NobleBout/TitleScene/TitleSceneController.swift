//
//  TitleSceneController.swift
//  NobleBout
//
//  Created by Anthony Torres on 9/14/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import Foundation
import SpriteKit

class TitleSceneController: SceneController {
    override func sceneDidLoad() {
        super.sceneDidLoad()
  
        assistantDirector = TitleAssistantDirector(childMapDict)
        sceneDelegate = assistantDirector as? SceneControllerDelegate
    }
}
