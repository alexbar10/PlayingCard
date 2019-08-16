//
//  MultipleCardsViewController.swift
//  PlayingCard
//
//  Created by Alejandro Barranco on 15/08/19.
//  Copyright © 2019 Alejandro Barranco. All rights reserved.
//

import UIKit

class MultipleCardsViewController: UIViewController {

    private var deck = PlayingCardDeck()
    
    
    @IBOutlet var cardsViews: [PlayingCardView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var cards = [PlayingCard]()
        for _ in 1...((cardsViews.count+1)/2) {
            let card = deck.draw()!
            cards += [card, card]
        }
        for cardView in cardsViews {
            cardView.isFaceUp = true
            let card = cards.remove(at: cards.count.arc4random)
            cardView.rank = card.rank.order
            cardView.suit = card.suit.rawValue
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     10,000
     
     - ,500
     -1,500
     
      8,000
     
     ---
     
      3,000 banco
      1,200 casa
      1,000 lu
      1,000 ivoone
     
      6,200
    */

}
