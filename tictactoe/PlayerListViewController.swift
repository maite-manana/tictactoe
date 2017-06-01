//
//  PlayerListViewController.swift
//  tictactoe
//
//  Created by Maite Mañana on 5/28/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import UIKit
import CoreData

class PlayerListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var playerList: UITableView!
    var players: [Player] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var playerX: Player?
    var playerO: Player?
    var playerNum = 1

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerList.dataSource = self
        playerList.delegate  = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        playerX = nil
        playerO = nil
        playerNum = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let playersfetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        do {
            players = try context.fetch(playersfetch) as! [Player]
        } catch {
            fatalError("Error: \(error)")
        }
        
        playerList.reloadData()
        
        playerList.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! PlayerCell
        if (playerX == nil) {
            playerX = players[indexPath.row]
        } else {
            playerO = players[indexPath.row]
    
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.performSegue(withIdentifier: "goPlay", sender: nil)
            }
        }
        currentCell.playerLabel.isHidden = false
        currentCell.playerLabel.text = "Jugador \(playerNum)"
        playerNumber()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let guest = segue.destination as! GameViewController
        guest.playerX = playerX!
        guest.playerO = playerO!
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PlayerCell
        if cell == nil {
            cell = PlayerCell(style: .default, reuseIdentifier: "cell")
        }

        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        let player = players[indexPath.row]
        cell?.nameLabel.text = player.name
        cell?.playerLabel.isHidden = true
        
        return cell!
    }
    
    func playerNumber() {
        if playerNum == 1 {
            playerNum = 2
        } else {
            playerNum = 1
        }
    }
}
