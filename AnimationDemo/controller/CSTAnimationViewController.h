//
//  CSTViewController.h
//  AnimationDemo
//
//  Created by shuting.chen on 14-9-28.
//  Copyright (c) 2014年 Violet Iris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSTAnimationModel.h"
#import "CSTGlobal.h"

@interface CSTAnimationViewController : UIViewController
@property (nonatomic, strong) CSTAnimationModel *dataModel;

-(void)animationChanged:(CSTAnimation)animationType;
@end

