//
//  ViewController.swift
//  lavieja
//
//  Created by Maite Mañana on 5/22/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import UIKit
import CoreData

class GameViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    static var emptyState = ""
    var boardGame = Array(repeating: Array(repeating: emptyState, count: 3), count: 3)
    var currentPlayer = "X"
    var winner: Player?
    var playerX: Player?
    var playerO: Player?
    
    
    @IBOutlet weak var cell1: UIButton!
    @IBOutlet weak var cell2: UIButton!
    @IBOutlet weak var cell3: UIButton!
    @IBOutlet weak var cell4: UIButton!
    @IBOutlet weak var cell5: UIButton!
    @IBOutlet weak var cell6: UIButton!
    @IBOutlet weak var cell7: UIButton!
    @IBOutlet weak var cell8: UIButton!
    @IBOutlet weak var cell9: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func play(_ row: Int, _ col: Int, _ cell: UIButton) {
        if (boardGame[row][col] == GameViewController.emptyState) {
            boardGame[row][col] = currentPlayer
            cell.setTitle(currentPlayer, for: .normal)
            didWin(row, col)
            switchCurrentPlayer()
        } else {
            MessageHandler.showMessage(title: "celda ya seleccionada!", body: "GIL", type: messageType.ERROR)
        }
    }
    @IBAction func select1(_ sender: UIButton) {
        play(0, 0, cell1)
    }

    @IBAction func select2(_ sender: UIButton) {
        play(0, 1, cell2)
    }
    
    @IBAction func select3(_ sender: UIButton) {
        play(0, 2, cell3)
    }
    
    @IBAction func select4(_ sender: UIButton) {
        play(1, 0, cell4)
    }

    @IBAction func select5(_ sender: UIButton) {
        play(1, 1, cell5)
    }
    
    @IBAction func select6(_ sender: UIButton) {
        play(1, 2, cell6)
    }
    
    
    @IBAction func select7(_ sender: UIButton) {
        play(2, 0, cell7)
    }
    
    @IBAction func select8(_ sender: UIButton) {
        play(2, 1, cell8)
    }
    
    
    @IBAction func select9(_ sender: UIButton) {
        play(2, 2, cell9)
    }
    
    
    func switchCurrentPlayer() {
        if currentPlayer == "X" {
            currentPlayer = "O"
        } else {
            currentPlayer = "X"
        }
    }
    
    func didWin(_ row: Int, _ column: Int) {
        if checkForWinner(row, column) {
            winner = currentPlayer == "X" ? playerX : playerO
            showWinnerMessage()
            closeGame()
        } else if checkForTie() {
            closeGame()
            MessageHandler.showMessage(title: "Que aburrido!", body: "Empataron", type: messageType.WARNING)
        }
    }
    
    func closeGame() {
        disableGame()
        saveGame()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.tabBarController?.selectedIndex = 2
        })
    }
    
    func saveGame() {
        let date = Date()
        let match = NSEntityDescription.insertNewObject(forEntityName: "Match", into: self.context) as! Match
        if (winner != nil) {
            match.winner = winner!
        }
        match.addToPlayers(playerX!)
        match.addToPlayers(playerO!)
        match.date = date as NSDate
        
        do {
            try context.save()
            tabBarController?.selectedIndex = 2
        } catch {
            MessageHandler.showMessage(title: "Error", body: "No se ha podido guardar el juego", type: messageType.ERROR)
        }
    }
    
    func checkForTie() -> Bool {
        var tie = true
        for i in 0...2 {
            for j in 0...2 {
                tie = tie && boardGame[i][j] != GameViewController.emptyState
            }
        }
        return tie
        
    }
    
    func checkForWinner(_ row: Int, _ column: Int) -> Bool {
        return horizontalMatch(row, column) || verticalMatch(row, column) || diagonalMatch(row, column) || offDiagonalMatch(row, column)
    }
    
    func horizontalMatch(_ row: Int, _ column: Int) -> Bool {
        return (boardGame[row][0] != GameViewController.emptyState) && (boardGame[row][0] == boardGame[row][1]) && (boardGame[row][1] == boardGame[row][2])    }
        
    func verticalMatch(_ row: Int, _ column: Int) -> Bool {
        return (boardGame[0][column] != GameViewController.emptyState) && (boardGame[0][column] == boardGame[1][column]) && (boardGame[1][column] == boardGame[2][column])
    }
    
    func diagonalMatch(_ row: Int, _ column: Int) -> Bool {
        return (boardGame[0][0] != GameViewController.emptyState) && (boardGame[0][0] == boardGame[1][1]) && (boardGame[1][1] == boardGame[2][2])
    }
        
    func offDiagonalMatch(_ row: Int, _ column: Int) -> Bool {
        return (boardGame[0][2] != GameViewController.emptyState) && (boardGame[0][2] == boardGame[1][1]) && (boardGame[1][1] == boardGame[2][0])
    }
        
        
    
    func showWinnerMessage() {
        let winner = currentPlayer == "X" ?  playerX!.name! : playerO!.name!
        MessageHandler.showMessage(title: "Iajuuuuuu!", body: "Felicitaciones, \(winner), ganaste!", type: messageType.SUCCESS)
    }
    
    func disableGame() {
        cell1.isEnabled = false
        cell2.isEnabled = false
        cell3.isEnabled = false
        cell4.isEnabled = false
        cell5.isEnabled = false
        cell6.isEnabled = false
        cell7.isEnabled = false
        cell8.isEnabled = false
        cell9.isEnabled = false
    }
}

