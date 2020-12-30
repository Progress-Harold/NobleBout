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

public protocol ViewControllerDelegate {
    func viewDidLoad()
    func setup()
    func present()
}

public class GameViewController: UIViewController, GameViewDelegate {
    
    var director: Director?
    var currentScene: SKScene?
    
    var delegate: ViewControllerDelegate?

    public override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        director?.presentTake()
        delegate?.viewDidLoad()
    }
    
    func setup() {
        director = Director()
        director?.gameViewDelegate = self
        delegate?.setup()
    }

    public override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        currentScene?.motionEnded(motion, with: event)
    }
    
    public override var prefersStatusBarHidden: Bool {
        return true
    }

// MARK: - GameViewDelegate

    public func present(scene: SKScene) {
        guard let view = self.view as? SKView else { return }
        
        delegate?.present()
        scene.size = CGSize(width: 1536, height: 2048)
        scene.scaleMode = .aspectFill
        currentScene = scene
        
        view.presentScene(scene)
    }
}

