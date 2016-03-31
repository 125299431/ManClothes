//
//  BuyViewController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/30.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class BuyViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView:UITableView!
//    var sizeView:UIView!//推荐框
    var itemID:NSNumber!
    
    var sellModel:SellModel?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self._initView()
        self._loadData()
    }
    
    func _initView() {
        self.tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        self.view.addSubview(self.tableView)
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        
        //返回按钮
        let backBtn = UIButton(type: .Custom)
        backBtn.backgroundColor = UIColor.blackColor()
        backBtn.layer.cornerRadius = 16
        backBtn.layer.masksToBounds = true
        backBtn.alpha = 0.6
        backBtn.frame = CGRect(x: 30, y: 40, width: 32, height: 32)
        backBtn.setImage(UIImage(named: "backButton.png"), forState: .Normal)
        backBtn.addTarget(self, action: #selector(BuyViewController.btnClick(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(backBtn)
        
        //分享按钮
        let shareBtn = UIButton(type: .Custom)
        shareBtn.backgroundColor = UIColor.blackColor()
        shareBtn.layer.cornerRadius = 16
        shareBtn.layer.masksToBounds = true
        shareBtn.alpha = 0.6
        shareBtn.frame = CGRect(x: kScreenWidth - 30 - 32, y: 40, width: 32, height: 32)
        shareBtn.setImage(UIImage(named: "shareButton.png"), forState: .Normal)
        shareBtn.addTarget(self, action: #selector(BuyViewController.userLogin), forControlEvents: .TouchUpInside)
        self.view.addSubview(shareBtn)
        
        //工具栏
        let tabBarView = UIView(frame: CGRect(x: 0, y: kScreenHeight - 50, width: kScreenWidth, height: 50))
        tabBarView.layer.borderWidth = 0.5
        tabBarView.layer.borderColor = UIColor.blackColor().CGColor
        tabBarView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(tabBarView)
        
        //收藏
        let collectionBtn = UIButton(type: .Custom)
        collectionBtn.setImage(UIImage(named: "uncollect.png"), forState: .Normal)
        collectionBtn.setImage(UIImage(named: "collected.png"), forState: .Selected)
        collectionBtn.addTarget(self, action: #selector(BuyViewController.collectionClick(_:)), forControlEvents: .TouchUpInside)
        collectionBtn.frame = CGRect(x: 20, y: 10, width: 32, height: 32)
        tabBarView.addSubview(collectionBtn)
        
        //天猫购买
        let buyBtn = UIButton(type: .Custom)
        buyBtn.backgroundColor = UIColor.redColor()
        buyBtn.setTitle("天猫购买", forState: .Normal)
        buyBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        buyBtn.addTarget(self, action: #selector(BuyViewController.tianmaoClick), forControlEvents: .TouchUpInside)
        buyBtn.frame = CGRect(x: kScreenWidth - 150, y: 0, width: 100, height: tabBarView.height)
        tabBarView.addSubview(buyBtn)
    }
    
    
    

    
    func btnClick(btn:UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func userLogin() {
        
    }
    
    func collectionClick(btn:UIButton) {
        btn.selected = !btn.selected
        if btn.selected {
            //收藏
            let collectionCtrl = UIAlertController(title: nil, message: "收藏成功", preferredStyle: .Alert)
            let enterAction = UIAlertAction(title: "确定", style: .Default, handler: { (alterCtrl) in
                
            })
            collectionCtrl.addAction(enterAction)
            
            self.presentViewController(collectionCtrl, animated: true, completion: nil)
            
        }else {
            //取消收藏
            let unCollectionCtrl = UIAlertController(title: nil, message: "取消收藏", preferredStyle: .Alert)
            let enterCtrl = UIAlertAction(title: "确定", style: .Default, handler: { (alterCtrl) in
                
            })
            
            unCollectionCtrl.addAction(enterCtrl)
            
            self.presentViewController(unCollectionCtrl, animated: true, completion: nil)
        }
    }
    
    func tianmaoClick() {
        
    }
    
    func _loadData() {
        let params = NSMutableDictionary()
        params.setObject("23", forKey: "age")
        params.setObject("175", forKey: "height")
        params.setObject(self.itemID, forKey: "item_id")
        params.setObject("15243", forKey: "member_id")
        params.setObject("member", forKey: "member_type")
        params.setObject("90267", forKey: "random_key")
        params.setObject("3", forKey: "skin_type")
        params.setObject("1", forKey: "style")
        params.setObject("76", forKey: "weight")
        
        DataSerive.requireDataWithURL(items, params: params, method: "GET", successBlock: { (operation, resust) in
            let jsonData = resust["data"] as! NSDictionary
            
            self.sellModel = SellModel()
            self.sellModel = self.sellModel?.initContentWithDic(jsonData) as? SellModel
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
            }) { (operation, error) in
                print("卖场信息出错了\(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 1 || indexPath.row == 0 {
            let identifier = "Cell"
            var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
            if cell == nil {
                cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
                
                if indexPath.row == 0 {
                    let coupon_priceLable = UILabel(frame: CGRect(x: 0, y: 20, width: 20, height: 20))
                    coupon_priceLable.text = "价格"
                    coupon_priceLable.sizeToFit()
                    cell?.contentView.addSubview(coupon_priceLable)
                    
                    //现价
                    let priceLabel1 = UILabel(frame: CGRect(x: coupon_priceLable.right, y: coupon_priceLable.top, width: 100, height: 20))
                    priceLabel1.tag = 2015
                    priceLabel1.textColor = UIColor.redColor()
                    cell!.contentView.addSubview(priceLabel1)
                    
                    //原价
                    let priceLabel2 = UILabelStrikeThrough(frame: CGRect(x: priceLabel1.right + 10, y: priceLabel1.top, width: 50, height: 20))
                    priceLabel2.tag = 2016
                    priceLabel2.isWithStrikeThrough = true
                    priceLabel2.textAlignment = .Center
                    priceLabel2.textColor = UIColor.blackColor()
                    cell!.contentView.addSubview(priceLabel2)
                    
                    //推荐框
//                    self.sizeView = UIView(frame: CGRect(x: (kScreenWidth - 250) / 2, y: coupon_priceLable.bottom + 5, width: 250, height: 50)
//                    cell?.contentView.addSubview(self.sizeView)
                    let sizeLabel = UILabel(frame: CGRect(x: (kScreenWidth - 300) / 2, y: coupon_priceLable.bottom + 5, width: 300, height: 50))
                    sizeLabel.textAlignment = .Center
                    sizeLabel.tag = 2017
//                    let text = "小编推荐 衣服尺码:M，仅供参考"
                    cell!.contentView.addSubview(sizeLabel)
                }else if(indexPath.row == 1) {
                    let descriptionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 50))
                    descriptionLabel.layer.borderColor = UIColor.blackColor().CGColor
                    descriptionLabel.layer.borderWidth = 1
                    descriptionLabel.font = UIFont.systemFontOfSize(15)
                    descriptionLabel.textColor = UIColor.blueColor()
                    descriptionLabel.text = "产品信息"
                    descriptionLabel.textAlignment = .Center
                    cell?.contentView.addSubview(descriptionLabel)
                }
            }
            
//            print(cell?.contentView.subviews)
            
            if indexPath.row == 0 {
                let sizeLabel1 = cell!.contentView.viewWithTag(2017) as! UILabel
                if self.sellModel?.size != nil && self.sellModel?.size?.characters.count > 0 {
                    sizeLabel1.hidden = false
                }else {
                    sizeLabel1.hidden = true
                }
                let text = "小编推荐 衣服尺码:\((self.sellModel?.size)!)，仅供参考"
                let count = self.sellModel?.size.characters.count
                let atttibutedText = NSMutableAttributedString(string: text)
               atttibutedText.setAttributes([NSFontAttributeName:UIFont.boldSystemFontOfSize(20), NSForegroundColorAttributeName: UIColor.blueColor()], range: NSMakeRange(0, 5))
                atttibutedText.setAttributes([NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont.systemFontOfSize(16)], range: NSMakeRange(5, 5))
                atttibutedText.setAttributes([NSForegroundColorAttributeName: UIColor.cyanColor(), NSFontAttributeName: UIFont.boldSystemFontOfSize(16)], range: NSMakeRange(10, count!))
                atttibutedText.setAttributes([NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont.boldSystemFontOfSize(16)], range: NSMakeRange(10 + count!, 5))
                sizeLabel1.attributedText = atttibutedText
                
                let priceLabel1 = cell?.contentView.viewWithTag(2015) as! UILabel
                priceLabel1.text = "¥" + (self.sellModel?.coupon_price)!
                
                let priceLabel2 = cell?.contentView.viewWithTag(2016) as! UILabel
                priceLabel2.text = "\(NSString.init(string: (self.sellModel?.price)!).floatValue)"
//                    NSString(format: "%.2\((self.sellModel?.price))") as String
            }
            cell!.selectionStyle = .None
            return cell!
        }else{
            let cell = NSBundle.mainBundle().loadNibNamed("BuyTableViewCell", owner: nil, options: nil).last as! BuyTableViewCell
            cell.sellModel = self.sellModel
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if self.sellModel?.size != nil && self.sellModel?.size.characters.count > 0 {
                return 110
            }else {
                return 60
            }
        }else if(indexPath.row == 1) {
            return 50
        }else {
            return 400
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 400
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 400))
        imageView.sd_setImageWithURL(NSURL(string: (self.sellModel?.pic_url)!))
        let label = UILabel(frame: CGRect(x: 0, y: 350, width: kScreenWidth, height: 50))
        label.backgroundColor = UIColor.cyanColor()
        label.font = UIFont.systemFontOfSize(15)
        label.numberOfLines = 2
        label.alpha = 0.5
        label.text = self.sellModel?.title
        imageView.addSubview(label)
        return imageView
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
