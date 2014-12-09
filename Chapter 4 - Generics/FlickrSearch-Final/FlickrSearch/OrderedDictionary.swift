/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import Foundation

struct OrderedDictionary<KeyType: Hashable, ValueType> {
  
  typealias ArrayType = [KeyType]
  typealias DictionaryType = [KeyType: ValueType]
  
  var array = ArrayType()
  var dictionary = DictionaryType()
  
  var count: Int {
    return self.array.count
  }
  
  mutating func insert(value: ValueType, forKey key: KeyType, atIndex index: Int) -> ValueType? {
    var adjustedIndex = index
    
    let existingValue = self.dictionary[key]
    if existingValue != nil {
      let existingIndex = find(self.array, key)!
      if existingIndex < index {
        adjustedIndex--
      }
      self.array.removeAtIndex(existingIndex)
    }
    
    self.array.insert(key, atIndex:adjustedIndex)
    self.dictionary[key] = value
    
    return existingValue
  }
  
  mutating func removeAtIndex(index: Int) -> (KeyType, ValueType) {
    precondition(index < self.array.count, "Index out-of-bounds")
    let key = self.array.removeAtIndex(index)
    let value = self.dictionary.removeValueForKey(key)!
    return (key, value)
  }
  
  subscript(index: Int) -> (KeyType, ValueType) {
    get {
      precondition(index < self.array.count, "Index out-of-bounds")
      let key = self.array[index]
      let value = self.dictionary[key]!
      return (key, value)
    }
    set {
      precondition(index < self.array.count, "Index out-of-bounds")
      let (key, value) = newValue
      let originalKey = self.array[index]
      self.dictionary[originalKey] = nil
      self.array[index] = key
      self.dictionary[key] = value
    }
  }
  
  subscript(key: KeyType) -> ValueType? {
    get {
      return self.dictionary[key]
    }
    set {
      if let index = find(self.array, key) {
      } else {
        self.array.append(key)
      }
      self.dictionary[key] = newValue
    }
  }
  
}

extension OrderedDictionary: SequenceType {
  
  typealias GeneratorType = GeneratorOf<(KeyType, ValueType)>
  
  func generate() -> GeneratorOf<(KeyType, ValueType)> {
    var index = 0
    return GeneratorOf {
      if index < self.array.count {
        let key = self.array[index++]
        return (key, self.dictionary[key]!)
      } else {
        return nil
      }
    }
  }
  
}
