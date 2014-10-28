//
//  TestCustomClassView.m
//  swiftGame
//
//  Created by jingfuran on 14/10/22.
//  Copyright (c) 2014年 jingfuran. All rights reserved.
//

#import "TestCustomClassView.h"

@implementation TestCustomClassView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/

- (void)drawRect:(CGRect)rect {
    CGContextRef contect = UIGraphicsGetCurrentContext();
    CGRect myframe = self.bounds;
    CGContextSetLineWidth(contect, 20);
    CGContextSetLineCap(contect, kCGLineCapSquare);
    CGRectInset(myframe, 5, 5);
    [[UIColor greenColor] set];
    UIRectFrame(myframe);
    
    self.layer.masksToBounds =  YES;
    self.layer.cornerRadius = 8;
}


@end
