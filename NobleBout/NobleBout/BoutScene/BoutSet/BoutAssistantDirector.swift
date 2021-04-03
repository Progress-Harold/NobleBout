//
//  BoutAssistantDirector.swift
//  NobleBout
//
//  Created by Lee Davis on 1/2/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

import SpriteKit

protocol BoutAssistantDirectorDelegate: AnyObject {
    func pauseAndEnterMenue()
    func returnToMenu()
}

final class BoutAssistantDirector: AssistantDirector {
    var delegate: BoutAssistantDirectorDelegate?
    
    private var boutSet: BoutSet?
    private let moderator = Moderator()
    private var isInteracting: Bool = false
    
    override func setStage(_ wardrobeDict: [String : Any]) {
        boutSet = BoutSet(wardrobeDict)
        boutSet?.delegate = self
        boutSet?.playerInteraction?.delegate = self
        moderator.delegate = self
    }
    
    // start next round
    // end round
    // return to menu
    // enter start menu
    
}

extension BoutAssistantDirector: SceneControllerDelegate {
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?, scene: SKScene) {
        if isInteracting == false {
            isInteracting = true
            
            for touch in touches {
                let location = touch.location(in: scene)
                
                boutSet?.playerInteraction?.buttons.forEach { button in
                    if button.contains(location) {
                        button.touchesEnded(touches, with: event)
                    }
                }
            }
        }
    }
}

extension BoutAssistantDirector: PlayerInteractionDelegate {
    func didInteract(with option: Interaction) {
        var choice: RuleBook.Choice = .paper
        switch option {
        case .rock:
            choice = .rock
        case .paper:
            choice = .paper
        case .sissors:
            choice = .scissor
        case .hDrink, .eDrink, .refresh:
            break
        }
        
        moderator.bout(choice1: choice, choice2: .paper) // Fix this with NPC functionality and randome choice from p2...
    }
}


// MARK: - ModeratorDelegate

extension BoutAssistantDirector: ModeratorDelegate {
    func updateRoundScore(p1: Int, p2: Int) {
        // not needed?
    }
    
    func didDetermineBout(winner: RuleBook.Winner) {
        let player: PlayerInterface.Player = winner == .pOne ? .p1 : .p2
        
        boutSet?.playerInterface?.animate(player: player, with: .p) { [weak self] in
            guard let myself = self else { return }
            myself.boutSet?.scoreKeeper.bout(winner: winner)
            myself.isInteracting = false
        }
    }
}

extension BoutAssistantDirector: BoutSetDelegate {
    func returnToStartMenu() {
        delegate?.returnToMenu()
    }
}
