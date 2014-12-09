//
//  BoardCellState.swift
//  SwiftReversi
//
//  Created by Colin Eberhardt on 07/06/2014.
//  Copyright (c) 2014 razeware. All rights reserved.
//

import Foundation

enum BoardCellState {
  case Empty, Black, White
  
  func invert() -> BoardCellState {
    if self == Black {
      return White
    } else if self == White {
      return Black
    }
    
    assert(self != Empty, "cannot invert the empty state")
    return Empty
  }
}
