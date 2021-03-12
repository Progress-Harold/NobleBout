//
//  PlayerInteraction.swift
//  NobleBout
//
//  Created by Lee Davis on 1/3/21.
//  Copyright © 2021 EightFoldGames. All rights reserved.
//

import SpriteKit

protocol PlayerInteractionDelegate {
    func didInteract(with option: Interaction)
}

final class PlayerInteraction {
    
    var buttons: [Button]
    var delegate: PlayerInteractionDelegate?
    
    init(buttons: [Button]) {
        self.buttons = buttons
        configure()
    }
    
    func configure() {
        buttons.forEach { (button) in
            button.delegate = self
            button.setType()
        }
    }
}

extension PlayerInteraction: ButtonDelegate {
    func didTap(_ btn: Interaction) {
        delegate?.didInteract(with: btn)
    }
}
