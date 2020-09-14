//
//  Utilities.swift
//  NobleBout
//
//  Created by Anthony Torres on 9/14/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import Foundation
import SpriteKit

func getParticles(name: String) -> SKEmitterNode {
    if let particle = SKEmitterNode(fileNamed: name) {
        return particle
    }
    else {
        return SKEmitterNode()
    }
}
