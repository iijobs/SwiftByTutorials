//
//  SwiftReversiTests.swift
//  SwiftReversiTests
//
//  Created by Colin Eberhardt on 07/06/2014.
//  Copyright (c) 2014 razeware. All rights reserved.
//

import XCTest

class SwiftReversiTests: XCTestCase {
    
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func test_subscript_setWithValidCoords_cellStateIsChanged() {
    let board = Board()
    
    // set the state of one of the cells
    board[4, 5] = BoardCellState.White
    
    // verify
    let retrievedState = board[4, 5];
    XCTAssertEqual(BoardCellState.White, retrievedState, "The cell should have been white!");
  }

}
