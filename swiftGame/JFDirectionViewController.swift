//
//  JFDirectionViewController.swift
//  swiftGame
//
//  Created by jingfuran on 14-10-13.
//  Copyright (c) 2014年 jingfuran. All rights reserved.
//

import Foundation
import UIKit
enum birdDirection:Int
{
    case left = 1,right,up,down;
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
    var currentBirdDire:birdDirection = birdDirection.left;
    var bgBirdView:UIView?
    var scoreView:JFScoreView?
    var scroe:Int = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true);
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Fade);
        self.view.backgroundColor = UIColor.lightGrayColor();
        let tapGest:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "swipeFinger:")
        self.view.addGestureRecognizer(tapGest)
        
        [self.setCenterBireDir(birdDirection.up)];
        var fwidth:CGFloat = self.view.frame.size.width;
        var fheight:CGFloat = self.view.frame.size.height;
        
        
        scoreView = JFScoreView(frame: CGRectMake(self.view.frame.size.width-160, 0, 150, 40));
        scoreView?.score = 0;
        self.view.addSubview(scoreView!);
        
        var layercontent:CGImageRef = UIImage(named:"lostInMigration_background.png").CGImage;
        self.view.layer.contents = layercontent;
        
        
        var image:UIImage = UIImage(named: "lostInMigration_horizon.png");
        var imageView:UIImageView = UIImageView(frame: CGRectMake((fwidth-320)/2, fheight-112, 320, 112));
        imageView.image = image;
        self.view.addSubview(imageView)
        
    }
    override func loadView() {
     super.loadView()
    }
    
    

    func testLocal(extername localname:String)
    {
        println(localname);
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
        var fingerDir:birdDirection  = birdDirection.left;
        if abs(leftDis) > abs(verDis)
        {
            if (leftDis >= 0)
            {
                fingerDir = birdDirection.right;
            }else
            {
                fingerDir = birdDirection.left;
            }
            
        }else
        {
            if (verDis >= 0)
            {
                fingerDir = birdDirection.down;
            }else
            {
                fingerDir = birdDirection.up;
            }
        }
        
        println("current direction:\(fingerDir.desprition())")
        
        if currentBirdDire == fingerDir
        {
            scroe += 100;
            scoreView?.score = scroe;
        }
        var randseed:UInt32 = (UInt32)(NSDate().timeIntervalSince1970);
        srand(randseed);
        var randDir:Int = random()%4+1;
     
        var dir:birdDirection = birdDirection.fromRaw(randDir)!;
           println("+++++++++++++++++++dir:\(dir.desprition())+++++++++++++\n\n\n");
        [self .setCenterBireDir(dir)];
        
        
    }
    
    deinit
    {
        println("JFDirectionViewController deinit");
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    func setCenterBireDir(dir:birdDirection)
    {
        var sizeWithPng:CGSize = UIImage(named: "lostInMigration_birdDown.png").size;
       // sizeWithPng = CGSizeMake(sizeWithPng.width/2, sizeWithPng.height/2);
        var fsep:CGFloat = 10;
        var fwidth:CGFloat = sizeWithPng.width*3+fsep*2;
        if bgBirdView == nil
        {
            bgBirdView = UIView(frame: CGRectMake(0, 0, fwidth, fwidth));
            bgBirdView?.backgroundColor = UIColor.clearColor()
            bgBirdView?.center = self.view.center;
            self.view.addSubview(bgBirdView!);
        }
        
        var imageForCenter:UIImage? = UIImage(named: "lostInMigration_birdDown.png");
        switch dir
        {
        case .left:
            imageForCenter = UIImage(named: "lostInMigration_birdLeft.png");
        case .right:
            imageForCenter = UIImage(named: "lostInMigration_birdRight.png");
        case .up:
            imageForCenter = UIImage(named: "lostInMigration_birdUp.png");
        case .down:
            imageForCenter = UIImage(named: "lostInMigration_birdDown.png");
        }
        for  item in bgBirdView!.subviews
        {
            if(item as? UIView == bgBirdView)
            {
                continue;
            }
            
            item.removeFromSuperview();
            
        }
        
        
        for i in 0..<5
        {
            var fxpoint:CGFloat = 0;
            var fypoint:CGFloat = 0;
            var birdView:UIImageView?
            switch i
            {
            case 0:
                fxpoint = (bgBirdView!.frame.size.width-sizeWithPng.width)/2;
                fypoint = 0;
            case 1:
                fxpoint = 0;
                fypoint = sizeWithPng.height+fsep;
            case 2:
                fxpoint = sizeWithPng.width+fsep;
                fypoint = sizeWithPng.height+fsep;
            case 3:
                fxpoint = sizeWithPng.width*2+fsep*2;
                fypoint = sizeWithPng.height+fsep;
            case 4:
                fxpoint = (bgBirdView!.frame.size.width-sizeWithPng.width)/2;
                fypoint = sizeWithPng.height*2+fsep*2;
            default:
                break;
            }
            
            birdView = UIImageView(frame: CGRectMake(fxpoint, fypoint, sizeWithPng.width, sizeWithPng.height));
            bgBirdView?.addSubview(birdView!);
            birdView?.image = imageForCenter;
            
        }
        
        currentBirdDire = dir;
 
        
    }
}
