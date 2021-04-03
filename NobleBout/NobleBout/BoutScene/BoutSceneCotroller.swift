//
//  BoutSceneCotroller.swift
//  NobleBout
//
//  Created by Lee Davis on 1/2/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

import SpriteKit

final class BoutSceneController: SceneController {
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        assistantDirector = BoutAssistantDirector(childMapDict)
        (assistantDirector as? BoutAssistantDirector)?.delegate = self
        
        sceneDelegate = assistantDirector as? SceneControllerDelegate
    }
}

extension BoutSceneController: BoutAssistantDirectorDelegate {
    func pauseAndEnterMenue() {
        pause() // TODO: - Added a start menu
    }
    
    func returnToMenu() {
        assistantDirector?.director?.presentTake(.title)
    }
}
