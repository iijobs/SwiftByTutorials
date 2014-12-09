//
//  MoveDirection.swift
//  SwiftReversi
//
//  Created by Colin Eberhardt on 18/06/2014.
//  Copyright (c) 2014 razeware. All rights reserved.
//

import Foundation

enum MoveDirection {
  case North, South, East, West,
       NorthEast, NorthWest, SouthEast, SouthWest;
  
  func move(loc: BoardLocation) -> BoardLocation {
    switch self {
    case .North:
      return BoardLocation(row: loc.row-1, column: loc.column)
    case .South:
      return BoardLocation(row: loc.row+1, column: loc.column)
    case .East:
      return BoardLocation(row: loc.row, column: loc.column-1)
    case .West:
      return BoardLocation(row: loc.row, column: loc.column+1)
    case .NorthEast:
      return BoardLocation(row: loc.row-1, column: loc.column-1)
    case .NorthWest:
      return BoardLocation(row: loc.row-1, column: loc.column+1)
    case .SouthEast:
      return BoardLocation(row: loc.row+1, column: loc.column-1)
    case .SouthWest:
      return BoardLocation(row: loc.row+1, column: loc.column+1)
    }
  }
  
  static let directions: [MoveDirection] = [
    .North, .South, .East, .West,
    .NorthEast, .NorthWest, .SouthWest, .SouthEast
  ]
}