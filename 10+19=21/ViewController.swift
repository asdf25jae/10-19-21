//
//  ViewController.swift
//  10+19=21
//
//  Created by Jae Kang on 12/26/15.
//  Copyright © 2015 Jae Kang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    var model : TwentyOneModel
    @IBOutlet weak var currentTurn: UITextField!
    @IBOutlet weak var p1Score: UITextField!
    @IBOutlet weak var p2Score: UITextField!
    @IBOutlet weak var dScore: UITextField!
    
    var model = TwentyOneModel()
    
    
    convenience init() {
        self.init()
    }
    
    func updateView() {
        //now check if higher than 21, and if so, player who just drew must have lost
        model.checkIfHigherThan21()
        let gameOver = model.checkIfGameOver()
        if (gameOver) {
            print("Game Over!")
            let (winner, winScore) = model.getWinner()
            print("...And the winner is \(winner) with a score of \(winScore)")
        } else {
            model.nextPlayerTurn()
            currentTurn.text = "\(model.currentPlayer)'s Turn"
            print("currentTurn.text = \(currentTurn.text)")
        }

        
    }
    
    func addToRespectiveScore(player : String, nScore : Int) {
        var finalScore : Int
        print("player in addtoScore : \(player)")
        if player == "Player1" {
            finalScore = Int(NSNumberFormatter().numberFromString(p1Score.text!)!) + nScore
            p1Score.text = "\(finalScore)"
            print(p1Score.text!)
        } else if player == "Player2" {
            finalScore = Int(NSNumberFormatter().numberFromString(p2Score.text!)!) + nScore
            p2Score.text = "\(finalScore)"
            print(p2Score.text!)
        } else if player == "Dealer"{
            finalScore = Int(NSNumberFormatter().numberFromString(dScore.text!)!) + nScore
            dScore.text = "\(finalScore)"
            print(dScore.text!)
    }
    }
    
    @IBAction func drawCard(sender: UIButton) {
        print("player : \(sender.currentTitle!)")
        let player = sender.currentTitle!
        print("\n\n\n")
        print("player : \(player)")
        print("model.gameWon : \(model.gameWon)")
        if (!model.gameWon) {
            if player == model.currentPlayer {
                let nScore = model.drawCard()
                print("nScore : \(nScore)")
                addToRespectiveScore(player, nScore: nScore)
                updateView()
            }
        }
    }

    
    @IBAction func foldButtonPressed() {
        if (!model.gameWon) {
            model.foldButtonPressed()
            updateView()
        }
    }
    
    
}

