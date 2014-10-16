//
//  JFWinScoreView.swift
//  swiftGame
//
//  Created by jingfuran on 14-10-16.
//  Copyright (c) 2014年 jingfuran. All rights reserved.
//

import Foundation



class JFWinScoreView: UIView {
    var labelInfo:UILabel?;
    var point:Int = 0;
    
    init(frame: CGRect,points:Int)
    {
        self.point = points;
        super.init(frame: frame);
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        fatalError("init(coder:) has not been implemented")
    }
    func showPoints(points:Int)
    {
        //31 15 26
        var fwidth:CGFloat = self.frame.size.width;
        var fheight = self.frame.size.height;
        let fsep:CGFloat = 5.0
        if (labelInfo == nil)
        {
            labelInfo = UILabel(frame:CGRectMake(fsep, fsep, fwidth-2*fsep, fheight-2*fsep));
            labelInfo?.backgroundColor = UIColor.whiteColor();
            labelInfo?.textColor = UIColor.blackColor();
            self.addSubview(labelInfo!);
            labelInfo?.textAlignment = NSTextAlignment.Center;
            labelInfo?.numberOfLines = 2;
        }
        labelInfo?.text = "Good jobs!You earned \(points) points";
        
        self.backgroundColor = UIColor(rred: 31, ggreen: 15, bblue: 26, alpha: 0.7);
        var basicAni = CABasicAnimation.aniWithScale(1, tovalue:1, fromValue: 0.25);
        basicAni.delegate = self;
        self.layer.addAnimation(basicAni, forKey: "");
        
    }
    
    
    override func animationDidStart(anim: CAAnimation!)
    {
        
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool)
    {
    
        var timerRemove = NSTimer(timeInterval: 3, target: self, selector: "removeFromSuperview", userInfo: nil, repeats:false);
        NSRunLoop.currentRunLoop().addTimer(timerRemove, forMode: NSDefaultRunLoopMode);
    }
    
}