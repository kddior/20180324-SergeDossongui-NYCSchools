//
//  SchoolTableViewCell.swift
//  20180324-SergeDossongui-NYCSchools
//
//  Created by serge kone Dossongui on 3/24/18.
//  Copyright © 2018 serge kone Dossongui. All rights reserved.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {

    @IBOutlet weak var SchoolNameLabel: UILabel!
 
    @IBOutlet weak var SchoolPhoneNumberLabel: UILabel!
    
    @IBOutlet weak var SchoolAddressLabel: UILabel!
    var School : School? {
        didSet {
           SchoolNameLabel.text = School?.school_name
           SchoolPhoneNumberLabel.text = School?.phoneNumber
            SchoolAddressLabel.text = School?.address
         
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        SchoolNameLabel.preferredMaxLayoutWidth = SchoolNameLabel.frame.size.width
    }

    override func layoutSubviews(){
        super.layoutSubviews()
        SchoolNameLabel.preferredMaxLayoutWidth = SchoolNameLabel.frame.size.width
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
