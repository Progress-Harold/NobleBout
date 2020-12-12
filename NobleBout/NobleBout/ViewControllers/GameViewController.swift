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

class GameViewController: UIViewController {
    
    var scene: SKScene?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            scene = TitleSceneController(fileNamed: "TitleScene") // SKScene(fileNamed: "TestSelectScene") {
                // Set the scale mode to scale to fit the window
            scene?.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            
            //view.ignoresSiblingOrder = true
            
            //view.showsFPS = true
            //view.showsNodeCount = true
        }
    }
    

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        scene?.motionEnded(motion, with: event)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
