//
//  Director.swift
//  NobleBout
//
//  Created by Lee Davis on 12/28/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import SpriteKit

public protocol DirectorDelegate {
    // Current Scene
    // func - buildScript
    // func - move to a given scene
    // func - move to prev scene
    // func - move to next scene
    // func - present game over
}

/// Director is ment to manage what scenes are shown when...
public final class Director: DirectorDelegate {
    // Current Scene

    init(scenes: [SKScene]) {}
    
    // func - buildScript
    // func - move to a given scene
    // func - move to prev scene
    // func - move to next scene
    // func - present game over
}
