//
//  JFScoreView.swift
//  swiftGame
//
//  Created by jingfuran on 14-10-14.
//  Copyright (c) 2014年 jingfuran. All rights reserved.
//

import Foundation
import UIKit

class JFScoreView: UIView {
    
    var scoreLabel:UILabel?;
    var score:Int = 0{
        willSet(newScore)
        {
            
        }
        didSet(newScore)
        {
            println("currentscore:\(newScore)")
            self.setNewValueFroScore(newScore)
        }
    }
    
    
    func setNewValueFroScore(newscore:Int)
    {
        if scoreLabel == nil
        {
            var fwidth:CGFloat = self.frame.size.width;
            var fheight:CGFloat = self.frame.size.height;
            scoreLabel = UILabel(frame:CGRectMake(fwidth/2, 5, fwidth/2, fheight-10));
            scoreLabel?.backgroundColor = UIColor(red: 102/255, green: 194/255.0, blue: 206/255.0, alpha: 1);
            scoreLabel?.textColor = UIColor.blackColor();
            scoreLabel?.textAlignment = NSTextAlignment.Center;
            scoreLabel?.font = UIFont.systemFontOfSize(15);
            self.addSubview(scoreLabel!);
            
            var wordLabel:UILabel = UILabel(frame: CGRectMake(0, 5, fwidth/2, fheight-10));
            wordLabel.backgroundColor = UIColor(red: 102/255, green: 194/255.0, blue: 206/255.0, alpha: 1);
            wordLabel.textColor = UIColor.blackColor();
            wordLabel.textAlignment = NSTextAlignment.Center;
            wordLabel.text = "SCORE";
            wordLabel.font = UIFont.systemFontOfSize(15);
            self.addSubview(wordLabel)
            
        }
        
        scoreLabel?.text = "\(newscore)";
        
    }
    override init(frame: CGRect) {
        self.score = 0;
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 102/255, green: 194/255.0, blue: 206/255.0, alpha: 1);
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.score = aDecoder.decodeIntegerForKey("score");
    }
    
  
   
    
    
}