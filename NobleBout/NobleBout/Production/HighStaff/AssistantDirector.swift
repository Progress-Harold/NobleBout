//
//  AssistantDirector.swift
//  NobleBout
//
//  Created by Lee Davis on 12/28/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import SpriteKit

public protocol AssistantDirectorDelegate {
    var director: DirectorDelegate? { get set }
    func setStage(_ wardrobeDict: [String: Any])
}

class AssistantDirector: AssistantDirectorDelegate {
    var director: DirectorDelegate?
    
    init(_ dict: [String: Any]) { setStage(dict) }
    
    func setStage(_ wardrobeDict: [String: Any]) {
        print("WARNING: Your not doing anything in your `setStage(_ wardrobeDict:...`")
    }
}
