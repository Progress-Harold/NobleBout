//
//  Ex+String.swift
//  NobleBout
//
//  Created by Anthony Torres on 10/2/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import Foundation

extension String {
    /// This function lets us turn a short name into a full name
    func convertName() -> String {
        var newSting = ""
        
        newSting = String((self.first?.uppercased())!)
        newSting += self.dropFirst()
        
        return newSting
    }
}
