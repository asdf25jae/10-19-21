//
//  Dealer.swift
//  10+19=21
//
//  Created by Jae Kang on 12/26/15.
//  Copyright © 2015 Jae Kang. All rights reserved.
//

import Foundation

class Dealer {
    
    var score : Int
    var hiddenCard : Int
    
    init (firstScore : Int) {
        score = firstScore
        hiddenCard = Int(arc4random_uniform(12))
    }
    
    func drawNewCard() -> Int {
        score += Int(arc4random_uniform(12))
        return score
    }
}