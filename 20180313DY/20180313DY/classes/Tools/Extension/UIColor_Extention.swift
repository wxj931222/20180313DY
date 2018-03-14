
//
//  UIColor_Extention.swift
//  20180313DY
//
//  Created by 王效金 on 2018/3/14.
//  Copyright © 2018年 王效金. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat,g: CGFloat,b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1.0)
    }
}
