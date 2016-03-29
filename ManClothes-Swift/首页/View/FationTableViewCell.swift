//
//  FationTableViewCell.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/28.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class FationTableViewCell: UITableViewCell {

    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
