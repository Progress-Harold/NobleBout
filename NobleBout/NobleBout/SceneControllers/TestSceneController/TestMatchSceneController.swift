//
//  TestMatchSceneController.swift
//  NobleBout
//
//  Created by Lee Davis on 10/3/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import SpriteKit

let rBtn = "rBtn"
let pBtn = "pBtn"
let sBtn = "sBtn"
let hDrink = "hDrinkBtn"
let eDrink = "eDrinkBtn"
let drink = "Drink"
let statusStrLble = "status"

class TestMatchSceneController: SKScene, TestButtonDelegate {
    
    // MARK: - Test Constance
    let p1Icon = "p1Icon"
    let p2Icon = "p2Icon"
    let hp1 = "hp1"
    let hp2 = "hp2"

    let hType = "h"
    let eType = "e"
    let emptyStr = ""

    var protoNames: [String] {
        return [p1Icon, p2Icon, hp1, hp2, rBtn, pBtn, sBtn, hDrink, eDrink, statusStrLble]
    }
    
    // MARK: - Button and Lable Hash
    var controlSprites = [String: Any]()
    
    var playerOne: Player = Player(.masa)
    var playerTwo: Player = Player(.tetsu)
        
    var match: Match!
    
    var hDrinksQuant: Int = 10
    var eDrinksQuant: Int = 10
    
    override func sceneDidLoad() {
        match = Match(p1: Player(.masa), p2: Player(.tetsu))
        
        setupUI()
        
        playerOne = (match?.currentBout.playerOne)!
        playerTwo = (match?.currentBout.playerTwo)!
    }
    
    override func update(_ currentTime: TimeInterval) {
        if match.matchEnded {
            
        }
        else {
            if let hpLabel = controlSprites[hp1] as? SKLabelNode {
                hpLabel.text = "HP1:\(playerOne.HP)"
            }
            if let hpLabel = controlSprites[hp2] as? SKLabelNode {
                hpLabel.text = "HP2:\(playerTwo.HP)"
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            controlSprites.forEach { (k, v) in
                if let sprite = v as? STBtn {
                    if sprite.contains(location) {
                        sprite.touchesEnded(touches, with: event)
                    }
                }
            }
        }
    }
    
    
    func didTap(_ btn: TButton) {
        switch btn {
        case .rock:
            match.setBout(.rock)
        case .paper:
            match.setBout(.paper)
        case .sissors:
            match.setBout(.scissor)
        case .hDrink:
            break
        case .eDrink:
            break
        }
        
        if !match.matchEnded {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "choiceMade"), object: nil)
        }
    }
  
    
    // MARK: - Setup
    
    func setupUI() {
        for protoSprite in children {
            if protoNames.contains(protoSprite.name ?? emptyStr) {
                if let protoSprite = protoSprite as? STBtn {
                    protoSprite.setType()
                    protoSprite.delegate = self
                    controlSprites[protoSprite.name ?? emptyStr] = protoSprite
                }
                else if let protoSprite = protoSprite as? SKLabelNode {
                    controlSprites[protoSprite.name ?? emptyStr] = protoSprite
                }
            }
        }
        
        if let statusLbl = controlSprites[statusStrLble] as? SKLabelNode {
            match.setStatusLable(statusLbl)
        }
        
        if let hpLabel = controlSprites[hp1] as? SKLabelNode {
            hpLabel.text = "HP1:\(playerOne.HP)"
        }
        if let hpLabel = controlSprites[hp2] as? SKLabelNode {
            hpLabel.text = "HP2:\(playerTwo.HP)"
        }
        
        startMatch()
    }
    
    // MARK: - Key Functionality
    
    func startMatch() {
        match?.start()
    }
    
    func drink(_ drinkName: String) {
        if drinkName.contains(hType) {
            if playerOne.HP < 80 {
                controlSprites[hp1] = "HP1:\(playerOne.HP)"
            }
        }
        else if drinkName.contains(eType) {
            if playerOne.TP < 40 {
//                controlSprites[hp2] = "HP1:\(playerTwo.HP + 10)"
            }
        }
    }
}

protocol TestButtonDelegate {
    func didTap(_ btn:TButton)
}

enum TButton {
    case rock, paper, sissors, hDrink, eDrink
}

/// SpriteNode Test Button
class STBtn: SKSpriteNode {
    
    var btnType: TButton = .rock
    
    var delegate: TestButtonDelegate?
    
    func setType() {
        guard let name = name else { return }
        
        if name == pBtn {
            btnType = .paper
        }
        else if name == sBtn {
            btnType = .sissors
        }
        else if name == hDrink {
            btnType = .hDrink
        }
        else if name == eDrink {
            btnType = .eDrink
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.didTap(btnType)
    }
}

