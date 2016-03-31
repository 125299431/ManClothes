//
//  BuyTableViewCell.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/30.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class BuyTableViewCell: UITableViewCell {

    
    @IBOutlet weak var pinpaiLabel: UILabel!
    
    @IBOutlet weak var caizhiLabel: UILabel!
    
    @IBOutlet weak var styleLabel: UILabel!
    
    @IBOutlet weak var huohaoLabel: UILabel!
    
    @IBOutlet weak var colorLabel: UILabel!
    
    @IBOutlet weak var jijieLabel: UILabel!

    var sellModel:SellModel! {
        willSet(newValue) {
            self.setNeedsLayout()
        }
        
        didSet(oldValue) {
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.pinpaiLabel.text = "品牌名称：" + self.sellModel.brand
        self.caizhiLabel.text = "材质：" + self.sellModel.material
        self.styleLabel.text = "基础风格：" + self.sellModel.style
        self.huohaoLabel.text = "货号：" + String(self.sellModel.num_iid)
        self.colorLabel.text = "款式颜色：" + self.sellModel.color
        self.jijieLabel.text = "使用季节：" + self.sellModel.season
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
