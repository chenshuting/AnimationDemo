//
//  CSTAnimationCollection.h
//  AnimationDemo
//
//  Created by 溸馨 on 14-9-28.
//  Copyright (c) 2014年 Violet Iris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSTGlobal.h"
#import "CSTAnimationViewController.h"

@interface CSTAnimationCollection : NSObject
@property (nonatomic, strong) CSTAnimationViewController *viewController;

-(SEL)getAnimationSEL:(CSTAnimation)type;

-(float)timeInterval:(CSTAnimation)type;
@end