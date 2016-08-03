//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func redButton(sender: AnyObject) {
        simonSaysGame.guessRed()
        complete()
        print("Red has been tapped")
    }
    
    @IBAction func greenButton(sender: AnyObject) {
        simonSaysGame.guessGreen()
        complete()
        print("Green has been tapped")
    }
    
    @IBAction func yellowButton(sender: AnyObject) {
        simonSaysGame.guessYellow()
        complete()
        print("Yellow has been tapped")
    }
    
    @IBAction func blueButton(sender: AnyObject) {
        simonSaysGame.guessBlue()
        complete()
        print("Blue has been tapped")
    }
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.hidden = true
        
    }

}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(sender: UIButton) {
        UIView.transitionWithView(startGameButton, duration: 0.9, options: .TransitionFlipFromBottom , animations: {
            self.startGameButton.hidden = true
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
    
    func complete() {
        
        buttonsClicked = buttonsClicked + 1
        
        switch buttonsClicked {
        case 5:
            
            switch simonSaysGame.wonGame() {
            case true:
                winLabel.hidden = false
                winLabel.text = "You win!"
            default:
                winLabel.hidden = false
                winLabel.text = "You lost!"
            }
            
        case 6:
            
            buttonsClicked = 0
            winLabel.hidden = true
            winLabel.text = ""
            self.startGameButton.hidden = false
            
        default:
            
            winLabel.text = "Keep playing"
            
        }
        
        
        
    }
}
