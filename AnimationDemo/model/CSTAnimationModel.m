//
//  CSTAnimationModel.m
//  AnimationDemo
//
//  Created by 溸馨 on 14-9-28.
//  Copyright (c) 2014年 Violet Iris. All rights reserved.
//

#import "CSTAnimationModel.h"

@implementation CSTAnimationModel

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark private

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark accessor
-(NSArray *)menuData
{
    if (!_menuData) {
        _menuData = [[NSArray alloc] initWithObjects:
                    @"Fade in/out", @"Twinkle", @"Moving", @"Blow up", @"Rotate",
                    @"3D Rotate",@"Clock", @"Fast Rotate",
                    nil];
    }
    return _menuData;
}

@end
