//
//  CSTAnimationCollection.m
//  AnimationDemo
//
//  Created by 溸馨 on 14-9-28.
//  Copyright (c) 2014年 Violet Iris. All rights reserved.
//

#import "CSTAnimationCollection.h"

@interface CSTAnimationCollection()
{
    float timeInterval;
    float alpha;
    float angle;
}

@end

@implementation CSTAnimationCollection
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public
-(SEL)getAnimationSEL:(CSTAnimation)type
{
    SEL animationSelection = nil;
    switch (type) {
        case CSTAnimationFadeInOut:
            animationSelection = @selector(CSTFadeInOut:);
            break;
        case CSTAnimationBlowUp:
            animationSelection = @selector(CSTBlowUp:);
            break;
        case CSTAnimationMoving:
            animationSelection = @selector(CSTMoving:);
            break;
        case CSTAnimationRotate:
            animationSelection = @selector(CSTRotate:);
            break;
        case CSTAnimationTwinkle:
            animationSelection = @selector(CSTTwinkle:);
            break;
        case CSTAnimationRotateAndBlowUp:
            animationSelection = @selector(CSTRotateAndBlowUp:);
            break;
        case CSTAnimationClock:
            animationSelection = @selector(CSTClock:);
            break;
        case CSTAnimationFastRotate:
            animationSelection = @selector(CSTFastRotate:);
            break;
        default:
            break;
    }
    return animationSelection;
}

-(float)timeInterval:(CSTAnimation)type
{
    switch (type) {
        case CSTAnimationFadeInOut:
            timeInterval = 2.0;
            break;
        case CSTAnimationBlowUp:
            timeInterval = 2.0;
            break;
        case CSTAnimationMoving:
            timeInterval = 3.0;
            break;
        case CSTAnimationRotate:
            timeInterval = 2.0;
            break;
        case CSTAnimationTwinkle:
            timeInterval = 1;
            break;
        case CSTAnimationRotateAndBlowUp:
            timeInterval = 1;
            break;
        case CSTAnimationClock:
            timeInterval = 1.0;
            break;
        case CSTAnimationFastRotate:
            timeInterval = 1.0;
            break;
        default:
            break;
    }
    return timeInterval;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private
-(void)CSTFadeInOut:(id)sender
{
    UIView *view = self.viewController.animationView;
    if(view.alpha < 1) {
        alpha = 1;
    } else {
        alpha = 0;
    }
    
    /*渐入渐出动画效果*/
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:timeInterval];
    view.alpha = alpha;
    [UIView commitAnimations];
}

-(void)CSTBlowUp:(id)sender
{
    /*视图准备*/
    UIView *view = self.viewController.animationView;
    CGRect frame = self.viewController.view.bounds; //从小大变大
    alpha = 0;
    if (view.frame.size.width > CST_ANIMATION_VIEW_SIZE) { //从大变小
        frame = CGRectMake((CST_SCREEN_WIDTH - CST_ANIMATION_VIEW_SIZE) * 0.5,
                            (CST_SCREEN_HEIGHT - CST_ANIMATION_VIEW_SIZE - CST_NAVIBAR_HEIGHT) *0.5,
                            CST_ANIMATION_VIEW_SIZE, CST_ANIMATION_VIEW_SIZE);
        alpha = 1;
    }

    /*放大消失动画效果*/
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:timeInterval];
    view.frame = frame;
    view.alpha = alpha;
    [UIView commitAnimations];
}

-(void)CSTMoving:(id)sender
{
 
}

-(void)CSTRotate:(id)sender
{
    /*视图准备*/
    self.viewController.animationView.transform =
        CGAffineTransformRotate(self.viewController.animationView.transform, M_PI / 900);
}

-(void)CSTClock:(id)sender
{
    /*视图准备*/
    UIView *view = self.viewController.animationView;
    angle += 30;
    if (angle >= 360) {
        angle = 0;
    }
    
    CGAffineTransform transfer = CGAffineTransformMakeRotation(M_PI * angle / 180);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:timeInterval / 12];
    /*旋转*/
    view.transform = transfer;
    [UIView commitAnimations];
}

-(void)CSTFastRotate:(id)sender
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.toValue = @(M_PI * 4); //决定旋转的圈数
    animation.duration = timeInterval;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.delegate = self.viewController.view;
    [self.viewController.animationView.layer addAnimation:animation forKey:@"animation"];
}

-(void)CSTTwinkle:(id)sender
{
    
}
-(void)CSTRotateAndBlowUp:(id)sender
{
    
}
@end
