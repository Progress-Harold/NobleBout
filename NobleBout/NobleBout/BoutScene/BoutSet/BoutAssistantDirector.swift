//
//  BoutAssistantDirector.swift
//  NobleBout
//
//  Created by Lee Davis on 1/2/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

import SpriteKit

class BoutAssistantDirector: AssistantDirector {
    var boutSet: BoutSet?
    
    override func setStage(_ wardrobeDict: [String : Any]) {
        boutSet = BoutSet(wardrobeDict)
    }
}

extension BoutAssistantDirector: SceneControllerDelegate {
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        boutSet?.playerInterface?.playerAvatarOne.run(.moveTo(x: (boutSet?.playerInterface?.playerAvatarOne.position.x)! + 100, duration: 1)) {
            self.boutSet?.playerInterface?.playerAvatarOne.run(.moveTo(x: (self.boutSet?.playerInterface?.playerAvatarOne.position.x)! + -100, duration: 1))
        }
    }
}
