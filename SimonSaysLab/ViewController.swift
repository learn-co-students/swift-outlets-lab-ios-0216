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
        
        
        
    }
    
    @IBAction func redButtonTapped(_ sender: AnyObject) {
        
        simonSaysGame.guessRed()
            print("red has been tapped")
    }
    @IBAction func greenButtonTapped(_ sender: AnyObject) {
        simonSaysGame.guessGreen()
        print("green has been tapped")

    }
    @IBAction func yellowButtonTapped(_ sender: AnyObject) {
        
        simonSaysGame.guessYellow()
        print("yellow has been tapped")

    }
    @IBAction func blueButtonTapped(_ sender: AnyObject) {
        simonSaysGame.guessBlue()
        print("blue has been tapped")

    }
    
    @IBAction func done(_ sender: AnyObject) {
        
        switch simonSaysGame.wonGame() {
        case true:
            winLabel.isHidden = false
            winLabel.text = "You won !"
        default:
            winLabel.isHidden = false
            winLabel.text = "You lost !"
        }
    }
    
    
    
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        displayTheColors()
        
            }
    
    
    private func displayTheColors() {
        self.view.isUserInteractionEnabled = false
        UIView.transition(with: displayColorView, duration: 1.5, options: .transitionCurlUp, animations: {
            self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
            self.displayColorView.alpha = 0.0
            self.displayColorView.alpha = 1.0
            }, completion: { _ in
                if !self.simonSaysGame.sequenceFinished() {
                    self.displayTheColors()
                } else {
                    self.view.isUserInteractionEnabled = true
                    print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
                    
                                    }
        })
    }
    
    
    
    
}
