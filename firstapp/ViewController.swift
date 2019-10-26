//
//  ViewController.swift
//  firstapp
//
//  Created by Hosam Elnabawy on 10/25/19.
//  Copyright © 2019 Hosam Elnabawy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var sliderValue: Int = 0;
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var totalScore: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    var roundScore: Int = 0;
    var total: Int = 0;
    var targetValue = Int(arc4random_uniform(100)) + 1
    var currentRound: Int = 1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiateValue()
        updateLabels()
        
    let thumbImageNormal =  UIImage(named: "SliderThumb-Normal")
        let thumbImageHighlited = UIImage(named: "SliderThumb-Highlighted")
        
        slider.setThumbImage(thumbImageNormal, for: .normal)
        slider.setThumbImage(thumbImageHighlited, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage?.resizableImage(withCapInsets: insets)
        
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage =  UIImage(named: "SliderTrackRight")
        let trackRightResizable = trackRightImage?.resizableImage(withCapInsets: insets)
        
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        print("targetValue \(targetLabel.text)")
    }
    
    public func startNewRound() {
        targetValue = Int(arc4random_uniform(100)) + 1
        sliderValue = 50
        slider.value = Float(sliderValue)
        updateLabels()
    }
    func calculateScore() {
        let differenece = abs(targetValue - lroundf(slider.value))
        var title : String = "Hey"
        roundScore = 100 - differenece
        
        if (roundScore == 100) {
            title = "Awesome"
            roundScore += 100
        } else if (roundScore < 100 && roundScore >= 95) {
            title = "You nearly Got It"
            roundScore += 50
        }
        
        total += roundScore
        
        showAlert(message: "This is your Move \(sliderValue) \n The Target Value is \(targetValue) \n Your Score is \(roundScore)" , title: title)
    }

    func initiateValue() {
        currentRound = 1
        total = 0
        totalScore.text = "0"
        roundLabel.text = String(currentRound)
        sliderValue = lroundf(slider.value);
    }
    
    public func onCloseAlert(_:UIAlertAction? = nil) {
        print("Alert Has Been Closed\n Do Other stuff: \(sliderValue), \(total)")
        
        startNewRound()
        
        displayScore()
    }
    
    @IBAction func onClick() {
        
        calculateScore()
    }
    
    func displayScore() {
        
        totalScore.text = String(total)
        currentRound += 1
        roundLabel.text = String(currentRound)
        
        print("Get Invoked + \(totalScore.text)")
    }
    
    private func showAlert(message: String, title: String? = "Hey") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
        let awesomeAction = UIAlertAction(title: "Awesome", style: .default, handler: self.onCloseAlert)
        let cancelAction  = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
        alert.addAction(awesomeAction)
        alert.addAction(cancelAction)
    
        present(alert, animated: true)

    }
    
    @IBAction func onDrag(_ slider: UISlider) {
        print("Drag Value \(slider.value)")
        sliderValue = lroundf(slider.value);
    }
    
    @IBAction func startOver() {
        startNewRound()
        initiateValue()
    }
    
}

