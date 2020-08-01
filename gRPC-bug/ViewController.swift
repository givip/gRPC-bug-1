//
//  ViewController.swift
//  gRPC-bug
//
//  Created by Givi Pataridze on 01.08.2020.
//  Copyright © 2020 GP-Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let greeter = Greeter()

    override func viewDidLoad() {
        super.viewDidLoad()

        greeter.reproduceBug()
    }
}

