//
//  ViewController.swift
//  ReflexTest
//
//  Created by Jonathan Lowe on 2/12/18.
//  Copyright © 2018 Jonathan Lowe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var circleDisplay: UIImageView!
    @IBOutlet weak var trialButton: UIButton!
    @IBOutlet weak var resultsLabel: UILabel!
    
    var blueCircle: UIImage!
    var greenCircle: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the original state of the application.
        trialButton.setTitle("Hold to start", for: [])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

