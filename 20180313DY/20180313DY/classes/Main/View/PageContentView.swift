//
//  PageContentView.swift
//  20180313DY
//
//  Created by 王效金 on 2018/3/14.
//  Copyright © 2018年 王效金. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView: PageContentView,progress: CGFloat,sourceIndex: Int,targetIndex: Int)
}

let contenCellID = "contenCellID"

class PageContentView: UIView {
    //定义属性
    fileprivate var childVcs: [UIViewController]
    fileprivate weak var parentViewControllView: UIViewController?
    fileprivate var starOffsetX : CGFloat  = 0
    weak var  delegate : PageContentViewDelegate?
    //懒加载
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        //layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contenCellID)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self
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
            parentViewControllView?.addChildViewController(childVc)
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

extension PageContentView: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
         starOffsetX = scrollView.contentOffset.x
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("----")
        //定义数据
        var progress : CGFloat = 0  //滑动的比例
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //判断是左滑 还是右滑
        let currentOffsetX : CGFloat = collectionView.contentOffset.x
        let collectionViewW : CGFloat = collectionView.frame.width
        
        if currentOffsetX > starOffsetX {//左滑
            //计算滑动的比例
            progress = currentOffsetX / collectionViewW - floor(currentOffsetX / collectionViewW)
            //计算sourceIndex
            sourceIndex = Int(currentOffsetX/collectionViewW)
            //targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            //滑块完全划过去
            if currentOffsetX - starOffsetX == collectionViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else {//右滑
            progress = 1 - (currentOffsetX / collectionView.frame.width - floor(currentOffsetX / collectionViewW))
            //计算targetIndex
            targetIndex = Int(currentOffsetX/collectionViewW)
            //sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        //将progress/sourceIndex/targetIndex
        print("progress \(progress) sourceIndex \(sourceIndex) targetIndex \(targetIndex)")
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

//对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currenIndex: Int){
        //根据点击的label计算x的偏移值
        let offsetX = CGFloat(currenIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}


