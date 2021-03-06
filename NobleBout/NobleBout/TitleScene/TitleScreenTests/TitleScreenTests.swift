//
//  TitleScreenTests.swift
//  NobleBoutTests
//
//  Created by Lee Davis on 12/29/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import XCTest
@testable import NobleBout
import SpriteKit

class TitleScreenTests: XCTestCase {
    private var subjectUnderTest: TitleSceneController?
    
    override func setUp() {
        subjectUnderTest = TitleSceneController(fileNamed: titleScreenStr)
    }
    
    override func tearDown() {
        super.tearDown()
        
        subjectUnderTest = nil
    }
    
    private func test_assistentDirector() {
        subjectUnderTest?.sceneDidLoad()
        
        XCTAssertNotNil(subjectUnderTest?.assistantDirector)
    }
    
    private func test_set() {
        subjectUnderTest?.sceneDidLoad()
        let assistantDirector = subjectUnderTest?.assistantDirector as? TitleAssistantDirector
        
        XCTAssertNotNil(assistantDirector?.titleSet)
    }
    
    private func test_emitter() {
        subjectUnderTest?.sceneDidLoad()
        let assistantDirector = subjectUnderTest?.assistantDirector as? TitleAssistantDirector

        XCTAssertNotNil(assistantDirector?.titleSet?.titleEmmiter)
    }
}


