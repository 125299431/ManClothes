//
//  HomeHeaderView.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/16.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class HomeHeaderView: UICollectionReusableView , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //背景父视图
    var bgView:UIView!
    //滑动视图
    var collectionView:UICollectionView!
    //分页视图
    var pageControl:UIPageControl!
    //滑动的页数
    var pageNum:Int!
    //定时器
    var timer:Timer?
    //头视图滑动的大数组
    var maxData:[AnyObject]?
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self._initView()
        
    }
    
    func _initView() {
        //父视图
        self.bgView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 250))
        self.addSubview(self.bgView)
        
        //滑动的照片墙
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.itemSize = CGSize(width: kScreenWidth, height: 195)
        flowLayout.scrollDirection = .horizontal
        
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 195), collectionViewLayout: flowLayout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        //滑到第二张图片的位置 实际是数组的第一个图片
        self.collectionView.scrollRectToVisible(CGRect(x: kScreenWidth, y: 0, width: kScreenWidth, height: 0), animated: false)
        self.collectionView.isHidden = true
        
        //注册单元格
        self.collectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: "pictureCell")
        self.bgView.addSubview(self.collectionView)
        
        //分页视图
        self.pageControl = UIPageControl(frame: CGRect(x: 0, y: 180, width: self.bgView.width, height: 20))
        self.pageControl.currentPage = 0
        self.pageControl.pageIndicatorTintColor = UIColor.red
        self.bgView.addSubview(self.pageControl)
        
        
        //分割线
        let lineView = UIView(frame: CGRect(x: (kScreenWidth - 1) / 2, y: self.collectionView.bottom + 3, width: 1, height: 30 - 6))
        lineView.backgroundColor = UIColor.darkGray
        self.bgView.addSubview(lineView)
        
        for index in 0...1 {
            let button = UIButton(type: UIButtonType.custom)
            button.tag = 2016 + index
            button.addTarget(self, action: #selector(HomeHeaderView.themeButtonAction(_:)), for: UIControlEvents.touchUpInside)
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            button.addSubview(imageView)
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.frame = CGRect(x: CGFloat(50 + Int(kScreenWidth / 2) * index), y: self.collectionView.bottom, width: 120, height: 30)
            self.bgView.addSubview(button)
        }
        
        //精选
        let drawLabel = DrawLabel()
        drawLabel.frame = CGRect(x: 0, y: self.collectionView.bottom + 30, width: kScreenWidth, height: 25)
        drawLabel.backgroundColor = UIColor(red: 192/255.0, green: 192/255.0, blue: 192/255.0, alpha: 1)
        self.bgView.addSubview(drawLabel)
        
    }
    
    func themeButtonAction(_ btn:UIButton) {
        if btn.tag == 2016 {
            //潮品专区
            let fationVC = FationController()
            self.viewController().navigationController?.pushViewController(fationVC, animated: true)
        }else {
            //日常专区
            let dailyVC = DailyViewController()
            let nav = UINavigationController(rootViewController: dailyVC)
            self.viewController().present(nav, animated: true, completion: nil)
        }
        
    }
    
    func scrollToNextPage(_ timer:Timer) {
        self.collectionView.setContentOffset(CGPoint(x: self.collectionView.contentOffset.x + self.collectionView.width, y: self.collectionView.contentOffset.y), animated: true)
        
        //计算出当前的页数
        let currentPage = Int(floor((self.collectionView.contentOffset.x - self.collectionView.width / 2) / self.collectionView.width) + 1)
        self.pageControl.currentPage = currentPage
        //???
//        if currentPage == self.scrollerData?.count {
//            currentPage = 0
//        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //专区数据
    var themeData:[AnyObject]? {
        willSet(newValue) {
            self.setNeedsLayout()
        }
        
        didSet(oldValue) {
            
        }
    }
    
    //头视图中滚动视图的数据
    var scrollerData:[AnyObject]? {
        willSet(newValue) {
            //创建最终的滑动数组
            self.pageControl.numberOfPages = (newValue?.count)!
            self.maxData = NSMutableArray(array: newValue!) as [AnyObject]
            self.maxData?.insert((newValue?.last)!, at: 0)
            self.maxData?.append(newValue![0])

            
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
            self.collectionView.isHidden = false
            //定时器
            if self.timer == nil {
                self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(HomeHeaderView.scrollToNextPage(_:)), userInfo: nil, repeats: true)
            }
            
        }
        
        didSet(oldValue) {
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for index in 0...1 {
            let button = self.viewWithTag(2016 + index) as! UIButton
            let imageView = button.subviews[0] as! UIImageView
            if (self.themeData != nil) {
                let headerModel = self.themeData?[index] as! HomeHerderModel
                imageView.sd_setImage(with: URL(string: headerModel.theme_image!))
                print(headerModel.theme_name!.characters.count)
                imageView.right = imageView.right - CGFloat(headerModel.theme_name!.characters.count - 4)
                button.setTitle(headerModel.theme_name, for: UIControlState())
                button.setTitleColor(UIColor.black, for: UIControlState())
            }
           
            
        }
    }
    
    //MARK:UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = self.maxData?.count {
            return count
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureCell", for: indexPath) as! HeaderCollectionViewCell
        let headerModel = self.maxData![indexPath.row] as! HomeHerderModel
        cell.urlStr = headerModel.theme_image
        return cell
    }
    
    //点击单元格
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case (self.scrollerData?.count)! - 1:
            //卖场
            let headerSellVC = HeaderSellController()
            let nav = UINavigationController(rootViewController: headerSellVC)
            self.viewController().present(nav, animated: true, completion: nil)
            break
        case (self.scrollerData?.count)!:
            //照片墙
            let photoVC = PhotoViewController()
            let nav = UINavigationController(rootViewController: photoVC)
            self.viewController().present(nav, animated: true, completion: nil)
            break
        default:
            let webVC = HeaderWebController()
            let headerModel = self.maxData![indexPath.row] as! HomeHerderModel
            webVC.urlStr = headerModel.theme_link as NSString!
            self.viewController().navigationController?.pushViewController(webVC, animated: true)
            break
            
        }
        
    }
    
    //MARK:UIScrollViewDelegate
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.scrollViewDidEndDecelerating(self.collectionView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = self.collectionView.width
        let pageHeight = self.collectionView.height
        let currentPage = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        if currentPage == 0 {
            //显示的是最后一张，但是是第一张，此时应该是右划，需要滑到倒数第二张，显示的是最后一张图片
            self.collectionView.scrollRectToVisible(CGRect(x: CGFloat(Int(pageWidth) * self.scrollerData!.count), y: 0, width: pageWidth, height: pageHeight), animated: false)
            self.pageControl.currentPage = (self.scrollerData?.count)! + 1
            return
        }else if currentPage == (self.scrollerData?.count)! + 1{
            //到了最后第张，但是显示的是第一张，左划，需要滑到第二张
            self.collectionView.scrollRectToVisible(CGRect(x: pageWidth, y: 0, width: pageWidth, height: pageHeight), animated: false)
            self.pageControl.currentPage = 0
            return
        }
        
        self.pageControl.currentPage = currentPage - 1
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.timer?.invalidate()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(HomeHeaderView.scrollToNextPage(_:)), userInfo: nil, repeats: true)
    }
        
}





