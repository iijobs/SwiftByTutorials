
//
//  LoginView.swift
//  CafeHunter
//
//  Created by Matt Galloway on 19/07/2014.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit

@IBDesignable
class LoginView: UIView {
  
  var readPermissions: [String] = []
  
  @IBInspectable var cornerRadius: CGFloat = 0.0 {
    didSet {
      layer.cornerRadius = cornerRadius
    }
  }
  @IBInspectable var borderWidth: CGFloat = 1.0 {
    didSet {
      layer.borderWidth = borderWidth
    }
  }
  @IBInspectable var borderColor: UIColor = UIColor.blackColor() {
    didSet {
      layer.borderColor = borderColor.CGColor
    }
  }
  
  var button: UIButton!
  
  init(readPermissions: [String]) {
    self.readPermissions = readPermissions
    super.init(frame: CGRectZero)
    self.initialize()
  }
  
  convenience override init(frame: CGRect) {
    self.init(readPermissions: [])
    self.frame = frame
  }
  
  required init(coder aDecoder: NSCoder!) {
    self.readPermissions = []
    super.init(coder: aDecoder)
    self.initialize()
  }
  
  func initialize() {
    self.backgroundColor = UIColor.blueColor()
    
    let button = UIButton.buttonWithType(.Custom) as UIButton
    button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
    self.addSubview(button)
    self.button = button
    self.updateButtonState()
    
    FBSession.openActiveSessionWithReadPermissions(nil, allowLoginUI: false) {
      (session: FBSession!, state: FBSessionState, error: NSError!) -> Void in
      self.updateButtonState()
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.button.frame = self.bounds
  }
  
  func updateButtonState() {
    var title: String
    if FBSession.activeSession().isOpen {
      title = "Log out"
    } else {
      title = "Log in"
    }
    button.setTitle(title, forState: .Normal)
  }
  
  func buttonPressed(sender: AnyObject) {
    if !FBSession.activeSession().isOpen {
      FBSession.openActiveSessionWithReadPermissions(self.readPermissions, allowLoginUI: true) {
        (session: FBSession!, state: FBSessionState, error: NSError!) -> Void in
        self.updateButtonState()
      }
    } else {
      FBSession.activeSession().closeAndClearTokenInformation()
    }
  }
  
}
