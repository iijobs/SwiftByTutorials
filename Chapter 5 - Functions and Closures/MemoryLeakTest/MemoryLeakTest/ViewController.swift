//
//  ViewController.swift
//  MemoryLeakTest
//
//  Created by Colin Eberhardt on 10/08/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let person = Person(name: "bob")
    person.performAction()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

