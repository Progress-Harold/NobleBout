//
//  ProductionTests.swift
//  NobleBoutTests
//
//  Created by Lee Davis on 12/28/20.
//  Copyright © 2020 EightFoldGames. All rights reserved.
//

import XCTest
@testable import NobleBout
import SpriteKit
import UIKit

class GameViewControllerTests: XCTestCase {
    
    private var subjectUnderTest: GameViewControllerMock?
    private var viewController: ViewControllerDelegateMock?
    
    override func setUp() {
        super.setUp()
        
        viewController = ViewControllerDelegateMock()

        subjectUnderTest = GameViewControllerMock()
        subjectUnderTest?.delegate = viewController
    }
    
    override func tearDown() {
        super.tearDown()
        
        subjectUnderTest = nil
        viewController = nil
    }
    
    private func test_viewDidLoad() {
        subjectUnderTest?.viewDidLoad()
        
        XCTAssertEqual(viewController?.invokedViewDidLoad, true)
    }
    
    private func test_setup() {
        subjectUnderTest?.viewDidLoad()
        
        XCTAssertEqual(viewController?.invokedSetup, true)
    }
    
    private func test_presentScene() {
        subjectUnderTest?.viewDidLoad()
        
        XCTAssertEqual(viewController?.invokedSetup, true)
    }
}

// MARK: - ViewControllerDelegateMock

private final class ViewControllerDelegateMock: ViewControllerDelegate {
    
    var invokedViewDidLoad: Bool = false
    
    func viewDidLoad() {
        invokedViewDidLoad = true
    }
    
    var invokedSetup: Bool = false

    func setup() {
        invokedSetup = true
    }

    var invokedPresentScene: Bool = false

    func present() {
        invokedPresentScene = true
    }
}

// MARK: - GameViewControllerMock

private final class GameViewControllerMock: GameViewController {
    
    var invokedPresentedScene: Bool = false
    
    override func present(scene: SKScene) {
        super.present(scene: scene)
        invokedPresentedScene = true
    }
}
