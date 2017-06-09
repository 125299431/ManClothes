//
//  IssuseCell.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/30.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class IssuseCell: UICollectionViewCell {

    var imgView:UIImageView!
    var titleLabel:UILabel!
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self._initView()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self._initView()
    }
    
    func _initView() {
        self.imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.width))
        self.imgView.image = UIImage(named: "plaseholder.png")
        self.imgView.layer.cornerRadius = 30
        self.imgView.layer.masksToBounds = true
        self.contentView.addSubview(self.imgView)
        
        self.titleLabel = UILabel(frame: CGRect(x: 0, y: self.imgView.bottom + 5, width: self.imgView.width, height: 30))
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.systemFont(ofSize: 12)
        self.titleLabel.numberOfLines = 2
        self.contentView.addSubview(self.titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var issuseModel:IssuseModel! {
        willSet(newValue) {
            self.setNeedsLayout()
        }
        
        didSet(oldValue) {
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imgView.sd_setImage(with: URL(string: self.issuseModel.img!))
        self.titleLabel.text = self.issuseModel.title
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
