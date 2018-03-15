//
//  HomeViewController.swift
//  20180313DY
//
//  Created by 王效金 on 2018/3/13.
//  Copyright © 2018年 王效金. All rights reserved.
//

import UIKit

private var titlesHeight : CGFloat = 40

class HomeViewController: UIViewController {
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatuesBarH + kNavigetionBarH, width:kSreenW , height:titlesHeight)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titlesView = PageTitleView(frame: titleFrame, titles: titles)
        titlesView.delegate = self
        titlesView.backgroundColor = UIColor.white
        return titlesView
    }()
    
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        //1. 确认frame
        let contentHeight = kSreenH - (kStatuesBarH + kNavigetionBarH + titlesHeight + kTabbarH)
        let contentFrame = CGRect(x: 0, y: kStatuesBarH + kNavigetionBarH + titlesHeight, width: kSreenW, height: contentHeight)
        //2. 确认子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        //3. 确认父控制器
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewControllView: self!)
        contentView.delegate = self
        return contentView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setupUI()
    }

}

//设置UI界面
extension HomeViewController {
    fileprivate func setupUI(){
        //0. 不需要调整scrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        //1, 设置导航栏控制器
        setupNavigetionbar()
        //2. 添加Title
        view.addSubview(pageTitleView)
        //3. 设置content
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.red
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

//遵=遵守PageTitleViewDelegate
extension HomeViewController :PageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedindex: Int) {
        pageContentView.setCurrentIndex(currenIndex: selectedindex)
    }
}
//MARK: 遵守PageContentViewDelegate
extension HomeViewController: PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

