//
//  Director.swift
//  NobleBout
//
//  Created by Lee Davis on 12/28/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import SpriteKit

public protocol DirectorDelegate {
    var currentSet: StageSet? { get set }
    
    func buildScript(completion: (_ scene: SKScene?)->())
    func presentTake(_ withSet: StageSet?)
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
    // 1
    public func buildScript(completion: (_ scene: SKScene?)->()) {
        let scene = currentSet?.scene
        scene?.assistantDirector?.director = self
        completion(scene)
    }
    // 2
    public func presentTake(_ withSet: StageSet?) {
        if let set = withSet {
            currentSet = set
            
            guard let scene = currentSet?.scene else { return }
            scene.assistantDirector?.director = self
            gameViewDelegate?.present(scene: scene)
        }
        else {
            buildScript { scene in
                guard let scene = scene else { return }
                gameViewDelegate?.present(scene: scene)
            }
        }
    }
}
