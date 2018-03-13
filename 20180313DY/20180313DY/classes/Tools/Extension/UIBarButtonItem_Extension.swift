//
//  UIBarButtonItem_Extension.swift
//  20180313DY
//
//  Created by 王效金 on 2018/3/13.
//  Copyright © 2018年 王效金. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    class func createrItem (imageName:String ,hightImageName:String ,size:CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        btn.frame = CGRect(origin: .zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    //hightImageName:String = ""   默认参数,此参数可以不传
    convenience init(imageName:String ,hightImageName:String = "",size:CGSize = .zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if hightImageName != "" {
            btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        }
        if size == .zero {
            btn.sizeToFit()
        }else {
            btn.frame = CGRect(origin: .zero, size: size)
        }
        self.init(customView:btn)
    }
}
