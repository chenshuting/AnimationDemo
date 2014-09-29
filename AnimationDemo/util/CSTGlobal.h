//
//  CSTGlobal.h
//  AnimationDemo
//
//  Created by 溸馨 on 14-9-28.
//  Copyright (c) 2014年 Violet Iris. All rights reserved.
//

#ifndef AnimationDemo_CSTGlobal_h
#define AnimationDemo_CSTGlobal_h

/*屏幕的宽度和高度*/
#define CST_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define CST_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define CST_ANIMATION_LEFT 0
#define CST_ANIMATION_RIGHT (CST_SCREEN_WIDTH - CST_ANIMATION_VIEW_SIZE)
#define CST_ANIMATION_TOP CST_NAVIBAR_HEIGHT
#define CST_ANIMATION_BOTTOM (CST_SCREEN_HEIGHT - CST_ANIMATION_VIEW_SIZE)

/*宽度/高度/大小定义*/
#define CST_NAVIBAR_HEIGHT 65       //导航栏的宽度
#define CST_ANIMATION_VIEW_SIZE 128 //动画视图大小

/*字体大小定义*/
#define CSTMENU_FONT_SIZE 16        //字体的大小
#define CSTNAVI_FONT_SIZE 24        //导航栏标题字体大小

/*字体定义*/
#define CST_NAVIGATOR_FONT  @"AmericanTypewriter-Bold"
#define CST_TEXT_FONT       @"ArialUnicodeMS"

/*视图标签定义*/
#define CSTMENU_TABLE_TAG   80001
#define CSTMENU_VIEW_TAG    80002


typedef NS_ENUM(NSUInteger, CSTAnimation){
    CSTAnimationFadeInOut = 0,          //渐入渐出效果
    CSTAnimationTwinkle,                //闪烁
    CSTAnimationMoving,                 //移动
    CSTAnimationBlowUp,                 //放大消失
    CSTAnimationRotate,                 //旋转
    CSTAnimationRotateAndBlowUp,        //旋转放大消失
    CSTAnimationClock,                  //时钟
    CSTAnimationFastRotate,             //快速旋转
    CSTAnimationCount                   //总长度
};

#endif
