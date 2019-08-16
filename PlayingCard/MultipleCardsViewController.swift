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
    
    lazy var animator = UIDynamicAnimator(referenceView: view)
    
    lazy var cardBehavior = CardBehavior(in: animator)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var cards = [PlayingCard]()
        for _ in 1...((cardsViews.count+1)/2) {
            let card = deck.draw()!
            cards += [card, card]
        }
        for cardView in cardsViews {
            cardView.isFaceUp = false
            let card = cards.remove(at: cards.count.arc4random)
            cardView.rank = card.rank.order
            cardView.suit = card.suit.rawValue
            cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCard(_:))))
            cardBehavior.addItem(cardView)
        }
    }
    
    private var faceUpCardViews: [PlayingCardView] {
        return cardsViews.filter { $0.isFaceUp && !$0.isHidden && $0.transform != CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0) && $0.alpha == 1}
    }
    
    private var faceUpCardViewsMatch: Bool {
        return faceUpCardViews.count == 2 &&
            faceUpCardViews[0].rank == faceUpCardViews[1].rank &&
            faceUpCardViews[0].suit == faceUpCardViews[1].suit
    }
    
    var lastChosenCardView: PlayingCardView?
    
    @objc func flipCard(_ gesture: UITapGestureRecognizer) {
        switch gesture.state {
        case .ended:
            if let cardview = gesture.view as? PlayingCardView, faceUpCardViews.count < 2 {
                lastChosenCardView = cardview
                cardBehavior.removeItem(cardview)
                UIView.transition(with: cardview,
                                  duration: 0.5,
                                  options: [.transitionFlipFromLeft],
                                  animations: {
                                    cardview.isFaceUp = !cardview.isFaceUp
                },
                                  completion: { finished in
                                    let cardsToAnimate = self.faceUpCardViews
                                    if self.faceUpCardViewsMatch {
                                        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.6,
                                                                                       delay: 0,
                                                                                       options: [],
                                                                                       animations: {
                                                                                        cardsToAnimate.forEach {
                                                                                            $0.transform = CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0)
                                                                                        }
                                        },
                                                                                       completion: { position in
                                                                                        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.75,
                                                                                                                                       delay: 0,
                                                                                                                                       options: [],
                                                                                                                                       animations: {
                                                                                                                                        cardsToAnimate.forEach {
                                                                                                                                            $0.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                                                                                                                                            $0.alpha = 0
                                                                                                                                        }
                                                                                        }, completion: { position in
                                                                                            cardsToAnimate.forEach {
                                                                                                $0.isHidden = true
                                                                                                $0.alpha = 1
                                                                                                $0.transform = CGAffineTransform.identity
                                                                                            }
                                                                                        })
                                        })
                                    } else if cardsToAnimate.count == 2 {
                                        if self.lastChosenCardView == cardview {
                                            cardsToAnimate.forEach { playingCard in
                                                UIView.transition(with: playingCard,
                                                                  duration: 0.5,
                                                                  options: [.transitionFlipFromLeft],
                                                                  animations: {
                                                                    playingCard.isFaceUp = false
                                                }, completion: { finished in
                                                    self.cardBehavior.addItem(playingCard)
                                                }
                                                )
                                            }
                                        }
                                    } else {
                                        if !cardview.isFaceUp {
                                            self.cardBehavior.addItem(cardview)
                                        }
                                    }
                }
                )
            }
        default:
            break
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CGFloat {
    var arc4random: CGFloat {
        return self * (CGFloat(arc4random_uniform(UInt32.max))/CGFloat(UInt32.max))
    }
}
