//
//  ShopCollectionViewCell.swift
//  JackpotCity
//
//  Created by Anastasia Koldunova on 17.10.2022.
//

import UIKit

class ShopCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var coinStack: UIStackView!
    @IBOutlet weak var activeLabel: UILabel!
    
    func configure(playerImage: UIImage, price: String) {
        self.playerImage.image = playerImage
        priceLabel.text = price
    }
}
