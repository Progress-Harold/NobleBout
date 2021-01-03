//
//  BoutSet.swift
//  NobleBout
//
//  Created by Lee Davis on 1/2/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

import SpriteKit


final class BoutSet {
    var hpDisplay: PlayerInfoHUD?
    
    init(_ dict: [String: Any]) {
        guard let labelOne = dict["hp1"] as? SKLabelNode,
              let labelTwo = dict["hp2"] as? SKLabelNode
        else {
            print("No good, could not find labels.")
            return
        }
        
        hpDisplay = PlayerInfoHUD(labelOne, labelTwo)
    }
}
