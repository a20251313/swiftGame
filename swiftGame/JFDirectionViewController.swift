//
//  JFDirectionViewController.swift
//  swiftGame
//
//  Created by jingfuran on 14-10-13.
//  Copyright (c) 2014年 jingfuran. All rights reserved.
//

import Foundation
import UIKit

enum birdDirection
{
    case left,right,up,down;
    func desprition()->String
    {
        switch self
            {
        case .up:
            return "UP";
        case .down:
            return "DOWN"
        case .left:
            return "LEFT"
        case .right:
            return "RIGHT"
            
        }
    }
}
class JFDirectionViewController: UIViewController
{
    
    var fromPoint:CGPoint = CGPointZero;
    var endPoint:CGPoint = CGPointZero;
    var birdDire:birdDirection = birdDirection.left;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true);
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Fade);
        
        var label:UILabel = UILabel(frame: CGRectMake(0, 100, 100, 35))
        label.backgroundColor = UIColor.lightGrayColor();
        label.textColor = UIColor.blackColor();
        label.text = "Test Swift";
        self.view.addSubview(label)
        
        self.view.backgroundColor = UIColor.lightGrayColor();
        
        
        var tapGest:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "swipeFinger:")
        self.view.addGestureRecognizer(tapGest)
    }
    override func loadView() {
     super.loadView()
    }
    
    

    
    func swipeFinger(gest:UIPanGestureRecognizer?)
    {
        var infoPoint:CGPoint = gest!.locationInView(self.view);
        
        switch (gest!.state)
            {
        case UIGestureRecognizerState.Possible:
                endPoint = infoPoint;
        case UIGestureRecognizerState.Began:
                fromPoint = infoPoint;
        case UIGestureRecognizerState.Changed:
                endPoint = infoPoint;
        case UIGestureRecognizerState.Ended:
                endPoint = infoPoint;
                self.panEnd(1)
        case UIGestureRecognizerState.Cancelled:
                endPoint = infoPoint;
        case UIGestureRecognizerState.Failed:
                endPoint = infoPoint;
            
            
  
        }
        println(gest);
    }
    func panEnd(direValue:Int)
    {
        println("from point \(fromPoint),end point:\(endPoint)")
        var leftDis:CGFloat = endPoint.x-fromPoint.x
        var verDis:CGFloat = endPoint.y-fromPoint.y;
        if abs(leftDis) > abs(verDis)
        {
            if (leftDis >= 0)
            {
                birdDire = birdDirection.right;
            }else
            {
                birdDire = birdDirection.left;
            }
            
        }else
        {
            if (verDis >= 0)
            {
                birdDire = birdDirection.down;
            }else
            {
                birdDire = birdDirection.up;
            }
        }
        
        println("current direction:\(birdDire.desprition())")
        
    }
}
