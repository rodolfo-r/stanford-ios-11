//
//  ViewController.swift
//  Concentration
//
//  Created by Rodolfo Rodriguez on 11/4/18.
//  Copyright © 2018 Rodolfo Rodriguez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    lazy private(set) var game = Concentration(numberOfCardPairs: cardButtons.count / 2)
    
    lazy private var emojis: [String] = newEmojis()
    private var cardEmoji = [Int: String]()
    
    private var flipCount = 0
    
    @IBAction func touchedCard(_ sender: UIButton) {
        let index = cardButtons.firstIndex(of: sender)!
        game.chooseCard(at: index)
        updateCardViews()
    }
    
    private func updateCardViews() {
        for index in game.cards.indices {
            let card = cardButtons[index]
            if game.cards[index].isFaceUp {
                card.backgroundColor = UIColor.white
                card.setTitle(emoji(for: game.cards[index]), for: UIControl.State.normal)
            } else {
                card.backgroundColor = game.cards[index].isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : UIColor.orange
                card.setTitle("", for: UIControl.State.normal)
            }
        }
        flipCount += 1
        flipCountLabel.text = "Flips: \(flipCount)"
        scoreLabel.text = String(game.score)
    }
    
    
    private func emoji(for card: Card) -> String {
        if cardEmoji[card.identifier] == nil, emojis.count > 0 {
            let randIndex = Int(arc4random_uniform(UInt32(emojis.count)))
            cardEmoji[card.identifier] = emojis.remove(at: randIndex)
        }
        return cardEmoji[card.identifier] ?? "?"
    }
    
    @IBAction private func newGame(_ sender: Any) {
        game = Concentration(numberOfCardPairs: cardButtons.count / 2)
        flipCount = 0
        emojis = newEmojis()
        updateCardViews()
    }
    
    func newEmojis() -> [String] {
        let themes = ["halloween": ["👻", "🎃", "👹", "🍬", "🍭"],
                      "christmas": ["🎅", "🎁", "🎄", "☃️", "❄️"],
                      "animals": ["🐧", "🐔", "🐵", "🐮", "🐼"]
        ]
        let themeNames = Array(themes.keys)
        let themeName = themeNames[Int.random(in: 0..<themeNames.count)]
        
        return themes[themeName] ?? []
    }
}

