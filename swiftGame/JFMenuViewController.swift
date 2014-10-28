//
//  JFMenuControllerView.swift
//  swiftGame
//
//  Created by jingfuran on 14-10-15.
//  Copyright (c) 2014年 jingfuran. All rights reserved.
//

import Foundation

@objc protocol JFMenuViewControllerDelegate
{
    func didSelectActionOfIndex(index:Int);
}

class JFMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    var m_tableView:UITableView?;
    weak var delegate:JFMenuViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        m_tableView = UITableView(frame: CGRectMake(0, (self.view.frame.size.height-50*3)/2, self.view.frame.size.width, 50*3), style: UITableViewStyle.Plain);
        m_tableView?.delegate = self;
        m_tableView?.dataSource = self;
        self.view.addSubview(m_tableView!);
        m_tableView?.reloadData();
        m_tableView?.separatorColor = UIColor.clearColor();
        m_tableView?.showsVerticalScrollIndicator = false;
        m_tableView?.backgroundColor = UIColor.clearColor();
        m_tableView?.backgroundView = UIView();
        m_tableView?.scrollEnabled = false;
        self.view.backgroundColor = UIColor.whiteColor();
        self.view.layer.contents = UIImage(named: "speedPack_background.png")!.CGImage;
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        delegate?.didSelectActionOfIndex(indexPath.row);
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 44;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell
        
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell");
            var imageView:UIImageView = UIImageView(frame: CGRectMake(20, 7, 30, 30));
            imageView.tag = 100;
            cell?.contentView.addSubview(imageView);
            
            var labelText = UILabel(frame: CGRectMake(120, 5, 200, 35));
            labelText.tag = 200;
            labelText.backgroundColor = UIColor.clearColor();
            labelText.text = "RESUME";
            labelText.textColor = UIColor(rred: 48, ggreen: 169, bblue: 225);
            cell?.contentView.addSubview(labelText);
            cell?.backgroundColor = UIColor(rred: 49, ggreen: 39, bblue: 24,alpha:0.5);
        }
        
        let imageView:UIImageView = cell?.contentView.viewWithTag(100) as UIImageView;
        let labelText = cell?.contentView.viewWithTag(200) as UILabel;
        switch indexPath.row
        {   case 0:
                imageView.image = UIImage(named: "game_iconResumeUp.png");
                labelText.text = "Resume";
            case 1:
                imageView.image = UIImage(named: "game_iconRestartUp.png");
                labelText.text = "ReStart";
            case 2:
                imageView.image = UIImage(named: "game_iconMainMenuUp.png");
                labelText.text = "Home";
            default:
                break;
        }
        
        return cell!;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
}