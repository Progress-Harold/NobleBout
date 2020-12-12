//
//  TestLogic.swift
//  NobleBout
//
//  Created by Lee Davis on 10/4/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//


import Foundation
import SpriteKit

/*
* Logic Summery *
 
 > Match - A match will run bouts until a player's score reaches
    > Bouth - A bout will run indevidual janken rounds until a players hp is 0
        > Janken
                - A janken round is when a player one's choice of r,p, or s is placed against a random choice.
                - The winner will take hp from the other
 */


// MARK: - Components

// MARK: - Enums
enum Winner: String {
    case pOne, pTwo, draw
}
enum Choice: String {
    case paper, rock, scissor
}

// Posible choices
let choices: [Choice] = [.paper, .rock, .scissor]

// Janken
typealias JankenCombo = (Choice, Choice)
func jankenKeyGen(_ combo: JankenCombo) -> String {
    return "\(combo.0)V\(combo.1)"
}

// TODO: - Add constance
let resultsDict: [String: Winner] = {
    return [
        // - Paper:
        "paperVrock": .pOne,
        "paperVscissor": .pTwo,
        "paperVpaper": .draw,
        // - Scissors:
        "scissorVrock": .pTwo,
        "scissorVpaper": .pOne,
        "scissorVscissor": .draw,
        // - Rock
        "rockVscissor": .pOne,
        "rockVpaper": .pTwo,
        "rockVrock": .draw,
    ]
}()


enum Buff {
    // Buffs
    case hp
    case def
    case special
    case energy
    // Unique
    case fire
    case healing
    case stun
    case poison
    case debuff
    
    case atkL // Low incease in power
    case atkM // Medium incease in power
    case atkH // High incease in power
    
    case defL // small increase in def
    case defM // increase in def
    case defH // big increase in def
}

enum Hero: String {
    case masa
    case tetsu
    case eris
    case abziu
    case griff
    
    var natruralBuffs: [Buff] {
        let buffs: [Buff]
        switch self {
            case .masa:
            buffs = [.stun]
            case .tetsu:
            buffs = [.fire]
            case .eris:
            buffs = [.healing]
            case .abziu:
            buffs = [.poison]
            case .griff:
            buffs = [.debuff]
        }
        return buffs
    }
    
    var roster: [Hero] {
        switch self {
        default:
            return [.griff, .eris, .abziu, .tetsu]
        }
    }
}


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

// MARK: - Match Flow Logic

/// JankenRound
struct JankenRound {
    let pOChoice: Choice
    let pTChoice: Choice
    
    func winner() -> Winner {
        guard (resultsDict[jankenKeyGen((pOChoice, pTChoice))] != nil) else {
            print("\(jankenKeyGen((pOChoice, pTChoice))) is not in the dictionary.")
            return .draw
        }
        
        return resultsDict[jankenKeyGen((pOChoice, pTChoice))]!
    }
    
    init(_ p1c:Choice, _ p2c: Choice) {
        self.pOChoice = p1c
        self.pTChoice = p2c
    }
}


/// Bout
class Bout {
    var playerOne: Player!
    var playerTwo: Player!
    
    var boutEnded: Bool = false
    var winner: Winner?
    
    init() { // set player based on choice
        testSetPlayers()
    }
    
    convenience init(_ p1: Player, _ p2: Player) {
        self.init()
        
        self.playerOne = p1
        self.playerTwo = p2
    }
    
    func testGame() {
        while boutEnded != true {
            if (playerOne.HP > 0) && (playerTwo.HP > 0) {
                play(.paper,.rock){_ in }
            }
            else  {
                end()
            }
        }
    }
    
    func play(_ p1c: Choice, _ p2c: Choice, completion: @escaping(_ shouldContinue: Bool?)->()) {
        let j = JankenRound(p1c, p2c)
        switch j.winner() {
            case .pOne:
                playerTwo.HP -= 10
                // "p2 hp decreased"
            case .pTwo:
                playerOne.HP -= 10
                // "p2 hp decreased"
            case .draw:
                // "Draw"
            break
        }
        
        winner = j.winner()
        
        completion((playerOne.HP > 0) && (playerTwo.HP > 0))
    }
    
    private func end() {
        if playerOne.HP <= 0 {
            winner = .pTwo
        }
        else if playerTwo.HP <= 0 {
            winner = .pOne
        }
        else {
            winner = .draw
        }
        
        boutEnded.toggle()
    }
    
    func reset() {
        playerOne.refresh()
        playerTwo.refresh()
    }
    
