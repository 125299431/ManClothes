//
//  SearchViewController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/31.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var collectionView:UICollectionView!
    var textFiled:UITextField!
    var data:NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self._initView()
        
        self._loadData()
        
    }
    
    func _initView() {
        let leftBtn = UIButton(type: .custom)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        leftBtn.setImage(UIImage(named: "Tmall_back.png"), for: UIControlState())
        leftBtn.addTarget(self, action: #selector(SearchViewController.backClick), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        let rightItem = UIBarButtonItem(title: "搜索", style: .done, target: self, action: #selector(SearchViewController.searchClick))
        self.navigationItem.rightBarButtonItem = rightItem
        
        //搜索栏
        self.textFiled = UITextField(frame: CGRect(x: 0, y: 0, width: kScreenWidth - 120, height: 40))
        self.textFiled.placeholder = "请输入感兴趣的内容"
        self.textFiled.borderStyle = .roundedRect
        self.textFiled.backgroundColor = UIColor.white
        self.textFiled.tintColor = UIColor.red
        self.textFiled.clearButtonMode = .whileEditing
        self.navigationItem.titleView = self.textFiled
        
        let textImageView = UIImageView(image: UIImage(named: "search_red.png"))
        self.textFiled.leftView = textImageView
        self.textFiled.leftViewMode = .always
        
        //collectionView
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.itemSize = CGSize(width: (kScreenWidth - 80) / 3, height: 40)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.isScrollEnabled = false
        self.collectionView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0)
        self.view.addSubview(self.collectionView)
        
        //注册单元格
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "SearchCell")
    }
    
    func backClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchClick() {
        let searchResultVC = SearchResultViewController()
        searchResultVC.typeStr = textFiled.text
        let nav = UINavigationController(rootViewController: searchResultVC)
        self.present(nav, animated: false, completion: nil)
    }
    
    func _loadData() {
        self.data = ["青春","都市","休闲","商务","穿搭","配色","情侣","英伦","复古","日韩","设计师","小清新","运动"]
        self.collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.contentView.layer.cornerRadius = 5
        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.borderColor = UIColor.blue.cgColor
        cell.contentView.layer.borderWidth = 1
        let label = UILabel(frame: cell.contentView.bounds)
        label.textAlignment = .center
        label.text = self.data[indexPath.row] as? String
        cell.contentView.addSubview(label)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let searchResultVC = SearchResultViewController()
        searchResultVC.typeStr = self.data[indexPath.row] as! String
        let nav = UINavigationController(rootViewController: searchResultVC)
        self.present(nav, animated: true, completion: nil)
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
