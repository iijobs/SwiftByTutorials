//
//  BoardDelegate.swift
//  SwiftReversi
//
//  Created by Colin Eberhardt on 17/06/2014.
//  Copyright (c) 2014 razeware. All rights reserved.
//

import Foundation

protocol BoardDelegate {
  func cellStateChanged(location: BoardLocation)
}