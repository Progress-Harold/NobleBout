//
//  Button.swift
//  NobleBout
//
//  Created by Lee Davis on 1/3/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

import SpriteKit

protocol ButtonDelegate {
    func didTap(_ btn:Interaction)
}

final class Button: SKSpriteNode {
    
    var btnType: Interaction = .rock
    
    var delegate: ButtonDelegate?
    
    func setType() {
        guard let name = name else { return }
        
        if name == pBtnStr {
            btnType = .paper
        }
        else if name == rBtnStr {
            btnType = .rock
        }
        else if name == sBtnStr {
            btnType = .sissors
        }
        else if name == hDrinkStr {
            btnType = .hDrink
        }
        else if name == eDrinkStr {
            btnType = .eDrink
        }
        else if name == restartBtnStr {
            btnType = .refresh
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.didTap(btnType)
        print("Test button \(btnType)")
    }
}
