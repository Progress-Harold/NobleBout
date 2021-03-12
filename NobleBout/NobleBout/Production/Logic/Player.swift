//
//  Player.swift
//  NobleBout
//
//  Created by Lee Davis on 3/7/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

import SpriteKit

class Player {
    
    var HP: Int = 10
    var TP: Int = 60
    
    private let hero: Hero
    private var passiveAbilities: [Buff] = []
    
    init(_ hero: Hero) {
        self.hero = hero
        self.passiveAbilities = hero.natruralBuffs
    }
    
    func refresh() {
        self.HP = 10
        self.TP = 60
    }
    
    private var spirite: Int = 0
    
    func spiritOrbs() -> Int {
        var total = spirite
        var spiritOrbNum: Int = 0
        
        while total > 0 || !((total - 20) < 0) || spiritOrbNum < 4 {
            total -= total - 20
            spiritOrbNum += 1
        }
        
        return spiritOrbNum
    }
}
