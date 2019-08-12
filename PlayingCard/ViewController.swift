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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for _ in 0...10 {
            if let card = deck.draw() {
                print("Card: \(card)")
            }
        }
    }
}
