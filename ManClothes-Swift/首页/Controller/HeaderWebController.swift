//
//  HeaderWebController.swift
//  ManClothes-Swift
//
//  Created by ZhengHongye on 16/3/25.
//  Copyright © 2016年 zhenghongye. All rights reserved.
//

import UIKit
import WebKit
class HeaderWebController: BaseViewController {

    var webView:WKWebView!
    var urlStr:NSString!
    var isTianmao:Bool?
    var progressView:UIProgressView!
    
    
    
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
        if self.isTianmao == true {
            let leftBtn = UIButton(type: .Custom)
            leftBtn.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
            leftBtn.setImage(UIImage(named: "Tmall_back.png"), forState: .Normal)
            leftBtn.addTarget(self, action: #selector(HeaderWebController.backClick(_:)), forControlEvents: .TouchUpInside)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        }
        self.webView = WKWebView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64))
        let request = NSMutableURLRequest(URL: NSURL(string: self.urlStr as String)!)
        self.webView.loadRequest(request)
        self.view.addSubview(self.webView)
        
        self.progressView = UIProgressView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 2))
        self.progressView.trackTintColor = UIColor.whiteColor()
//        self.progressView.progress = 0.5
        self.view.addSubview(self.progressView)
        //监听进度条的变化
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
        //屏幕自适应
//        self.webView.scalesPageToFit = true
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "estimatedProgress" {
            self.progressView.progress = Float(self.webView.estimatedProgress)
            self.progressView.alpha = 1
            if self.progressView.progress >= 1 {
                UIView.animateWithDuration(0.35, animations: {
                    self.progressView.alpha = 0
                    self.progressView.removeFromSuperview()
                })
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress", context: nil)
    }
    
    
    func backClick(btn:UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
