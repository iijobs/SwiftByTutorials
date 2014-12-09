//
//  ReversiBoard.swift
//  SwiftReversi
//
//  Created by Colin Eberhardt on 07/06/2014.
//  Copyright (c) 2014 razeware. All rights reserved.
//

import Foundation


class Board {
  private var cells: [BoardCellState]
  let boardSize = 8
  private let boardDelegates = DelegateMulticast<BoardDelegate>()
  
  init () {
    cells = Array(count: boardSize * boardSize, repeatedValue: BoardCellState.Empty)
  }
  
  init(board: Board) {
    cells = board.cells;
  }
  
  subscript(row: Int, column: Int) -> BoardCellState {
    get {
      return self[BoardLocation(row: row, column: column)]
    }
    set {
      self[BoardLocation(row: row, column: column)] = newValue
    }
  }
  
  subscript(location: BoardLocation) -> BoardCellState {
    get {
      assert(isWithinBounds(location), "row or column index out of bounds")
      return cells[location.row * boardSize + location.column]
    }
    set {
      assert(isWithinBounds(location), "row or column index out of bounds")
      cells[location.row * boardSize + location.column] = newValue
      boardDelegates.invokeDelegates { $0.cellStateChanged(location) }
    }
  }
  
  func isWithinBounds(location: BoardLocation) -> Bool {
    return location.row >= 0 && location.row < boardSize &&
      location.column >= 0 && location.column < boardSize
  }
  
  func clearBoard() {
    cellVisitor { self[$0] = BoardCellState.Empty }
  }
  
  // a visitor, where the supplied closure is applied to each cell
  func cellVisitor(fn: (BoardLocation) ->()) {
    for column in 0..<boardSize {
      for row in 0..<boardSize {
        let location = BoardLocation(row: row, column: column)
        fn(location)
      }
    }
  }
  
  func addDelegate(delegate: BoardDelegate) {
    boardDelegates.addDelegate(delegate)
  }
  
  func countMatches(fn: (BoardLocation) -> Bool) -> Int {
    var count = 0
    cellVisitor { if fn($0) { count++ } }
    return count
  }
  
  func anyCellsMatchCondition(fn: (BoardLocation) -> Bool) -> Bool {
    for column in 0..<boardSize {
      for row in 0..<boardSize {
        if fn(BoardLocation(row: row, column: column)) {
          return true
        }
      }
    }
    return false
  }
}