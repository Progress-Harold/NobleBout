//
//  PlayerInterfaceController.swift
//  NobleBout
//
//  Created by Lee Davis on 11/3/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import SpriteKit

protocol PlayerInterfaceControllerDelegate {
    func rInput()
    func gInput()
    func bInput()
    func yInput()
    
    func healthInput()
    func guardInput()
}

class PlayerInterfaceController: PlayerInterfaceControllerDelegate {
    
    /*
     - R, G, B, Y Buttons
     - health button
     - guard button
     */
    
    func rInput() {}
    
    func gInput() {}
    
    func bInput() {}
    
    
    func yInput() {}
    
    
    func healthInput() {}
    
    
    func guardInput() {}
    
    
}
