//
//  HomeViewController.swift
//  20180313DY
//
//  Created by 王效金 on 2018/3/13.
//  Copyright © 2018年 王效金. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setupUI()
    }

}

//设置UI界面
extension HomeViewController {
    fileprivate func setupUI(){
        //1, 设置导航栏控制器
        setupNavigetionbar()
    }
    fileprivate func setupNavigetionbar() {
        //1, 设置左侧的Item
        //创建btn
        //将btn指定为导航栏左侧Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        //2,设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", hightImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", hightImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", hightImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
}
