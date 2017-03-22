//
//  UIImageView+Corner.m
//  demo1
//
//  Created by kunpeng on 16/4/9.
//  Copyright © 2016年 zhiruiyun. All rights reserved.
//

#import "UIImageView+Corner.h"

@implementation UIImageView (Corner)

+ (UIImageView*)cornerImageView:(CGRect)frame {
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds
                                                   byRoundingCorners:UIRectCornerAllCorners
                                                         cornerRadii:imageView.bounds.size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = imageView.bounds;
    maskLayer.path = maskPath.CGPath;
    imageView.layer.mask = maskLayer;
    return imageView;
}
@end
