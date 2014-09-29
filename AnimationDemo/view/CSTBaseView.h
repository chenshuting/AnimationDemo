//
//  CSTBaseView.h
//  AnimationDemo
//
//  Created by 溸馨 on 14-9-28.
//  Copyright (c) 2014年 Violet Iris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSTAnimationViewController.h"

@interface CSTBaseView : UIView
/**
 *  指向控制该view的controller
 */
@property (nonatomic, strong) CSTAnimationViewController *viewController;
@end
