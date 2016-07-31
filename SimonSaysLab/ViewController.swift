//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    
    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.hidden = true
    }
    
    @IBAction func greenTouched(sender: AnyObject) {
        print("green")
        simonSaysGame.guessGreen()
        if simonSaysGame.wonGame() {
            winLabel.hidden = false
        }
    }
    
    @IBAction func redTouched(sender: AnyObject) {
        print("red")

        simonSaysGame.guessRed()
        displayWinnerLabel()
    }
    
    @IBAction func yellowTouched(sender: AnyObject) {
        print("yellow")

        simonSaysGame.guessYellow()
        displayWinnerLabel()
    }
    
    @IBAction func blueTouched(sender: AnyObject) {
        print("blue")

        simonSaysGame.guessBlue()
        displayWinnerLabel()
    }
    
    func displayWinnerLabel(){
        if simonSaysGame.wonGame() {
            print("winner")
            winLabel.text = "WINNER"
            winLabel.hidden = false
        }
    }
    
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(sender: UIButton) {
        UIView.transitionWithView(startGameButton, duration: 0.9, options: .TransitionFlipFromBottom , animations: {
            self.startGameButton.hidden = true
            self.winLabel.text = "Playing..."
            self.winLabel.hidden = false
            }, completion: nil)
        
        displayTheColors()
    }
    
    private func displayTheColors() {
        self.view.userInteractionEnabled = false
        UIView.transitionWithView(displayColorView, duration: 1.5, options: .TransitionCurlUp, animations: {
            self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
            self.displayColorView.alpha = 0.0
            self.displayColorView.alpha = 1.0
            }, completion: { _ in
                if !self.simonSaysGame.sequenceFinished() {
                    self.displayTheColors()
                } else {
                    self.view.userInteractionEnabled = true
                    print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
                }
        })
    }
}
