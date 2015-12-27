//
//  21Model.swift
//  10+19=21
//
//  Created by Jae Kang on 12/26/15.
//  Copyright © 2015 Jae Kang. All rights reserved.
//

import Foundation

class TwentyOneModel {
    
    var gameWon : Bool
    var players : [String]
    var winner : String?
    var currentPlayer : String
    var p1 : Player
    var p2 : Player
    var dealer : Dealer
    var p1Score : Int
    var p2Score : Int
    var dScore : Int
    var foldedL : [Bool]
    var lostL : [Bool]
    var scoreL : [Int]
//    var p1Folded : Bool
//    var p2Folded : Bool
//    var dFolded : Bool
    
    
    init() {
        gameWon = false
        players = ["Player1", "Player2", "Dealer"]
        winner = nil
        currentPlayer = players[0]
        print("currentPlayer : \(currentPlayer)")
        func generateRandomHandP() -> Int {
            return Int(arc4random_uniform(24))
        }
        
        func generateRandomHandD() -> Int {
            return Int(arc4random_uniform(12))
        }
        
        p1Score = generateRandomHandP()
        p2Score = generateRandomHandP()
        dScore = generateRandomHandD()
        p1 = Player(firstScore : p1Score)
        p2 = Player(firstScore : p2Score)
        dealer = Dealer(firstScore : dScore)
        foldedL = [false, false, false]
        lostL = [false, false, false]
        scoreL = [p1Score, p2Score, dScore]
    }
    
    
    func drawCard() -> Int {
        var newScore = 0
        if currentPlayer == "Player1" {
            newScore = p1.drawNewCard()
            p1Score = p1.score
            scoreL[0] = p1Score
            return newScore
        } else if currentPlayer == "Player2" {
            newScore = p2.drawNewCard()
            p2Score = p2.score
            scoreL[1] = p2Score
            return newScore
        } else if currentPlayer == "Dealer" {
            newScore = dealer.drawNewCard()
            dScore = dealer.score
            scoreL[2] = dScore
            return newScore
        } else {
            //this case should never occur
        return 0
        }
    }
    
    func nextPlayerTurn() {
        print("currentPlayer before : \(currentPlayer)")
        var index = 0
        while (currentPlayer != players[index]) {
            index += 1
        }
        print("index : \(index)")
        let next_index = (index + 1) % 3
        let n_next_index = (next_index + 1) % 3
        print("next_index : \(next_index)")
        print("n_next_index :  \(n_next_index)")
        if (foldedL[next_index] || lostL[next_index]) {
            currentPlayer = players[n_next_index]
        } else {
            currentPlayer = players[next_index]
        }
        print("currentPlayer after : \(currentPlayer)")
    }
    
    func checkIfHigherThan21() {
        if (currentPlayer == "Player1" && p1Score > 21) {
            lostL[0] = true
            print("Player1 loses!")
        } else if (currentPlayer == "Player2" && p2Score > 21) {
            lostL[1] = true
            print("Player2 loses!")
        } else if (currentPlayer == "Dealer" && dScore > 21) {
            lostL[2] = true
            print("Dealer loses!")
        }
    }
    
    func checkIfGameOver() -> Bool {
        var stillPlayingCount = 0
        for (var i = 0; i < 3; ++i) {
            if (!foldedL[i]) {
                stillPlayingCount += 1
            }
        }
        gameWon = (stillPlayingCount == 1)
        return gameWon
    }
    
    func foldButtonPressed() {
        if currentPlayer == "Player1" {
            foldedL[0] = true
            print("Player1 folds!")
        } else if currentPlayer == "Player2" {
            foldedL[1] = true
            print("Player2 folds!")
        } else if currentPlayer == "Dealer" {
            foldedL[2] = true
            print("Dealer folds!")
        }
        
    }
    
    func getWinner() -> (String, Int) {
        var remainingScores = [Int]()
        var winner : String = ""
        for (var i = 0; i < 3; ++i) {
            if scoreL[i] <= 21 {
                remainingScores.append(scoreL[i])
            }
        }
        let winScore = remainingScores.maxElement()!
        for (var i = 0; i < 3; ++i) {
            if (scoreL[i] == winScore) {
                winner = players[i]
            }
        }
        return (winner, winScore)
    }
    
}
