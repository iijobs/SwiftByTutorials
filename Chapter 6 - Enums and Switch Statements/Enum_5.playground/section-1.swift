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

import UIKit

// Inspired by https://github.com/lingoer/SwiftyJSON

import Foundation

enum JSONValue {
  
  case JSONObject([String:JSONValue])
  case JSONArray([JSONValue])
  case JSONString(String)
  case JSONNumber(NSNumber)
  case JSONBool(Bool)
  case JSONNull
  
  var object: [String:JSONValue]? {
    switch self {
    case .JSONObject(let value):
      return value
    default:
      return nil
      }
  }
  
  var array: [JSONValue]? {
    switch self {
    case .JSONArray(let value):
      return value
    default:
      return nil
      }
  }
  
  var string: String? {
    switch self {
    case .JSONString(let value):
      return value
    default:
      return nil
      }
  }
  
  var integer: Int? {
    switch self {
    case .JSONNumber(let value):
      return value.integerValue
    default:
      return nil
      }
  }
  
  var double: Double? {
    switch self {
    case .JSONNumber(let value):
      return value.doubleValue
    default:
      return nil
      }
  }
  
  var bool: Bool? {
    switch self {
    case .JSONBool(let value):
      return value
    case .JSONNumber(let value):
      return value.boolValue
    default:
      return nil
      }
  }
  
  subscript(i: Int) -> JSONValue? {
    get {
      switch self {
      case .JSONArray(let value):
        return value[i]
      default:
        return nil
      }
    }
  }
  
  subscript(key: String) -> JSONValue? {
    get {
      switch self {
      case .JSONObject(let value):
        return value[key]
      default:
        return nil
      }
    }
  }
  
  static func fromObject(object: AnyObject) -> JSONValue? {
    switch object {
    case let value as NSString:
      return JSONValue.JSONString(value)
    case let value as NSNumber:
      return JSONValue.JSONNumber(value)
    case let value as NSNull:
      return JSONValue.JSONNull
    case let value as NSDictionary:
      var jsonObject: [String:JSONValue] = [:]
      for (k: AnyObject, v: AnyObject) in value {
        if let k = k as? NSString {
          if let v = JSONValue.fromObject(v) {
            jsonObject[k] = v
          } else {
            return nil
          }
        }
      }
      return JSONValue.JSONObject(jsonObject)
    case let value as NSArray:
      var jsonArray: [JSONValue] = []
      for v in value {
        if let v = JSONValue.fromObject(v) {
          jsonArray.append(v)
        } else {
          return nil
        }
      }
      return JSONValue.JSONArray(jsonArray)
    default:
      return nil
    }
  }
  
}


let json = "{\"success\":true,\"data\":{\"numbers\":[1,2,3,4,5],\"animal\":\"dog\"}}"

if let jsonData = (json as NSString).dataUsingEncoding(NSUTF8StringEncoding) {
  let parsed: AnyObject? = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions(0), error: nil)
  
  // Actual JSON parsing section
  if let parsed = parsed as? [String:AnyObject] {
    if let success = parsed["success"] as? NSNumber {
      if success.boolValue == true {
        if let data = parsed["data"] as? NSDictionary {
          if let numbers = data["numbers"] as? NSArray {
            println(numbers)
          }
          if let animal = data["animal"] as? NSString {
            println(animal)
          }
        }
      }
    }
  }
  
}


if let jsonData = (json as NSString).dataUsingEncoding(NSUTF8StringEncoding) {
  if let parsed: AnyObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions(0), error: nil) {
    if let jsonParsed = JSONValue.fromObject(parsed) {
      
      // Actual JSON parsing section
      if jsonParsed["success"]?.bool == true {
        if let numbers = jsonParsed["data"]?["numbers"]?.array {
          println(numbers)
        }
        if let animal = jsonParsed["data"]?["animal"]?.string {
          println(animal)
        }
      }
      
    }
  }
}
