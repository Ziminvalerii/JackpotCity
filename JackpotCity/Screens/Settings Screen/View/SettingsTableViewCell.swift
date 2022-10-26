//
//  SettingsTableViewCell.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 18.10.2022.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var cellSlider: UISlider! {
        didSet {
            cellSlider.setMaximumTrackImage(UIImage(named: "maxThumbImage")!, for: .normal)
            cellSlider.setMinimumTrackImage(UIImage(named: "minThumbImage")!, for: .normal)
            cellSlider.setThumbImage(UIImage(named: "thumbImage")!, for: .normal)
        }
    }
    @IBOutlet weak var cellImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with image:UIImage) {
        cellImage.image = image
    }

}
