//
//  GameViewController.swift
//  NobleBout
//
//  Created by Lee Davis on 9/13/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

public protocol GameViewDelegate {
    func present(scene: SKScene)
}

class GameViewController: UIViewController {
    
    var director: Director?
    var currentScene: SKScene?

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        director?.presentTake()
    }
    
    func setup() {
        director = Director()
        director?.gameViewDelegate = self
    }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        currentScene?.motionEnded(motion, with: event)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// MARK: - GameViewDelegate

extension GameViewController: GameViewDelegate {
    func present(scene: SKScene) {
        guard let view = self.view as! SKView? else { return }
        
        scene.scaleMode = .aspectFit
        currentScene = scene
        
        view.presentScene(scene)
    }
}

