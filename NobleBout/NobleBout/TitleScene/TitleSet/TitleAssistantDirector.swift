//
//  TitleAssistantDirector.swift
//  NobleBout
//
//  Created by Lee Davis on 12/29/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import SpriteKit

final class TitleAssistantDirector: AssistantDirector {
    
    var titleSet: TitleSet?

    override func setStage(_ wardrobeDict: [String : Any]) {
        titleSet = TitleSet(dict: wardrobeDict)
    }
}

// MARK: - Touches

extension TitleAssistantDirector: SceneControllerDelegate {
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?, scene: SKScene) {
        director?.currentSet = .bout
        director?.presentTake(nil)
    }
}
