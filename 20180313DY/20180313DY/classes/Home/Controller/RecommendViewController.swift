//
//  RecommendViewController.swift
//  20180313DY
//
//  Created by 王效金 on 2018/3/15.
//  Copyright © 2018年 王效金. All rights reserved.
//

import UIKit

fileprivate let kItemMargin : CGFloat = 10
fileprivate let kItemW : CGFloat = (kSreenW - (3*kItemMargin))/2
fileprivate let kItemH : CGFloat = kItemW * 3 / 4
fileprivate let kNormalCellID = "kNormalCellID"
fileprivate let kHeadHeight : CGFloat = 50
fileprivate let kHeadViewID = "kHeadViewID"

class RecommendViewController: UIViewController {
    //MARK: 系统回调函数
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        //对collectionView进行布局layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0  //垂直方向间距
        layout.minimumInteritemSpacing = kItemMargin //水平方向间距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 10, right: kItemMargin)//设置内边距
        
        //创建UIcollectionView
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:kNormalCellID) //注册UICollectionViewCell
        collectionView.autoresizingMask = [.flexibleHeight ,.flexibleWidth] //设置collectionView跟随父控制器拉伸
        
        layout.headerReferenceSize = CGSize(width: kSreenW, height: kHeadHeight) //设置头部视图的size
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeadViewID) //注册头部视图
        
        collectionView.backgroundColor = UIColor.orange
        collectionView.dataSource = self
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.purple
       
        //设置UI界面
        settupUI()
        
    }

}


//MARK: 设置UI界面
extension RecommendViewController {
    fileprivate func settupUI(){
        view.addSubview(collectionView)
    }
}


//MARK: 遵守协议
extension RecommendViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        
        cell.backgroundColor = UIColor.yellow

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //取出headView
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeadViewID, for: indexPath)
        headView.backgroundColor = UIColor.brown
        return headView
    }
}
