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
    int lastEdge;
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
        case CSTAnimation3DRotate:
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
            timeInterval = 0.5;
            break;
        case CSTAnimation3DRotate:
            timeInterval = 1;
            break;
        case CSTAnimationClock:
            timeInterval = 1.0;
            break;
        case CSTAnimationFastRotate:
            timeInterval = 1;
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

-(float)getValidY:(float)y
{
    float validY;
    
    switch (lastEdge) {
        case 2: //上边
            validY = CST_ANIMATION_TOP;
            break;
        case 3: //下边
            validY = CST_ANIMATION_BOTTOM;
        default:
            if (y < CST_ANIMATION_TOP) {
                y += CST_ANIMATION_TOP;
            } else if (y > CST_ANIMATION_BOTTOM) {
                y -= CST_ANIMATION_VIEW_SIZE;
            }
            break;
    }

    
    return validY;
}

-(float)getValidX:(float)x
{
    float validX;
    switch (lastEdge) {
        case 0: //左边
            validX = CST_ANIMATION_LEFT;
            break;
        case 1: //右边
            validX = CST_ANIMATION_RIGHT;
        default:
            validX = x > CST_ANIMATION_RIGHT ? CST_ANIMATION_RIGHT : x;
            break;
    }
    
    return validX;
}

-(void)saveValidNewDirection:(int)direction
{
    if (direction != lastEdge) {
        lastEdge = direction;
    } else {
        switch (direction) {
            case 0: //左边
                lastEdge = 1;
                break;
            case 1: //右边
                lastEdge = 0;
                break;
            case 2: //上边
                lastEdge = 3;
                break;
            case 3: //下边
                lastEdge = 2;
                break;
            default:
                break;
        }
    }
    
    
}

-(void)CSTMoving:(id)sender
{
    UIView *view = self.viewController.animationView;
    
    float x = arc4random() % ((int)CST_SCREEN_WIDTH);
    float y  = arc4random() % ((int)CST_SCREEN_HEIGHT);
    
    int direction = arc4random() % 4;
    [self saveValidNewDirection:direction];
    
    x = [self getValidX:x];
    y = [self getValidY:y];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:timeInterval];
    CGRect newFrame = CGRectMake(x, y, view.frame.size.width, view.frame.size.height);
    view.frame = newFrame;
    [UIView commitAnimations];
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
    UIView *view = self.viewController.animationView;

    BOOL hide = !view.hidden;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:timeInterval];
    [view setHidden:hide];
    [UIView commitAnimations];
}

-(void)CSTRotateAndBlowUp:(id)sender
{
    UIView *view = self.viewController.animationView;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D fromTransfer = CATransform3DMakeRotation(0, 0, 0, 0);
    CATransform3D rotateTransfer = CATransform3DMakeRotation(M_PI * 0.5, -5, 5, 0);
    CATransform3D scaleTransfer = CATransform3DMakeScale(1, 1, 5);
    /*合并两个动作*/
    CATransform3D combinedTransfer = CATransform3DConcat(rotateTransfer, scaleTransfer);
    
    /*放在3D坐标系中最正确的位置*/
    [animation setFromValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
    [animation setFromValue:[NSValue valueWithCATransform3D:fromTransfer]];
    [animation setToValue:[NSValue valueWithCATransform3D:combinedTransfer]];
    [animation setDuration:timeInterval];
    
    CABasicAnimation *animationOpacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [animationOpacity setFromValue:[NSNumber numberWithFloat:alpha]];
    [animationOpacity setToValue:[NSNumber numberWithFloat:!alpha]];
    [animationOpacity setDuration:timeInterval];
    
    [view.layer addAnimation:animation forKey:nil];
    [view.layer addAnimation:animationOpacity forKey:nil];
    [view setAlpha:!alpha];
}
@end
