//
//  ViewController.swift
//  Apple Pie
//
//  Created by Alona Trekhlib on 2/14/19.
//  Copyright © 2019 Alona Trekhlib. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["apple", "orange", "cherry", "cranberry", "grape", "grapefruit", "pear", "pomegranate", "raspberry", "strawberry", "watermalon", "beet", "papper", "radish", "onion", "potato", "rhubarb", "tomato", "apricot", "lemon", "lime", "papaya", "peach", "squash", "avocado"]
    
    let incorrectMovesAllowed = 5
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }

    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet var letterButton: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        newRound()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    var currentGame: Game!
    
    func newRound() {
        let newWord = listOfWords.randomElement()!
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
        enableLetterButtons(true)
        updateUI()
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButton {
            button.isEnabled = enable
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
}


