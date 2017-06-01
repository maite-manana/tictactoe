//
//  Match.swift
//  tictactoe
//
//  Created by Maite Mañana on 5/28/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import UIKit
import CoreData

public class Match: NSManagedObject {
    @NSManaged var date: Date?
    
    @NSManaged func addWinner(winner: Player)
    @NSManaged func addPlayers(player: Player)

}
