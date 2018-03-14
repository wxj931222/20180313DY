//
//  PageTitleView.swift
//  20180313DY
//
//  Created by 王效金 on 2018/3/13.
//  Copyright © 2018年 王效金. All rights reserved.
//

import UIKit

fileprivate let kScrollViewLineH : CGFloat = 2

class PageTitleView: UIView {
    //定义属性
    fileprivate var titles : [String]
    //定义懒加载属性
    fileprivate lazy var scrollVier : UIScrollView = {
        let scrollVier = UIScrollView()
        scrollVier.showsHorizontalScrollIndicator = false
        scrollVier.bounces = false
        scrollVier.scrollsToTop = false
        return scrollVier
    }()
    
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    fileprivate lazy var titlesLables : [UILabel] = [UILabel]()
    
    //自定义构造函数
    init(frame: CGRect,titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension PageTitleView {
    fileprivate func setupUI() {
        //1. 添加UIScrollView
        addSubview(scrollVier)
        scrollVier.frame = bounds
        
        //2. 设置titlesLable
        setupTitleLables()
        
        //3. 设置titles
        setupBottomAndScrollView()
    }
    
    //设置titles下的底线、以及滑块
    fileprivate func setupTitleLables() {
        for (index,item) in titles.enumerated() {
            let lable = UILabel()
            lable.text = item
            lable.tag = index
            lable.font = UIFont.systemFont(ofSize: 16.0)
            lable.textColor = UIColor.black
            lable.textAlignment = .center
            print(item)
            let lableW = frame.width / CGFloat(titles.count)
            let lableH = frame.height - kScrollViewLineH
            let lableY = 0
            let lableX = lableW * CGFloat(index)
            
            lable.frame = CGRect(x: lableX, y: CGFloat(lableY), width: lableW, height: lableH)
            scrollVier.addSubview(lable)
            titlesLables.append(lable)
        }
    }
    //设置titles底部划线
    fileprivate func setupBottomAndScrollView() {
        //创建底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.gray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //添加scrollLine
        guard let fristLable = titlesLables.first else {return}
        fristLable.textColor = UIColor.orange
        
        scrollVier.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: fristLable.frame.origin.x, y: frame.height - kScrollViewLineH, width:fristLable.frame.width , height: kScrollViewLineH)
    }
}
