//
//  UIStrings.swift
//  NobleBout
//
//  Created by Anthony Torres on 10/2/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import SpriteKit

// MARK: -

let charPlaceholderStr: String = "charPlaceholder"
let selectBtnStr: String = "selectBtn"

// Scene sks file names:
let titleScreenStr = "TitleScene"
let selectScreenStr = "SelectScreen"

// MARK: - Test Strings
let debugModeStr = "debugMode"
let debugWinsStr = "Wins:"
let titleNavBtnStr = "backToTitle"
let gameOverStr = "GameOver"
let winnerStr = "Winner"
// Status Messages
let choiceMsgStr = "Make a choice!"
// TestScene
let testSceneStr = "TestMatchScene"
// Misc:
let timerStr = "timer"

// MARK: - Test Buttons
let rBtnStr = "punch" // rock || punch
let pBtnStr = "ability" // papper || ability
let sBtnStr = "kick" // sciccors || kick
let restartBtnStr = "restartBtn"

let buttonStrs = ["punch","kick", "ability", "block"]


let hDrinkStr = "hDrinkBtn"
let eDrinkStr = "eDrinkBtn"
let drinkStr = "Drink"

// Labels
let statusLblStr = "status"
let player1Lble = "Player1Lble"
let player2Lble = "Player2Lble"

enum Labels {
    static let hp = "hp"
    static let name = "name"
}


enum UserInterface {
    static let healthBar = "healthBar"
}

enum SpriteActionsName {
//    static let reduceHealth90 = SKAction.getAction(by: "reduceTo")
    static let reduceHealth = "reduceTo"
}

enum ParticalFromScene {
    static let title = "TitleParticles"
}

enum Partical {
    static let flames = "Flames"
}

enum Textures {
    static let healthBar = SKTexture(imageNamed: "HealthBar")
}
