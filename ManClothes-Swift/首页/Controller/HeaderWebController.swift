//
//  HeaderWebController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/25.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit

class HeaderWebController: BaseViewController {

    var webView:UIWebView!
    var urlStr:NSString!
    var isTianmao:Bool?
    
    
    
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
    }
    
    func _initView() {
        self.webView = UIWebView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64))
        let request = NSMutableURLRequest(URL: NSURL(string: self.urlStr as String)!)
        self.webView.loadRequest(request)
        self.view.addSubview(self.webView)
        //屏幕自适应
        self.webView.scalesPageToFit = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
