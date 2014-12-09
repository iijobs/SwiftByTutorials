//
//  ComputerOpponent.swift
//  SwiftReversi
//
//  Created by Colin Eberhardt on 09/06/2014.
//  Copyright (c) 2014 razeware. All rights reserved.
//

import Foundation

func delay(delay: Double, closure: ()->()) {
  let time = dispatch_time(
    DISPATCH_TIME_NOW,
    Int64(delay * Double(NSEC_PER_SEC))
  )
  dispatch_after(time, dispatch_get_main_queue(), closure)
}

class ComputerOpponent : ReversiBoardDelegate {
  private let board: ReversiBoard
  private let color: BoardCellState
  private let maxDepth: Int
  
  init(board: ReversiBoard, color: BoardCellState, maxDepth: Int) {
    self.board = board
    self.color = color
    self.maxDepth = maxDepth
    
    board.addDelegate(self)
  }
  
  func boardStateChanged() {
    if board.nextMove == color {
      delay(1.0) {
        self.makeNextMove()
      }
    }
  }

  private func makeNextMove() {
    var bestScore = Int.min
    var bestLocation: BoardLocation?
    
    for move in validMovesForBoard(board) {
      let score = self.scoreForBoard(board)
      if (score > bestScore) {
        bestScore = score
        bestLocation = move
      }
    }
    
    if bestScore > Int.min {
      board.makeMove(bestLocation!)
    }
  }
  
  private func scoreForBoard(board:ReversiBoard, depth: Int = 0) -> Int {
    
    if depth >= maxDepth {
      return color == BoardCellState.White ?
        board.whiteScore - board.blackScore :
        board.blackScore - board.whiteScore;
    }
    
    var minMax = Int.min
    
    for move in validMovesForBoard(board) {
      // clone the board and take the move
      let testBoard = ReversiBoard(board: board)
      testBoard.makeMove(move)
      
      // compute the score
      let score = scoreForBoard(testBoard, depth: depth+1)
      
      if depth % 2 == 0 {
        if score > minMax || minMax == Int.min {
          minMax = score
        }
      } else {
        if score < minMax || minMax == Int.min {
          minMax = score
        }
      }
    }
    
    return minMax
  }
  
  private func validMovesForBoard(board: ReversiBoard) -> [BoardLocation] {
    var moves = [BoardLocation]()
    board.cellVisitor {
      if board.isValidMove($0) {
        moves += [$0]
      }
    }
    return moves
  }
}

