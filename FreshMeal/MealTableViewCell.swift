//
//  MealTableViewCell.swift
//  FreshMeal
//
//  Created by Satine Paronyan on 1/3/20.
//  Copyright © 2020 Satine Paronyan. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var prepImageView: UIImageView!
    @IBOutlet weak var totalImageView: UIImageView!
    @IBOutlet weak var caloriesImageView: UIImageView!
    @IBOutlet weak var prepLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
