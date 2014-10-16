//
//  JFCountNumberView.swift
//  swiftGame
//
//  Created by jingfuran on 14-10-15.
//  Copyright (c) 2014年 jingfuran. All rights reserved.
//

import Foundation


class JFCountNumberView: UIView {
    var labelCount:UILabel?
    var countSeconds:Int = 0;
    var countTimer:NSTimer?
    weak var delegate:JFCountDownViewDelegate?;
    
    
    
    func showNumberWithSeconds(seconds:Int)
    {
        if labelCount == nil
        {
            labelCount = UILabel(frame: CGRectMake(self.frame.size.width/2,0, self.frame.size.width/2, self.frame.size.height))
            labelCount?.backgroundColor = UIColor.clearColor();
            labelCount?.textAlignment = NSTextAlignment.Center;
            labelCount?.textColor = UIColor.purpleColor();
            self.addSubview(labelCount!);
            var labelTime:UILabel = UILabel(frame: CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height))
            labelTime.backgroundColor = UIColor.clearColor();
            labelTime.text = "TIME";
            self.addSubview(labelTime);
        }
        
        self.backgroundColor = UIColor(red: 102/255, green: 194/255.0, blue: 206/255.0, alpha: 1);
        
       
        var stringTime:String = String(format:"%02d:%02d",countSeconds/60,countSeconds%60);
        labelCount?.text = stringTime;
//        var ani:CABasicAnimation = CABasicAnimation.aniWithScale(1, tovalue: 0.5, fromValue: 1);
//        self.layer.addAnimation(ani, forKey:"");
    }
    
    func countTimer(timers:NSTimer!)
    {
        
        self.showNumberWithSeconds(countSeconds);
        
        
       // println("countTimer:\(countSeconds)")
        if countSeconds <= 0
        {
            self.stopcountTimer();
            delegate?.countDownFinished(self);
            return
        }
        
        countSeconds--;
        
        
        
    }
    func stopcountTimer()
    {
        if countTimer != nil
        {
            if (countTimer?.valid != nil)
            {
                countTimer?.invalidate();
            }
            
        }
        countTimer = nil;
    }
    
    func startMainTime(seconds:Int)
    {
        
        self.stopcountTimer()
        countSeconds = seconds;
        countTimer = NSTimer(fireDate: NSDate(), interval: 1.0, target: self, selector:"countTimer:", userInfo: nil, repeats: true);
        NSRunLoop.currentRunLoop().addTimer(countTimer!, forMode: NSDefaultRunLoopMode);
        
        //  countTimer?.fire();
    }
}