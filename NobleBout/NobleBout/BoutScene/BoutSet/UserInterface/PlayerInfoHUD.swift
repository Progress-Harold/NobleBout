//
//  PlayerInfoHUD.swift
//  NobleBout
//
//  Created by Lee Davis on 1/2/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

import SpriteKit

final class PlayerInfoHUD {
    
    // MARK: - Private Variables
    
    private var hpLabel1: SKLabelNode?
    private var hp1: Int = 100 {
        didSet {
            hpLabel1?.updateHPLabel(hp1)
        }
    }
    private var hpLabel2: SKLabelNode?
    private var hp2: Int = 100 {
        didSet {
            hpLabel2?.updateHPLabel(hp2)
        }
    }
    
    init(_ hpLabel1: SKLabelNode,
         _ hpLabel2: SKLabelNode) {
        self.hpLabel1 = hpLabel1
        self.hpLabel2 = hpLabel2
    }
    
    enum Player { case playerOne, playerTwo }
    
    func decreaseHP(_ player: Player) {
        switch player {
        case .playerOne:
            hp1 -= 10
        case .playerTwo:
            hp2 -= 10
        }
    }
}

