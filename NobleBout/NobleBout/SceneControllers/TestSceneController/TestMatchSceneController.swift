//
//  TestMatchSceneController.swift
//  NobleBout
//
//  Created by Lee Davis on 10/3/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import SpriteKit

class TestMatchSceneController: SKScene, TestButtonDelegate {
    
    // MARK: - Test Constance
    let p1Icon = "p1Icon"
    let p2Icon = "p2Icon"
    let hp1 = "hp1"
    let hp2 = "hp2"
    let p1w = "p1Wins"
    let p2w = "p2Wins"
    
    let hType = "h"
    let eType = "e"
    let emptyStr = ""

    var protoNames: [String] {
        return [p1Icon, p2Icon, hp1, hp2, rBtnStr, pBtnStr, sBtnStr, hDrinkStr, eDrinkStr, statusLblStr, restartBtnStr]
    }
    
    // MARK: - Button and Lable Hash
    var controlSprites = [String: Any]()
    
    var playerOne: Player = Player(.masa)
    var playerTwo: Player = Player(.tetsu)
        
    var match: Match!
    
    var hDrinksQuant: Int = 10
    var eDrinksQuant: Int = 10
    
    private var debugModeBtn: SKSpriteNode = SKSpriteNode()
    
    override func sceneDidLoad() {
        guard let pow = childNode(withName: p1w) as? SKLabelNode,
              let ptw = childNode(withName: p2w) as? SKLabelNode else {
            return
        }
        
        match = Match(p1: Player(.masa), p2: Player(.tetsu), sk: ScoreKeeper(pow, ptw))
        
        setupUI()
        
        playerOne = (match?.currentBout.playerOne)!
        playerTwo = (match?.currentBout.playerTwo)!
        
        startMatch()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if match.matchEnded {
            print(gameOverStr)
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
                        
            for touch in touches {
                let location = touch.location(in: self)
                
                if debugModeBtn.contains(location) {
                    navBackToTitle()
                }
            }
            
            controlSprites.forEach { (k, v) in
                if !match.matchEnded {
                    if let sprite = v as? STBtn {
                        if sprite.contains(location) {
                            sprite.touchesEnded(touches, with: event)
                        }
                    }
                }
            }
        }
    }
    
    
    // MARK: - UI Methods
    
    func navBackToTitle() {
        guard let scene = TitleSceneController(fileNamed: titleScreenStr)  else {
            return
        }
        
        scene.scaleMode = .aspectFill
        self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 0.4))
    }
    
    
    func didTap(_ btn: TButton) {
        var choiceMade = true
        
        switch btn {
        case .rock:
            match.setBout(.rock)
        case .paper:
            match.setBout(.paper)
        case .sissors:
            match.setBout(.scissor)
        case .hDrink:
            choiceMade = false
        case .eDrink:
            choiceMade = false
        case .refresh:
            choiceMade = false
            restart()
        }
        
        if !match.matchEnded, choiceMade {
            NotificationCenter.default.post(name: choiceMadeN, object: nil)
        }
    }
    
    func restart() {        
        guard let scene = TestMatchSceneController(fileNamed: testSceneStr)  else {
            return
        }
        
        scene.scaleMode = .aspectFill
        self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 0.4))
    }
    
    
    // MARK: - Setup
    
    func setupUI() {
        for protoSprite in children {
            if protoNames.contains(protoSprite.name ?? emptyStr) {
                if let protoSprite = protoSprite as? STBtn {
                    print(protoSprite)
                    protoSprite.setType()
                    protoSprite.delegate = self
                    controlSprites[protoSprite.name ?? emptyStr] = protoSprite
                }
                else if let protoSprite = protoSprite as? SKLabelNode {
                    controlSprites[protoSprite.name ?? emptyStr] = protoSprite
                }
            }
        }
        
        if let statusLbl = controlSprites[statusLblStr] as? SKLabelNode {
            match.setStatusLable(statusLbl)
        }
        
        if let dbgBtn = self.childNode(withName: titleNavBtnStr) as? SKSpriteNode {
            debugModeBtn = dbgBtn
        }
        
        if let hpLabel = controlSprites[hp1] as? SKLabelNode {
            hpLabel.text = "HP1:\(playerOne.HP)"
        }
        if let hpLabel = controlSprites[hp2] as? SKLabelNode {
            hpLabel.text = "HP2:\(playerTwo.HP)"
        }
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
    case rock, paper, sissors, hDrink, eDrink, refresh
}

/// SpriteNode Test Button
class STBtn: SKSpriteNode {
    
    var btnType: TButton = .rock
    
    var delegate: TestButtonDelegate?
    
    func setType() {
        guard let name = name else { return }
        
        if name == pBtnStr {
            btnType = .paper
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
        self.run(.resize(byWidth: 50, height: 50, duration: 0.2)) {
            self.run(.resize(byWidth: -50, height: -50, duration: 0.2))
        }
    }
}

