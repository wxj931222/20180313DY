//
//  PageTitleView.swift
//  20180313DY
//
//  Created by 王效金 on 2018/3/13.
//  Copyright © 2018年 王效金. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView (_ titleView: PageTitleView,selectedindex: Int)
}

fileprivate let kScrollViewLineH : CGFloat = 2

class PageTitleView: UIView {
    //定义属性
    fileprivate var titles : [String]
    fileprivate var currentIndex : Int = 0
    weak var delegate: PageTitleViewDelegate?
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
            let lableW = frame.width / CGFloat(titles.count)
            let lableH = frame.height - kScrollViewLineH
            let lableY = 0
            let lableX = lableW * CGFloat(index)
            
            lable.frame = CGRect(x: lableX, y: CGFloat(lableY), width: lableW, height: lableH)
            scrollVier.addSubview(lable)
            titlesLables.append(lable)
            
            //给Lable添加手势
            lable.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            lable.addGestureRecognizer(tapGes)
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
    @objc fileprivate func titleLabelClick(_ tapGes: UITapGestureRecognizer) {
        //获取当前label
        guard let currentLabel = tapGes.view as? UILabel else { return }
       
        
        //获取上一个Label
        let oldLabel = titlesLables[currentIndex]
        
        //保存最新Label下标志
        currentIndex = currentLabel.tag
        //更改Label的字体颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.black
        
        //改变滑块位置
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.size.width
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //通知代理做事情
        delegate?.pageTitleView(self, selectedindex: currentIndex)
    }
}

extension PageTitleView {
    func setTitleWithProgress(progress: CGFloat,sourceIndex: Int,targetIndex: Int){
        print("progress \(progress) sourceIndex \(sourceIndex) targetIndex \(targetIndex)")
        //改变label颜色
        
        //改变滑块位置
    }
}

