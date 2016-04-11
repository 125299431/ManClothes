//
//  DetailIssuseController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/31.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class DetailIssuseController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView:UITableView!
    var imgView:UIImageView!
    var detailCollectionView:DetailCollectionView!
    var data:NSArray?
    //背景图片
    var bgImg:String!
    //主题
    var headerTitle:String!
    //id
    var albumId:NSNumber?
    
    var album_type:NSNumber?
    
    var issueModel:IssuseModel!
    
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
        let backItem = UIBarButtonItem()
        backItem.title = "返回"
        self.navigationItem.backBarButtonItem = backItem
        self._initView()
        
        self._loadData()
        
    }
    
    func _initView() {
        //表视图的头视图
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 200))
        headerView.backgroundColor = UIColor.clearColor()
        let titleLabel = UILabel(frame: CGRect(x: 0, y: headerView.height - 10 - 30, width: kScreenWidth, height: 40))
        
        titleLabel.text = self.headerTitle
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.boldSystemFontOfSize(17)
        headerView.addSubview(titleLabel)
        
        self.tableView = UITableView(frame: self.view.bounds, style: .Plain)
        self.tableView.separatorStyle = .None
        self.tableView.delegate = self
        self.tableView.tableHeaderView = headerView
        self.view.addSubview(self.tableView)
        
        let bgImageView = UIImageView(frame: self.view.bounds)
        bgImageView.alpha = 0.5
        bgImageView.sd_setImageWithURL(NSURL(string: self.bgImg!))
        self.tableView.backgroundView = bgImageView
        
        self.imgView = UIImageView()
        
        //四个按钮
        let buttonImgArr = ["backButton.png", "shareButton.png", "search_white", "topic_uncollect"]
        var m = 0
        for i in 0...1 {
            for j in 0...1 {
                let button = UIButton(type: .Custom)
                button.tag = 2015 + m
                button.backgroundColor = UIColor.blackColor()
                button.layer.cornerRadius = 16
                button.layer.masksToBounds = true
                button.alpha = 0.6
                let btn_x = 30 + CGFloat(j) * (kScreenWidth - 30 - 32 - 30)
                let btn_y = 40 + CGFloat(i) * (kScreenHeight - 40 - 32 - 64)
                button.frame = CGRect(x: btn_x, y: btn_y, width: 32, height: 32)
                button.setImage(UIImage(named: buttonImgArr[m]), forState: .Normal)
                if m == 3 {
                    button.setImage(UIImage(named: "collected.png"), forState: .Selected)
                }
                button.addTarget(self, action: #selector(DetailIssuseController.buttonClick(_:)), forControlEvents: .TouchUpInside)
                self.view.addSubview(button)
                m += 1
            }
        }
        
    
    }
    
    
    func buttonClick(btn:UIButton) {
        switch (btn.tag - 2015) {
        case 0:
            self.btnClick()
            break
        case 1:
            break
        case 2:
            self.searchForItem()
            break
        case 3:
            break
        default:
            break
            
        }
    }
    
    func searchForItem() {
        let searchVC = SearchViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    func btnClick() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func _loadData() {
        let params = NSMutableDictionary()
        params.setObject("detail", forKey: "action")
        params.setObject(self.albumId!, forKey: "albumId")
        params.setObject(self.album_type!, forKey: "album_type")
        DataSerive.requireDataWithURL(json_rm, params: params, method: "GET", successBlock: { (operation, resust) in
            let jsonArr = resust["data"] as! NSArray
            let mArr = NSMutableArray()
            for dic in jsonArr {
                var issuseModel = DetailModel()
                issuseModel = issuseModel.initContentWithDic(dic as! NSDictionary) as! DetailModel
                mArr.addObject(issuseModel)
            }
            self.data = mArr
            self.tableView.dataSource = self
            self.tableView.reloadData()
            
            }) { (operation, error) in
                
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.data != nil {
            return (self.data?.count)!
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let detailModel = self.data![indexPath.row] as! DetailModel
        let issuseModel = detailModel.issuseModel! as IssuseModel
        
        let block_type = issuseModel.block_type?.intValue
        if block_type == 3 {
            //图片
            let identifier = "PictureCell"
            var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
            if cell == nil {
                cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
                let imgView = ZoomImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenWidth * 3 / 5))
                imgView.tag = 200
                cell?.contentView.addSubview(imgView)
            }
            
            let imgView = cell?.contentView.viewWithTag(200) as! ZoomImageView
            imgView.contentMode = .ScaleToFill
            imgView.addTapZoomImageViewWithImageUrl(issuseModel.article as! String)
            imgView.sd_setImageWithURL(NSURL(string: issuseModel.article! as String), placeholderImage: UIImage(named: "plaseholder.png"))
            //根据图片的大小显示单元格的大小
            let imgHeight = 1.2 * (imgView.image?.size.height)! * kScreenWidth / (imgView.image?.size.width)!
            imgView.height = imgHeight
            
            return cell!
        }else if(block_type == 4) {
            //文字
            let idetifier = "TextCell"
            var cell = tableView.dequeueReusableCellWithIdentifier(idetifier)
            if cell == nil {
                cell = UITableViewCell(style: .Default, reuseIdentifier: idetifier)
                cell?.selectionStyle = .None
                let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 0))
                textLabel.numberOfLines = 0
                textLabel.tag = 2016
                textLabel.font = UIFont.systemFontOfSize(16)
                cell?.contentView.addSubview(textLabel)
            }
            let textLabel = cell?.contentView.viewWithTag(2016) as! UILabel
            let rect = issuseModel.article?.boundingRectWithSize(CGSizeMake(kScreenWidth, 1000), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(16)], context: nil)
            textLabel.height = (rect?.size.height)!
            textLabel.text = issuseModel.article as? String
            return cell!
        }else {
            let idetifier = "DetailCell"
            var cell = tableView.dequeueReusableCellWithIdentifier(idetifier)
            if cell == nil {
                cell = UITableViewCell(style: .Default, reuseIdentifier: idetifier)
            }
            //collectionView
            //判断是否有小的单元格
            if detailModel.productArr?.count > 0 {
                //有小单元格
                let flowLayout = UICollectionViewFlowLayout()
                self.detailCollectionView = DetailCollectionView(frame: CGRectZero, collectionViewLayout: flowLayout)
                cell?.contentView.addSubview(self.detailCollectionView)
            }
            
            var rowHeight: CGFloat = 0
            if (detailModel.productArr?.count)! % 2 == 0 {
                //偶数
                rowHeight = CGFloat((detailModel.productArr?.count)! / 2) * kScreenWidth / 2
            }else {
                //基数
                rowHeight = CGFloat((detailModel.productArr?.count)! / 2) * kScreenWidth / 2 + kScreenWidth - 60
            }
            
            self.detailCollectionView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: rowHeight)
            self.detailCollectionView.productArr = detailModel.productArr
            self.detailCollectionView.reloadData()
            return cell!
        }
        
    }
    
    //动态返回单元格的高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        var rowHeight:CGFloat = 0
        let detailModel = self.data![indexPath.row] as! DetailModel
        let issuseModel = detailModel.issuseModel
        let block_type = issuseModel?.block_type?.intValue
        if block_type == 3 {
            //图片
            self.imgView.sd_setImageWithURL(NSURL(string: issuseModel?.article as! String), placeholderImage: UIImage(named: "plaseholder.png"))
            let imageHeight = 1.2 * (self.imgView.image!.size.height) * kScreenWidth / (self.imgView.image!.size.width)
            return imageHeight;
//            rowHeight += imageHeight
        }else if(block_type == 4) {
            //文字
//            rowHeight += tableView.rowHeight
            print(issuseModel?.article)
            let rect = issuseModel?.article?.boundingRectWithSize(CGSizeMake(kScreenWidth, 1000), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(16)], context: nil)
            print(rect?.size.height)
            return (rect?.size.height)!
//            return tableView.rowHeight;
        }else {
            if detailModel.productArr?.count != 0 {
                if ((detailModel.productArr?.count)! % 2 == 0) {
                    //偶数
                    return CGFloat((detailModel.productArr?.count)! / 2) * kScreenWidth / 2
                }else {
                    //基数
                    return  CGFloat((detailModel.productArr?.count)! / 2) * kScreenWidth / 2 + kScreenWidth - 60
                }
            }
        }
        return 0
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
