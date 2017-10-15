//
//  TableViewCell.swift
//  TabbingTest
//
//  Created by Taalib Minhas on 30/09/2017.
//  Copyright © 2017 Taalib Minhas. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet var toDoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
