//
//  SearchUserTableViewCell.swift
//  GitHubUsers
//
//  Created by Mukul More on 06/06/18.
//  Copyright © 2018 mukulmore. All rights reserved.
//

import UIKit

/**
 Custom table view cell used to show the user's full name and their followers count
 */
class SearchUserTableViewCell: UITableViewCell {
    
    ///Used to display the user's login identifier
    @IBOutlet weak var loginLabel: UILabel!
    
    ///Used to display the count of the user's github score
    @IBOutlet weak var scoreLabel: UILabel!
    
}
