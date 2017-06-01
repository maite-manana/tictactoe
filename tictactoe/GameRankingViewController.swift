//
//  GameRankingViewController.swift
//  tictactoe
//
//  Created by Maite Mañana on 5/31/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class GameRankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var rankingList: UITableView!
    var matches: [Match] = []
    var players: [Player] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rankingList.dataSource = self
        rankingList.delegate  = self

        let nib = UINib(nibName: "RankingCell", bundle: nil)
        rankingList.register(nib, forCellReuseIdentifier: "cell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let matchesfetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Match")
        matchesfetch.fetchLimit = 5
        matchesfetch.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]

        do {
            matches = try context.fetch(matchesfetch) as! [Match]
        } catch {
            fatalError("Error: \(error)")
        }
        
        rankingList.reloadData()
        
        rankingList.tableFooterView = UIView(frame: CGRect.zero)

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rankingList.dequeueReusableCell(withIdentifier: "cell") as! RankingCell

        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let match = matches[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        players = match.players?.allObjects as! [Player]
        cell.player1Label.text = players.first?.name
        cell.player2Label.text = players.last?.name
        
        if match.winner == players.first {
            setRankingCell(cell, (players.first?.name)!, (players.last?.name)!, false)
        } else if match.winner == players.last {
            setRankingCell(cell, (players.last?.name)!, (players.first?.name)!, false)
        } else {
            setRankingCell(cell, (players.first?.name)!, (players.last?.name)!, true)
        }
        cell.gameDateLabel.text = dateFormatter.string(from: match.date! as Date)
        
        return cell
    }
    
    func setRankingCell(_ cell: RankingCell, _ winnerName: String, _ loserName: String, _ tie: Bool) {
        cell.player1Label.text = winnerName
        cell.player2Label.text = loserName
        if tie {
            cell.player1Label.textColor = UIColor.orange
            cell.player2Label.textColor = UIColor.orange

        } else {
            cell.player1Label.textColor = UIColor.green
            cell.player2Label.textColor = UIColor.red
        }
    }
    
    
    
}
