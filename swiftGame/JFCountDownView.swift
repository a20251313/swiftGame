//
//  JFCountDownView.swift
//  swiftGame
//
//  Created by jingfuran on 14-10-14.
//  Copyright (c) 2014年 jingfuran. All rights reserved.
//

import Foundation


@objc protocol JFCountDownViewDelegate
{
    func countDownFinished(countView:JFCountDownView!);
    
}

//100 * 100
class JFCountDownView: UIImageView {
    
    var countDownNumber:Int = 3;
    var labelCount:UILabel?
    var mainTimer:NSTimer?
    var arrayTimer:[Int] = [1,2,3];
    weak var delegate:JFCountDownViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = UIImage(named: "game_countdownDot.png");
        
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    func startCountDown(seconds:Int)->Bool
    {
        countDownNumber = seconds
        self.startMainTime(seconds)
        return true;
    }
    
    
    func showNumberWithSeconds(seconds:Int)
    {
        if labelCount == nil
        {
            labelCount = UILabel(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
            labelCount?.backgroundColor = UIColor.clearColor();
            labelCount?.textAlignment = NSTextAlignment.Center;
            labelCount?.textColor = UIColor.purpleColor();
            self.addSubview(labelCount!);
        }
        
        labelCount?.text = "\(countDownNumber)"
        
        var ani:CABasicAnimation = CABasicAnimation.aniWithScale(1, tovalue: 0.5, fromValue: 1);
        self.layer.addAnimation(ani, forKey:"");
    }
    func mainTimer(timers:NSTimer!)
    {
        countDownNumber--;
        println("mainTimer:\(countDownNumber)")
        if countDownNumber <= 0
        {
            self.stopMainTimer();
            delegate?.countDownFinished(self);
            return
        }
        self.showNumberWithSeconds(countDownNumber);
        
       
    }
    func stopMainTimer()
    {
        if mainTimer != nil
        {
            if (mainTimer?.valid != nil)
            {
                mainTimer?.invalidate();
            }
            
        }
        mainTimer = nil;
    }
    
    func startMainTime(seconds:Int)
    {
        
        self.stopMainTimer()
        countDownNumber = seconds;
        mainTimer = NSTimer(fireDate: NSDate(), interval: 1.0, target: self, selector:"mainTimer:", userInfo: nil, repeats: true);
        NSRunLoop.currentRunLoop().addTimer(mainTimer!, forMode: NSDefaultRunLoopMode);
        self.showNumberWithSeconds(seconds)
      //  mainTimer?.fire();
    }
    
        
}