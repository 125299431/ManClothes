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
    
    var homeModel:HomeModel? {
        
        willSet(newValue){
            self.setNeedsLayout()
        }
        
        didSet(oldValue) {
            
        }
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //图片
        self.pictureView.sd_setImageWithURL(NSURL(string: (self.homeModel?.pic_url)!))
        //title
        self.descriptionLabel.text = self.homeModel?.title
        //类型
        self.typeLabel.text = self.homeModel?.cloth_description
        //价格
        self.priceLabel.text = "¥" + (self.homeModel?.coupon_price)!
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
