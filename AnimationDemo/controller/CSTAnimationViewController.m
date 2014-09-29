//
//  CSTViewController.m
//  AnimationDemo
//
//  Created by shuting.chen on 14-9-28.
//  Copyright (c) 2014年 Violet Iris. All rights reserved.
//

#import "CSTAnimationViewController.h"
#import "CSTMenuTableView.h"
#import "CSTAnimationCollection.h"

#define CSTMENU_VIEW_WIDTH 120       //动画选择下拉菜单宽度

@interface CSTAnimationViewController () <UINavigationBarDelegate>
{
    BOOL isPlaying;
    NSInteger currentChoice;
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *menuButton;
@property (nonatomic, strong) UIBarButtonItem *playButton;
@property (nonatomic, strong) UIBarButtonItem *pauseButton;

@property (nonatomic, strong) CSTMenuTableView *menuView;

@property (nonatomic, strong) CSTAnimationCollection *animationCollections;
@property (nonatomic, strong) NSTimer *timer;           //定时器1
@property (nonatomic, strong) CADisplayLink *display;   //定时器2
@end

@implementation CSTAnimationViewController
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark public
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configNavibar];
    
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.animationView];
    isPlaying = NO;
    currentChoice = CSTAnimationCount;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)animationChanged:(CSTAnimation)animationType
{
    currentChoice = animationType;
    [self updateMenuButtonTitle:self.dataModel.menuData[animationType]];
    [self stopAnimation];
    [self startOrStopAnimation];
}


-(void)restoreAnimationView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:[self.animationCollections timeInterval:CSTAnimationFadeInOut]];
    self.animationView.hidden = NO;
    CGRect frame = CGRectMake((CST_SCREEN_WIDTH - CST_ANIMATION_VIEW_SIZE) * 0.5,
                              (CST_SCREEN_HEIGHT - CST_ANIMATION_VIEW_SIZE - CST_NAVIBAR_HEIGHT) *0.5,
                              CST_ANIMATION_VIEW_SIZE, CST_ANIMATION_VIEW_SIZE);
    self.animationView.frame = frame;
    self.animationView.alpha = 1;
    self.animationView.transform = CGAffineTransformMakeRotation(0);
    [UIView commitAnimations];
}


////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark private
-(void)configNavibar
{
    /*标题*/
    [self.navigationItem setTitleView:self.titleLabel];
    
    self.navigationItem.leftBarButtonItem = self.playButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:self.menuButton];
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void)updateMenuButtonTitle:(NSString *)title
{
    [self.menuButton setTitle:title forState:UIControlStateNormal];
}


-(void)startAnimation:(CSTAnimation)animationType
{
    self.navigationItem.leftBarButtonItem = self.pauseButton;
    isPlaying = YES;

    //*恢复视图的初始状态*/
    if (animationType != CSTAnimationMoving) {
        [self restoreAnimationView];
    }
    
    if (animationType == CSTAnimationRotate) {
        [self addDisplayLink:animationType];
    } else {
        [self addTimerToAnimationView:animationType];
    }
}

-(void)stopAnimation{
    self.navigationItem.leftBarButtonItem = self.playButton;
    isPlaying = NO;
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    if (self.display) {
        [self.display invalidate];
        self.display = nil;
    }

}

-(void)addDisplayLink:(CSTAnimation)animationType
{
    if (self.display == nil) {
        SEL animationSelection = [self.animationCollections getAnimationSEL:animationType];
        CADisplayLink *display = [CADisplayLink displayLinkWithTarget:self.animationCollections
                                                            selector:animationSelection];
        self.display = display;
        [display addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
}

-(void)addTimerToAnimationView:(CSTAnimation)animationType
{
    SEL animationSelector = [self.animationCollections getAnimationSEL:animationType];
    float timeInterval = [self.animationCollections timeInterval:animationType];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                  target:self.animationCollections
                                                selector:animationSelector
                                                userInfo:nil
                                                 repeats:YES];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - actions
-(void)startOrStopAnimation
{
    if (isPlaying) {    //停止动画
        [self stopAnimation];
    } else {            //启动动画
        [self startAnimation:currentChoice];
    }
}

-(void)menuButtonClicked:(id)sender
{
    self.menuView.dataModel = self.dataModel;
    [self.menuView showMenu];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Accesor
-(CSTAnimationModel *)dataModel
{
    if (!_dataModel) {
        _dataModel = [[CSTAnimationModel alloc] init];
    }
    return _dataModel;
}

#pragma mark - Private Accessor
-(UIButton *)menuButton
{
    if (!_menuButton) {
        CGRect frame = CGRectMake(CST_SCREEN_WIDTH - CSTMENU_VIEW_WIDTH, 0,
                                  CSTMENU_VIEW_WIDTH, CSTMENU_FONT_SIZE);
        _menuButton = [[UIButton alloc] initWithFrame:frame];
        
        [_menuButton setTitle:@"Choose" forState:UIControlStateNormal];
        [_menuButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_menuButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        
        _menuButton.titleLabel.font = [UIFont fontWithName:CST_TEXT_FONT
                                                      size:CSTMENU_FONT_SIZE];
        
        [_menuButton addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _menuButton;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((CST_SCREEN_WIDTH - 100) * 0.5, 0, 100, 20)];
        _titleLabel.text = @"Animation";
        _titleLabel.font = [UIFont fontWithName:CST_NAVIGATOR_FONT size:CSTNAVI_FONT_SIZE];
        _titleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:211 alpha:1];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(CSTMenuTableView *)menuView
{
    if (!_menuView) {
        CGRect frame = CGRectMake(self.menuButton.frame.origin.x, CST_NAVIBAR_HEIGHT,
                                  CSTMENU_VIEW_WIDTH, CST_SCREEN_HEIGHT - CST_NAVIBAR_HEIGHT);
        _menuView = [[CSTMenuTableView alloc] initWithFrame:frame];
        [_menuView setHidden:YES];
        _menuView.viewController = self;
        _menuView.tag = CSTMENU_VIEW_TAG;
    }
    return _menuView;
}

-(UIImageView *)animationView
{
    if (!_animationView) {
        CGRect frame = CGRectMake((CST_SCREEN_WIDTH - CST_ANIMATION_VIEW_SIZE) * 0.5,
                                  (CST_SCREEN_HEIGHT - CST_ANIMATION_VIEW_SIZE - CST_NAVIBAR_HEIGHT) *0.5,
                                  CST_ANIMATION_VIEW_SIZE, CST_ANIMATION_VIEW_SIZE);
        _animationView = [[UIImageView alloc] initWithFrame:frame];
        
        [_animationView setImage:[UIImage imageNamed:@"cst_monster_img"]];
    }
    return _animationView;
}

-(CSTAnimationCollection *)animationCollections
{
    if (!_animationCollections) {
        _animationCollections = [[CSTAnimationCollection alloc] init];
        _animationCollections.viewController = self;
    }
    return _animationCollections;
}

-(UIBarButtonItem *)playButton
{
    if (!_playButton) {
        _playButton = [[UIBarButtonItem alloc]
                        initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                        target:self
                        action:@selector(startOrStopAnimation)];
    }
    return _playButton;
}

-(UIBarButtonItem *)pauseButton
{
    if (!_pauseButton) {
        _pauseButton = [[UIBarButtonItem alloc]
                        initWithBarButtonSystemItem:UIBarButtonSystemItemPause
                        target:self
                        action:@selector(startOrStopAnimation)];
    }
    return _pauseButton;
}

@end
