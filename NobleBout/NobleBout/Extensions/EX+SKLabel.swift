//
//  EX+SKLabel.swift
//  NobleBout
//
//  Created by Lee Davis on 1/2/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

import SpriteKit

extension SKLabelNode {
    func updateHPLabel(_ hpNum: Int) {
        text = "HP:" + String(hpNum)
    }
}
