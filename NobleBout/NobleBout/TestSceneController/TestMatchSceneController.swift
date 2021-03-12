//
//  TestMatchSceneController.swift
//  NobleBout
//
//  Created by Lee Davis on 10/3/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import SpriteKit

var timerOperation: DispatchGroup = DispatchGroup()

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

    // NOTE: Animate to 0 x position
    // Starting x position: -480
    
    // MARK: - TimerUI
    var visualTimerSpr: SKSpriteNode = SKSpriteNode()
    var timerActive: Bool = false
    var timerShouldRun: Bool = true
    var choiceWasMade: Bool = false
    var bufferActive: Bool = false
    var fightAnimationComplete: Bool = false
    
    var protoNames: [String] {
        return [p1Icon, p2Icon, hp1, hp2, rBtnStr, pBtnStr, sBtnStr, hDrinkStr, eDrinkStr, statusLblStr, restartBtnStr, player1Lble, player2Lble]
    }
    
    // MARK: - Button and Lable Hash
    var controlSprites = [String: Any]()
    
    var playerOne: Player = Player(.masa)
    var playerTwo: Player = Player(.tetsu)
        
    var match: Match!
    
    var hDrinksQuant: Int = 10
    var eDrinksQuant: Int = 10
    
    var opponent: Hero = .tetsu
    
    private var debugModeBtn: SKSpriteNode = SKSpriteNode()
    
    private var gameOverUI = TestUIEndingScreen()
    
    override func didMove(to view: SKView) {
        guard let pow = childNode(withName: p1w) as? SKLabelNode,
              let ptw = childNode(withName: p2w) as? SKLabelNode else {
            return
        }
    
        if ArcadeController.test_instance.heroWasChosen,
           let nextOpponent = ArcadeController.test_instance.opponent  {
            opponent = nextOpponent
            match = Match(p1: Player(ArcadeController.test_instance.chosenHero!), p2: Player(opponent), sk: ScoreKeeperTest(pow, ptw))
        }
        else {
            ArcadeController.test_instance.selectCharacter(.masa)
            guard let nextOpponent = ArcadeController.test_instance.opponent else { return }
            
            opponent = nextOpponent
            match = Match(p1: Player(ArcadeController.test_instance.chosenHero!), p2: Player(opponent), sk: ScoreKeeperTest(pow, ptw))
        }

        self.setupUI()
        playerOne = (match?.currentBout.playerOne)!
        playerTwo = (match?.currentBout.playerTwo)!
        
        startMatch()
        
        print("Before timer...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print("Timer Starting")
            self.animateTimer()
        }
    }
    
    override func sceneDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(animateTimer), name: fightAnimationEndN, object: nil)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if match.matchEnded {
            timerShouldRun = false
            bufferActive = true
            print(gameOverStr)
            loadNextMatch()
        }
        else {
            if let hpLabel = controlSprites[hp1] as? SKLabelNode {
                hpLabel.text = "HP1:\(playerOne.HP)"
            }
            if let hpLabel = controlSprites[hp2] as? SKLabelNode {
                hpLabel.text = "HP2:\(playerTwo.HP)"
            }
        }
        
        if !timerActive && self.timerShouldRun {
            self.animateTimer()
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            if timerActive, !choiceWasMade {
                bufferActive = true
                for touch in touches {
                    let location = touch.location(in: self)
                    
                    if debugModeBtn.contains(location) {
                        navBackToTitle()
                    }
                    
                controlSprites.forEach { (k, v) in
                    if let sprite = v as? STBtn,
                       sprite.name == restartBtnStr,
                       sprite.contains(location) {
                        sprite.touchesEnded(touches, with: event)
                    }
                    
                    if !match.matchEnded || !bufferActive {
                        if let sprite = v as? STBtn,
                           sprite.name != restartBtnStr {
                            if sprite.contains(location) {
                                sprite.touchesEnded(touches, with: event)
                            }
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
        choiceWasMade = true
        
        switch btn {
        case .rock:
            match.setBout(.rock)
        case .paper:
            match.setBout(.paper)
        case .sissors:
            match.setBout(.scissor)
        case .hDrink:
            choiceWasMade = false
        case .eDrink:
            choiceWasMade = false
        case .refresh:
            choiceWasMade = false
            restart()
        }
        
        
        
        if !match.matchEnded, choiceWasMade {
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
    
    
    @objc func animateTimer() {
        choiceWasMade = false
        timerActive = true

        
        if timerShouldRun {
            timerOperation.enter()
            visualTimerSpr.run(.moveTo(x: 0, duration: 4)) {
                
                if !self.choiceWasMade && !self.match.matchEnded {
                    // TODO: Choose a random option for the player, add badChoice
                    self.didTap(.paper)
                }
                
                
                timerOperation.leave()
                self.visualTimerSpr.position.x = -480
                // wait for animation
                self.timerActive = false
                self.bufferActive = false
                self.choiceWasMade = false
            }
        }
    }
    
    
    func loadNextMatch() {
        if ArcadeController.test_instance.opponent != nil {
            guard let scene = TestMatchSceneController(fileNamed: testSceneStr)  else {
                return
            }
            scene.scaleMode = .aspectFill
            
            self.view?.presentScene(scene, transition: SKTransition.fade(withDuration: 0.4))
        }
        else {
            gameOverUI.presentWithAnim() {
                ArcadeController.test_instance.chosenHero = nil
                self.navBackToTitle()
            }
        }
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
                    
                    if protoSprite.name == player1Lble {
                        protoSprite.text = ArcadeController.test_instance.chosenHero?.rawValue
                    }
                    else if protoSprite.name == player2Lble {
                        protoSprite.text = opponent.rawValue
                    }
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
        
        visualTimerSpr = self.findNode(name: timerStr)
        visualTimerSpr.zPosition = 40
        
        self.addChild(gameOverUI.mainNode)
        gameOverUI.mainNode.alpha = 1
        gameOverUI.mainNode.zPosition = 50
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
    case rock, paper, sissors, hDrink, eDrink, refresh //TODO: add badChoice case
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

