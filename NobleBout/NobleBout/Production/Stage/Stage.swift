//
//  Stage.swift
//  NobleBout
//
//  Created by Lee Davis on 12/28/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import SpriteKit

public enum StageSet {
    case onboard
    case title
    case selectionScreen
    case bout
    case scoreboard
    case store
    case credits
    case options
    
    var scene: SceneController? {
        switch self {

        case .onboard:
            return nil
        case .title:
            return TitleSceneController(fileNamed: titleScreenStr)
        case .selectionScreen:
            return SelectScreenController(fileNamed: selectScreenStr)
        case .bout:
            return BoutSceneController(fileNamed: "BoutScene")
        case .scoreboard, .store, .credits, .options:
            return nil
        }
    }
}

struct Stage {
    static var order: [StageSet] = [.title, .selectionScreen, .bout, .title]
}
