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
    
    convenience init(rred:CGFloat,ggreen:CGFloat,bblue:CGFloat)
    {
        self.init(red: rred*1.0/255.0, green: ggreen*1.0/255.0, blue: bblue*1.0/255.0, alpha: 1.0);
    }
    
    convenience init(rred:CGFloat,ggreen:CGFloat,bblue:CGFloat,alpha:CGFloat)
    {
        self.init(red: rred*1.0/255.0, green: ggreen*1.0/255.0, blue: bblue*1.0/255.0, alpha: alpha);
    }
  
    class func colorRGB(red:CGFloat,green:CGFloat,blue:CGFloat)->UIColor
    {
        return UIColor(red: red*1.0/255.0, green: green*1.0/255.0, blue: blue*1.0/255.0, alpha: 1);
    }
    class func colorRGBA(red:CGFloat,green:CGFloat,blue:CGFloat,alpha:CFloat)->UIColor
    {
        return UIColor(red: red*1.0/255.0, green: green*1.0/255.0, blue: blue*1.0/255.0, alpha: 1);
    }
}