    private func testSetPlayers() {
        // set player properties
        playerOne = Player(.masa)
        playerTwo = Player(.tetsu)
    }
}


/// Match
class Match {
    var sk: ScoreKeeper
    
    var p1Choice: Choice?
    var p2Choice: Choice?
    
    var matchEnded: Bool = false
    private var statusLabel: SKLabelNode = SKLabelNode()
    
    var currentBout: Bout
    
    init(p1: Player, p2: Player, sk: ScoreKeeper) {
        currentBout = Bout(p1, p2)
        self.sk = sk
    }
    
    
    func start() {
        // prompt for choice
        statusLabel.text = choiceMsgStr
        
        NotificationCenter.default.addObserver(self, selector: #selector(playWithChoices), name: choiceMadeN, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reset), name: resetMatchN, object: nil)

        // pick a random choice for Computer
        
        // use current bout to play a bout
        // if no player HP is 0 or lower than prompt again.
        // if bout should end then
        // - award winner a win
        // - check if a player's score has reach 2 than end the round
        // - set matchEnded Bool to true
    }
    
    private func end() {
        statusLabel.text = gameOverStr
        matchEnded.toggle()
    }

    @objc private func reset() {
        currentBout.reset()
        statusLabel.text = choiceMsgStr
    }
    func pause() {}
    
    func setBout(_ choice: Choice) {
        let randomNum = arc4random_uniform(UInt32(choices.count))
        let p2C = choices[Int(randomNum)]
        
        p1Choice = choice
        p2Choice = p2C
    }
    
    @objc func playWithChoices() {
        guard let c1 = p1Choice,
              let c2 = p2Choice else { return }
        
        if !currentBout.boutEnded {
            currentBout.play(c1, c2) { (shouldContinue) in
                
                if let win = self.currentBout.winner {
                    self.statusLabel.text = "\(win)"
                }

                // TODO: Wait for timer animation
                if let shouldContinue = shouldContinue {
                    if !shouldContinue {
                        
                        self.presentWinner()
                        
                        if self.matchEnded {
                            self.statusLabel.text = gameOverStr
                            self.sk.updateUI()
                            print("\(debugWinsStr)\(self.sk.pOScore.0)")
                            print("\(debugWinsStr)\(self.sk.pTScore.0)")
                        }
                        else {
                            print("\(debugWinsStr)\(self.sk.pOScore.0)")
                            print("\(debugWinsStr)\(self.sk.pTScore.0)")
                        }
                    }
                }
            }
        }
    }
    
    private func presentWinner() {

        let winner = currentBout.winner
        
        switch winner {
        case .pOne:
            if sk.pOScore.0 < 2 {
                sk.pOScore.0 += 1
                if !(sk.pOScore.0 < 2) {
                    self.reset()
                    self.end()
                }
            }
        case .pTwo:
            if sk.pTScore.0 < 2 {
                sk.pTScore.0 += 1
                if !(sk.pTScore.0 < 2) {
                    self.reset()
                    self.end()
                }
            }
        case .draw:
            break
        case .none:
            break
        }
        
        // Animate fight
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if !self.matchEnded {
                self.sk.updateUI()
                self.statusLabel.text = "\(winnerStr)\(winner!)"
            }
        }
    }
    
    func setStatusLable(_ lbl: SKLabelNode) {
        statusLabel = lbl
    }
}


class ScoreKeeper {
    typealias Score = (Int, SKLabelNode)
    
    var pOScore: Score
    var pTScore: Score
    
    init(_ p1: SKLabelNode, _ p2: SKLabelNode) {
        self.pOScore.1 = p1
        self.pTScore.1 = p2
        
        self.pOScore.0 = 0
        self.pTScore.0 = 0
    }
    
    func updateUI() {
        NotificationCenter.default.post(name: fightAnimationEndN, object: nil)

        pOScore.1.text = "\(debugWinsStr)\(pOScore.0)"
        pTScore.1.text = "\(debugWinsStr)\(pTScore.0)"
    }
}


class ArcadeController {
    static var test_instance =  ArcadeController()
    
    var chosenHero: Hero?
    var heroWasChosen: Bool {
        return (chosenHero != nil)
    }
    var opponent: Hero? {
        return upNext()
    }
    
    private var rosterStack = [Hero]()
    
    
    func selectCharacter(_ chosenHero: Hero) {
        self.chosenHero = chosenHero
        
        rosterStack = chosenHero.roster.reversed()
    }
    
    private func upNext() -> Hero? {
        guard chosenHero != nil else {
            print("No Hero was selected!")
            return nil
        }
        
        return rosterStack.popLast()
    }
}





