//
//  Player.swift
//  tictactoe
//
//  Created by Maite Mañana on 5/28/17.
//  Copyright © 2017 Maite Mañana. All rights reserved.
//

import UIKit
import CoreData

public class Player: NSManagedObject {
    @NSManaged var name: String?
    @NSManaged var age: Int16
    @NSManaged var email: String?
    
}
