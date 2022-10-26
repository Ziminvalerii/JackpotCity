//
//  SwitchTableViewCell.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 18.10.2022.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var switchLabel: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(title: String, image:UIImage) {
        titleLabel.text = title
        cellImage.image = image
    }

}
