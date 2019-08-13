//
//  ViewController.swift
//  PlayingCard
//
//  Created by Alejandro Barranco on 12/08/19.
//  Copyright © 2019 Alejandro Barranco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    
    @IBOutlet weak var playingCardView: PlayingCardView! {
        didSet {
            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipeGesture.direction = [.left, .right]
            playingCardView.addGestureRecognizer(swipeGesture)
            
            let pinch = UIPinchGestureRecognizer(target: playingCardView, action: #selector(PlayingCardView.adjustFaceCardScale(byHandlingGesrtureRecognizedBy:)))
            playingCardView.addGestureRecognizer(pinch)
        }
    }
    
    /// MARK: Target Action
    @objc func nextCard() {
        if let card = deck.draw() {
            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
        }
    }
    
    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            playingCardView.isFaceUp = !playingCardView.isFaceUp
        default:
            break
        }
    }
    
    /// MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
