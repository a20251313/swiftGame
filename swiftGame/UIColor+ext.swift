//
//  UIColor+ext.swift
//  swiftGame
//
//  Created by jingfuran on 14-10-14.
//  Copyright (c) 2014年 jingfuran. All rights reserved.
//

import Foundation

extension UIColor
    {
    
    func colorRGB(red:CGFloat,green:CGFloat,blue:CGFloat)->UIColor
    {
        return UIColor(red: red*1.0/255.0, green: green*1.0/255.0, blue: blue*1.0/255.0, alpha: 1.0)
    }
    func colorRGBA(red:CGFloat,green:CGFloat,blue:CGFloat,alpha:CGFloat)->UIColor
    {
        return UIColor(red: red*1.0/255.0, green: green*1.0/255.0, blue: blue*1.0/255.0, alpha:alpha)
    }
}