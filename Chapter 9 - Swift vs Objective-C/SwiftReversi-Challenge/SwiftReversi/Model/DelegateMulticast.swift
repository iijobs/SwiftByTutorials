//
//  DelegateMulticast.swift
//  SwiftReversi
//
//  Created by Colin Eberhardt on 17/06/2014.
//  Copyright (c) 2014 razeware. All rights reserved.
//

import Foundation

// Provides a simple multicasting delegate implementation
class DelegateMulticast<T> {
  
  private var delegates = [T]()
  
  // add the given delegate as a receiver of notifications
  func addDelegate(delegate: T) {
    delegates.append(delegate)
  }
  
  // invokes the given function for each delegate
  func invokeDelegates(invocation: (T) -> ()) {
    for delegate in delegates {
      invocation(delegate)
    }
  }
}
