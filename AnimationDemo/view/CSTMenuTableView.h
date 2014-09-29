//
//  CSTMenuTableView.h
//  AnimationDemo
//
//  Created by 溸馨 on 14-9-28.
//  Copyright (c) 2014年 Violet Iris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSTBaseView.h"
#import "CSTAnimationModel.h"

@interface CSTMenuTableView : CSTBaseView
@property (nonatomic, strong) CSTAnimationModel *dataModel;

-(void)showMenu;
-(void)hideMenu;
@end
