//
//  ReversiBoard.swift
//  SwiftReversi
//
//  Created by Colin Eberhardt on 16/06/2014.
//  Copyright (c) 2014 razeware. All rights reserved.
//

import Foundation

class ReversiBoard: Board {
  private (set) var blackScore = 0, whiteScore = 0
  private (set) var nextMove = BoardCellState.White
  private let reversiBoardDelegates = DelegateMulticast<ReversiBoardDelegate>()
  private (set) var gameHasFinished = false
  
  override init()  {
    super.init()
  }
  
  init(board: ReversiBoard) {
    super.init(board: board)
    nextMove = board.nextMove
    blackScore = board.blackScore
    whiteScore = board.whiteScore
  }
  
  func setInitialState() {
    self.clearBoard()
    
    super[3,3] = .White
    super[4,4] = .White
    super[3,4] = .Black
    super[4,3] = .Black
    
    blackScore = 2
    whiteScore = 2
  }
  

  func makeMove(location: BoardLocation) {
    self[location] = nextMove
    
    for direction in MoveDirection.directions {
      flipOpponentsCounters(location, direction: direction, toState: nextMove)
    }
    

    switchTurns()
    gameHasFinished = checkIfGameHasFinished()
    
    whiteScore = countMatches { self[$0] == BoardCellState.White }
    blackScore = countMatches { self[$0] == BoardCellState.Black }
    
    reversiBoardDelegates.invokeDelegates { $0.boardStateChanged() }
  }
  
  private func checkIfGameHasFinished() -> Bool {
    return !canPlayerMakeMove(BoardCellState.Black) &&
      !canPlayerMakeMove(BoardCellState.White)
  }
  
  private func canPlayerMakeMove(toState:BoardCellState) -> Bool {
    return anyCellsMatchCondition { self.isValidMove($0, toState: toState) }
  }
  
  private func switchTurns() {
    var intendedNextMove = nextMove.invert()
    
    // only switch turns if the player can make a move
    if canPlayerMakeMove(intendedNextMove) {
      nextMove = intendedNextMove
    }
  }

  
  func isValidMove(location: BoardLocation) -> Bool {
    return isValidMove(location, toState: nextMove)
  }

  private func isValidMove(location: BoardLocation, toState: BoardCellState) -> Bool {
    // check the cell is empty
    if self[location] != BoardCellState.Empty {
      return false
    }
    
    // test whether the move surrounds any of the opponents pieces
    for direction in MoveDirection.directions {
      if moveSurroundsCounters(location, direction: direction, toState: toState) {
        return true
      }
    }
    return false
  }

  private func moveSurroundsCounters(location: BoardLocation, direction: MoveDirection, toState: BoardCellState) -> Bool {
    var index = 1
    
    // advance to next cell
    var currentLocation = direction.move(location)
    
    while isWithinBounds(currentLocation) {
      let currentState = self[currentLocation]
      if index == 1 {
        // the cell that is the immediate neighbour must be of the other colour
        if currentState != toState.invert() {
          return false
        }
      } else {
        // if we have reached a cell of the same colour, this is a valid move
        if currentState == toState {
          return true
        }
        
        // if we have reached an empty cell - fail
        if currentState == BoardCellState.Empty {
          return false
        }
      }
      
      index++
      
      // advance to next cell
      currentLocation = direction.move(currentLocation)
    }
    
    return false
  }
  
  private func flipOpponentsCounters(location: BoardLocation, direction: MoveDirection, toState: BoardCellState) {
    // is this a valid move?
    if !moveSurroundsCounters(location, direction: direction, toState: toState) {
      return
    }
    
    let opponentsState = toState.invert()
    var currentState = BoardCellState.Empty
    var currentLocation = location
    
    // flip counters until the edge of the board is reached or
    // a piece with the current state is reached
    do {
      currentLocation = direction.move(currentLocation)
      currentState = self[currentLocation]
      self[currentLocation] = toState
    } while (isWithinBounds(currentLocation) && currentState == opponentsState)
  }
  
  func addDelegate(delegate: ReversiBoardDelegate) {
    reversiBoardDelegates.addDelegate(delegate)
  }

}