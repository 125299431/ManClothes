//
//  DetailIssuseController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/31.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
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
        headerView.backgroundColor = UIColor.clear
        let titleLabel = UILabel(frame: CGRect(x: 0, y: headerView.height - 10 - 30, width: kScreenWidth, height: 40))
        
        titleLabel.text = self.headerTitle
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        headerView.addSubview(titleLabel)
        
        self.tableView = UITableView(frame: self.view.bounds, style: .plain)
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.tableHeaderView = headerView
        self.view.addSubview(self.tableView)
        
        let bgImageView = UIImageView(frame: self.view.bounds)
        bgImageView.alpha = 0.5
        bgImageView.sd_setImage(with: URL(string: self.bgImg!))
        self.tableView.backgroundView = bgImageView
        
        self.imgView = UIImageView()
        
        //四个按钮
        let buttonImgArr = ["backButton.png", "shareButton.png", "search_white", "topic_uncollect"]
        var m = 0
        for i in 0...1 {
            for j in 0...1 {
                let button = UIButton(type: .custom)
                button.tag = 2015 + m
                button.backgroundColor = UIColor.black
                button.layer.cornerRadius = 16
                button.layer.masksToBounds = true
                button.alpha = 0.6
                let btn_x = 30 + CGFloat(j) * (kScreenWidth - 30 - 32 - 30)
                let btn_y = 40 + CGFloat(i) * (kScreenHeight - 40 - 32 - 64)
                button.frame = CGRect(x: btn_x, y: btn_y, width: 32, height: 32)
                button.setImage(UIImage(named: buttonImgArr[m]), for: UIControlState())
                if m == 3 {
                    button.setImage(UIImage(named: "collected.png"), for: .selected)
                }
                button.addTarget(self, action: #selector(DetailIssuseController.buttonClick(_:)), for: .touchUpInside)
                self.view.addSubview(button)
                m += 1
            }
        }
        
    
    }
    
    
    func buttonClick(_ btn:UIButton) {
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
        self.navigationController?.popViewController(animated: true)
    }
    
    func _loadData() {
        let params = NSMutableDictionary()
        params.setObject("detail", forKey: "action" as NSCopying)
        params.setObject(self.albumId!, forKey: "albumId" as NSCopying)
        params.setObject(self.album_type!, forKey: "album_type" as NSCopying)
        DataSerive.requireDataWithURL(json_rm as NSString, params: params, method: "GET", successBlock: { (operation, resust) in
            let jsonArr = resust["data"] as! NSArray
            let mArr = NSMutableArray()
            for dic in jsonArr {
                var issuseModel = DetailModel()
                issuseModel = issuseModel.initContentWithDic(dic as! NSDictionary) as! DetailModel
                mArr.add(issuseModel)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.data != nil {
            return (self.data?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let detailModel = self.data![indexPath.row] as! DetailModel
        let issuseModel = detailModel.issuseModel! as IssuseModel
        
        let block_type = issuseModel.block_type?.int32Value
        if block_type == 3 {
            //图片
            let identifier = "PictureCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
                let imgView = ZoomImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenWidth * 3 / 5))
                imgView.tag = 200
                cell?.contentView.addSubview(imgView)
            }
            
            let imgView = cell?.contentView.viewWithTag(200) as! ZoomImageView
            imgView.contentMode = .scaleToFill
            imgView.addTapZoomImageViewWithImageUrl(issuseModel.article as! String)
            imgView.sd_setImage(with: URL(string: issuseModel.article! as String), placeholderImage: UIImage(named: "plaseholder.png"))
            //根据图片的大小显示单元格的大小
            let imgHeight = 1.2 * (imgView.image?.size.height)! * kScreenWidth / (imgView.image?.size.width)!
            imgView.height = imgHeight
            
            return cell!
        }else if(block_type == 4) {
            //文字
            let idetifier = "TextCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: idetifier)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: idetifier)
                cell?.selectionStyle = .none
                let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 0))
                textLabel.numberOfLines = 0
                textLabel.tag = 2016
                textLabel.font = UIFont.systemFont(ofSize: 16)
                cell?.contentView.addSubview(textLabel)
            }
            let textLabel = cell?.contentView.viewWithTag(2016) as! UILabel
            let rect = issuseModel.article?.boundingRect(with: CGSize(width: kScreenWidth, height: 1000), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 16)], context: nil)
            textLabel.height = (rect?.size.height)!
            textLabel.text = issuseModel.article as? String
            return cell!
        }else {
            let idetifier = "DetailCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: idetifier)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: idetifier)
            }
            //collectionView
            //判断是否有小的单元格
            if detailModel.productArr?.count > 0 {
                //有小单元格
                let flowLayout = UICollectionViewFlowLayout()
                self.detailCollectionView = DetailCollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        var rowHeight:CGFloat = 0
        let detailModel = self.data![indexPath.row] as! DetailModel
        let issuseModel = detailModel.issuseModel
        let block_type = issuseModel?.block_type?.int32Value
        if block_type == 3 {
            //图片
            self.imgView.sd_setImage(with: URL(string: issuseModel?.article as! String), placeholderImage: UIImage(named: "plaseholder.png"))
            let imageHeight = 1.2 * (self.imgView.image!.size.height) * kScreenWidth / (self.imgView.image!.size.width)
            return imageHeight;
//            rowHeight += imageHeight
        }else if(block_type == 4) {
            //文字
//            rowHeight += tableView.rowHeight
            print(issuseModel?.article)
            let rect = issuseModel?.article?.boundingRect(with: CGSize(width: kScreenWidth, height: 1000), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 16)], context: nil)
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
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
