//
//  EX+View.swift
//  NobleBout
//
//  Created by Lee Davis on 12/28/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import SpriteKit

extension SKView {
    func setDebugHUD() {
        self.ignoresSiblingOrder = true
        self.showsFPS = true
        self.showsNodeCount = true
    }
}
