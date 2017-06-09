//
//  PhotoViewCell.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/25.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class PhotoViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var image_y: NSLayoutConstraint!
    var photoModel:PhotoModel? {
        
        willSet(newValue){
            self.setNeedsLayout()
        }
        
        didSet(oldValue) {
            
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        if <#condition#> {
//            <#code#>
//        }
        //头像
        self.userImageView.sd_setImage(with: URL(string: self.photoModel!.head_pic!))
        //昵称
        self.userName.text = self.photoModel?.nick_name
        //时间
        self.timeLabel.text = self.photoModel?.create_time
        
        //描述
        //判断是否有
        if self.photoModel?.comment?.characters.count != 0 {
            self.descriptionLabel.isHidden = false
            self.descriptionLabel.text = self.photoModel?.comment
            
        }else {
            self.descriptionLabel.isHidden = true
            self.image_y.constant = -20;

        }
        
        //照片
        self.photoImage.sd_setImage(with: URL(string: (self.photoModel?.image)! as String))
        
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
