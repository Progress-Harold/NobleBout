//
//  Director.swift
//  NobleBout
//
//  Created by Lee Davis on 12/28/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import SpriteKit

public protocol DirectorDelegate {
    var currentSet: StageSet? { get }
    
    func buildScript(completion: (_ scene: SKScene?)->())
    func presentTake()
    // func - move to a given scene
    // func - move to prev scene
    // func - move to next scene
    // func - present game over
}

/// Director is ment to manage what scenes are shown when...
final class Director: DirectorDelegate {
    // Current Scene
    public var currentSet: StageSet?

    var gameViewDelegate: GameViewDelegate?
    
    init() {
        currentSet = Stage.order.first
    }
    
    public func buildScript(completion: (_ scene: SKScene?)->()) {
        completion(currentSet?.scene)
    }
    
    public func presentTake() {
        buildScript { scene in
            guard let scene = scene else { return }
            gameViewDelegate?.present(scene: scene)
        }
    }
}
