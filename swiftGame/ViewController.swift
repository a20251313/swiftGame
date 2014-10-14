//
//  ViewController.swift
//  swiftGame
//
//  Created by jingfuran on 14-10-13.
//  Copyright (c) 2014年 jingfuran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Hello Game";
        var btnStart:UIButton = UIButton(frame: CGRectMake(0, 0, 200, 45));
        btnStart.setTitle("Start", forState: UIControlState.Normal);
        btnStart.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal);
        btnStart.layer.masksToBounds = true;
        btnStart.layer.cornerRadius = 5;
        btnStart.backgroundColor = UIColor.lightGrayColor();
        btnStart.center = self.view.center;
        btnStart.addTarget(self, action:"buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(btnStart);
        self.view.backgroundColor = UIColor.whiteColor();
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    func buttonClicked(sender:UIButton?)
    {
        
        println(self.navigationController)
        var dirController:JFDirectionViewController = JFDirectionViewController();
        self.navigationController?.pushViewController(dirController, animated: true)
//        dispatch_async(dispatch_get_main_queue(), {
//            var dirController:JFDirectionViewController = JFDirectionViewController();
//            self.navigationController?.pushViewController(dirController, animated: true)
//            
//        })
       
    }


}

