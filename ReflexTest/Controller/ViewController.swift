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
    var trialData: TimeTrial!
    var activeTrial = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the original state of the application.
        trialData = TimeTrial()
        trialButton.setTitle("Hold to start", for: [])
        blueCircle = UIImage().circle(diameter: 80, color: UIColor.blue)
        greenCircle = UIImage().circle(diameter: 80, color: UIColor.green)
        circleDisplay.image = blueCircle
        
        // Add the gestures
        let beginTrialGesture = UILongPressGestureRecognizer(target: self, action: #selector(beginTrial(gestureRecognizer:)))
        beginTrialGesture.minimumPressDuration = 1
        trialButton.addGestureRecognizer(beginTrialGesture)
        
        let endTrialGesture = UITapGestureRecognizer(target: self, action: #selector(endTrial(gestureRecognizer:)))
        circleDisplay.addGestureRecognizer(endTrialGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Begin the trial by starting a timer that will update the UI.
    @objc func beginTrial(gestureRecognizer: UILongPressGestureRecognizer) {
        if (!self.activeTrial && gestureRecognizer.state == .began) {
            // Schedule the timer for 3 to 7 seconds in the future.
            let delay = arc4random_uniform(4) + 3
            Timer.scheduledTimer(withTimeInterval: TimeInterval(delay), repeats: false, block: { _ in
                // Begin the time trial by updating the circle, enabling interation with it, and beginning the timer.
                self.activeTrial = self.trialData.beginTimer()
                if (self.activeTrial) {
                    self.circleDisplay.image = self.greenCircle
                    self.resultsLabel.text = "Tap the green circle."
                    self.circleDisplay.isUserInteractionEnabled = self.activeTrial
                }
            })
        }
    }
    
    // End the trial and display the results or ask to start another one.
    @objc func endTrial(gestureRecognizer: UITapGestureRecognizer) {
        // Verify if we really need to stop the timer.
        if (self.activeTrial && self.circleDisplay.image == self.greenCircle) {
            // Stop and reset the form.
            self.trialData.stopTimer()
            self.activeTrial = false
            self.circleDisplay.image = self.blueCircle
            self.circleDisplay.isUserInteractionEnabled = self.activeTrial
            
            // If the trial is completed, display it. Otherwise prompt to retry trial.
            if (self.trialData.countCompletedTrials() < 5) {
                self.resultsLabel.text = "Please repeat the trial by holding the button again."
            } else {
                self.resultsLabel.text = "Your trial results are in: \r\n\(self.trialData.returnResultsAsJSON())"
            }
        }
    }

}

