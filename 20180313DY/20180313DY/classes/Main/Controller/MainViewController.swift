//
//  MainViewController.swift
//  20180313DY
//
//  Created by 王效金 on 2018/3/13.
//  Copyright © 2018年 王效金. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVc(storyName: "Home")
        addChildVc(storyName: "Live")
        addChildVc(storyName: "Follow")
        addChildVc(storyName: "Profile")
    }
    
    fileprivate func addChildVc(storyName : String){
        //1, 通过storeBboard拿到vc
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        //2,将childVc当做子控制器添加到当前视图
        addChildViewController(childVc)
    }
    
}
