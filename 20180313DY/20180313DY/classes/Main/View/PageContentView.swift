//
//  PageContentView.swift
//  20180313DY
//
//  Created by 王效金 on 2018/3/14.
//  Copyright © 2018年 王效金. All rights reserved.
//

import UIKit

let contenCellID = "contenCellID"


class PageContentView: UIView {
    //定义属性
    fileprivate var childVcs: [UIViewController]
    fileprivate var parentViewControllView: UIViewController
    //懒加载
    fileprivate lazy var collectionView : UICollectionView = {
        //layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contenCellID)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self as? UICollectionViewDelegate
        collectionView.dataSource = self
        return collectionView
    }()
    //方法
    init(frame: CGRect , childVcs: [UIViewController] ,parentViewControllView: UIViewController) {
        self.childVcs = childVcs
        self.parentViewControllView = parentViewControllView
        super.init(frame: frame)

        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//设置UI界面
extension PageContentView {
    fileprivate func setupUI() {
        //1. 将所有子控制器添加到父控制器中
        for childVc in childVcs {
            parentViewControllView.addChildViewController(childVc)
        }
        
        //2. 添加collectionView,由于在cell中添加View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//遵守UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contenCellID, for: indexPath)
        //防止循环引用
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

