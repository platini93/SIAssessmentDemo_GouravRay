//
//  SquadTableViewCell.swift
//  SIAssessmentDemo
//
//  Created by Gourav Ray on 5/24/23.
//

import UIKit

class SquadTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNameLbl: UILabel!
    @IBOutlet weak var playerRoleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
