//
//  Ex+Emitter.swift
//  NobleBout
//
//  Created by Lee Davis on 4/1/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

import SpriteKit

extension SKEmitterNode {
    func summonEmitter(with name: String) -> SKEmitterNode {
        guard let emitter = SKEmitterNode(fileNamed: name) else { return SKEmitterNode() }

        return emitter
    }
}
