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

class JFDirectionViewController: UIViewController,JFCountDownViewDelegate,JFMenuViewControllerDelegate
{
    
    var fromPoint:CGPoint = CGPointZero;
    var endPoint:CGPoint = CGPointZero;
    var currentBirdDire:birdDirection = birdDirection.up;
    var bgBirdView:UIView?
    var scoreView:JFScoreView?
    var scroe:Int = 0;
    var buttonBack:UIButton?
    let gameTime:Int = 20;
    
    //var mainSeconds:Int = 0;
    //var mainTimer:NSTimer?
    var singleSeconds:Int = 0;
    var singleTimer:NSTimer?
    var mainTimerView:JFCountNumberView?
    var isFirstEnter:Bool = true
    
    var puaseSeconds:Int = 0;
    var puaseSingSeconds:Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.navigationController?.setNavigationBarHidden(true, animated: true);
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Fade);
        self.view.backgroundColor = UIColor.lightGrayColor();
        let tapGest:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "swipeFinger:")
        self.view.addGestureRecognizer(tapGest)
        
      
        var fwidth:CGFloat = self.view.frame.size.width;
        var fheight:CGFloat = self.view.frame.size.height;
        for i in 1...6
        {
            let name:String = "lostInMigration_cloud"+"\(i)"+".png"
            let image:UIImage = UIImage(named:name);
            var xpoint:CGFloat = 0;
            var ypoint:CGFloat = (CGFloat)(30.0+i*40.0);
            if i%2 == 0
            {
                xpoint = (fwidth/2-image.size.width/2)/2;
            }else
            {
                xpoint = fwidth/2+(fwidth/2-image.size.width/2)/2;
            }
            
            var cloudView:UIImageView = UIImageView(frame: CGRectMake(xpoint, ypoint, image.size.width/2, image.size.height/2));
            cloudView.image = image;
            cloudView.alpha = 0.5;
            self.view.addSubview(cloudView);
            
        }
        
        
        
        [self.setCenterBireDir(birdDirection.up)];
        scoreView = JFScoreView(frame: CGRectMake(self.view.frame.size.width-160, 0, 150, 40));
        scoreView?.score = 0;
        self.view.addSubview(scoreView!);
        
        var layercontent:CGImageRef = UIImage(named:"lostInMigration_background.png").CGImage;
        self.view.layer.contents = layercontent;
        
        
        var image:UIImage = UIImage(named: "lostInMigration_horizon.png");
        var imageView:UIImageView = UIImageView(frame: CGRectMake((fwidth-320)/2, fheight-112, 320, 112));
        imageView.image = image;
        self.view.addSubview(imageView)
        
        self.addFunHome();
        mainTimerView = JFCountNumberView(frame: CGRectMake(self.view.frame.size.width-160-102, 0, 100, 40));
        mainTimerView?.delegate = self;
        self.view.addSubview(mainTimerView!);
        
        
       
        
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    func addFunHome()
    {
        buttonBack?.removeFromSuperview();
        buttonBack = nil;
        buttonBack = UIButton(frame: CGRectMake(10, 10, 30, 30));
        buttonBack?.setImage(UIImage(named: "game_iconMainMenuUp.png"), forState: UIControlState.Normal);
        buttonBack?.addTarget(self, action: "clickBack:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(buttonBack!);
    }
    
    func addFuncPause()
    {
        buttonBack?.removeFromSuperview();
        buttonBack = nil;
        buttonBack = UIButton(frame: CGRectMake(10, 10, 30, 30));
        buttonBack?.setImage(UIImage(named: "game_buttonPauseUp.png"), forState: UIControlState.Normal);
        buttonBack?.addTarget(self, action: "clickPause:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(buttonBack!);
    }
    override func loadView() {
     super.loadView()
    }
    
    func clickBack(sender:UIButton!)
    {
        self.navigationController?.popViewControllerAnimated(true);
    }
    func clickPause(sender:UIButton!)
    {
        
 
        self.stopSingleTimer();
        puaseSeconds = mainTimerView!.countSeconds;
        puaseSingSeconds = singleSeconds;
        mainTimerView?.stopcountTimer();
        var menuControll:JFMenuViewController = JFMenuViewController();
        menuControll.delegate = self;
        NSNotificationCenter.defaultCenter().removeObserver(self);
        self.navigationController?.pushViewController(menuControll, animated: true);
    }

    func testLocal(extername localname:String)
    {
        println(localname);
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (isFirstEnter)
        {
            self.startNewGame();
            isFirstEnter = false;
        }
        
    }
    
    func startSingleTime(fromseconds:Int)
    {
        self.stopSingleTimer()
        singleSeconds = fromseconds;
        singleTimer = NSTimer(fireDate: NSDate(), interval: 1, target: self, selector: "singleTime:", userInfo: nil, repeats: true);
        singleTimer?.fire();
        
        
    }
    func singleTime(timers:NSTimer!)
    {
        singleSeconds++;
        
    }
    func stopSingleTimer()
    {
        if singleTimer != nil
        {
            if (singleTimer?.valid != nil)
            {
                singleTimer?.invalidate();
            }
        }
        singleTimer = nil;
    }
    
    /*
    func mainTimer(timers:NSTimer!)
    {
        mainSeconds++;
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
    
    func startMainTime()
    {
       
        self.stopMainTimer()
        mainSeconds = 0;
        mainTimer = NSTimer(fireDate: NSDate(), interval: 1, target: self, selector: "mainTimer:", userInfo: nil, repeats: true);
        mainTimer?.fire();
        
        
    }*/
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
        var imageName = "game_feedbackCorrect.png";
        var answerView:UIImageView = UIImageView(frame: CGRectMake((self.view.frame.size.width-36)/2, (self.view.frame.size.height-36)/2-110,36,36));
        if currentBirdDire == fingerDir
        {
            scroe += 100;
            scoreView?.setNewValueFroScore(scroe);
            
        }else
        {
            imageName = "game_feedbackIncorrect.png";
            
        }
        answerView.image = UIImage(named:imageName);
        self.view.addSubview(answerView);
        var ani:CABasicAnimation = CABasicAnimation.aniWithScale(0.3, tovalue: 2, fromValue: 0.25);
        ani.delegate = self;
        ani.setValue(answerView, forKey: "view");
        answerView.layer.addAnimation(ani, forKey:"");
        
        
        var randseed:UInt32 = (UInt32)(NSDate().timeIntervalSince1970);
        srand(randseed);
        var randDir:Int = random()%4+1;
     
        var dir:birdDirection = birdDirection.fromRaw(randDir)!;
           println("+++++++++++++++++++dir:\(dir.desprition())+++++++++++++\n\n\n");
        self.setCenterBireDir(dir);
        self.startSingleTime(0);
        
        
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
        self.startSingleTime(0);
        
    }
    
     func countDownFinished(countView:AnyObject!)
     {
       
        if countView is JFCountDownView
        {
            countView.removeFromSuperview();
            self.addFuncPause()
            mainTimerView?.startMainTime(gameTime);
            self.startSingleTime(0);
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveEnterBgGround:", name:UIApplicationDidEnterBackgroundNotification, object: nil);
            
        }else if countView is JFCountNumberView
        {
            var winView = JFWinScoreView(frame: CGRectMake((self.view.frame.size.width-260)/2, (self.view.frame.size.height-80)/2, 260, 80), points: 0);
            self.view.addSubview(winView);
            winView.showPoints(scroe);
            self.addFunHome()
            
        }
        
     }
    
    func startNewGame()
    {
     
        self.setCenterBireDir(birdDirection.up);
        self.scroe = 0;
        self.scoreView?.score = 0;
        self.scoreView?.setNewValueFroScore(0);
        
        
        var countDownView:JFCountDownView = JFCountDownView(frame: CGRectMake(0, 0, 100, 100));
        countDownView.center = self.view.center;
        self.view.addSubview(countDownView);
        countDownView.delegate = self;
        countDownView.startCountDown(3);
        
        
    }
    func didSelectActionOfIndex(index:Int)
    {
        
        println("didSelectActionOfIndex:\(index)");
        if (index == 0)
        {
            self.mainTimerView?.startMainTime(puaseSeconds);
            self.startSingleTime(puaseSingSeconds);
            self.navigationController?.popViewControllerAnimated(true);
        }else if (index == 1)
        {
            self.navigationController?.popViewControllerAnimated(true);
            self.startNewGame()
        }else if(index == 2)
        {
            self.navigationController?.popToRootViewControllerAnimated(true);
        }
    }
    func receiveEnterBgGround(note:NSNotification!)
    {
        if(self.navigationController?.viewControllers.last as UIViewController == self)
        {
              self.clickPause(nil);
        }
     
    }
    
    
    override func animationDidStart(anim: CAAnimation!)
    {
        
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool)
    {
        var view:UIView = anim.valueForKey("view") as UIView;
        view.removeFromSuperview();
    }
}
