//
//  TitleSet.swift
//  NobleBout
//
//  Created by Lee Davis on 12/29/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import SpriteKit

final class TitleSet {
    var titleEmmiter: SKEmitterNode?
    
    init(dict: [String: Any]?) {
        self.titleEmmiter = dict?[ParticalFromScene.title] as? SKEmitterNode
        addPartical()
    }
    
    private func addPartical() {
        titleEmmiter?.addChild(getParticles(name: "Flames"))
    }
}
