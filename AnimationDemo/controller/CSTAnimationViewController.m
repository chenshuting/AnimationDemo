//
//  CSTViewController.m
//  AnimationDemo
//
//  Created by shuting.chen on 14-9-28.
//  Copyright (c) 2014年 Violet Iris. All rights reserved.
//

#import "CSTAnimationViewController.h"
#import "CSTMenuTableView.h"

#define CSTMENU_VIEW_WIDTH 120       //动画选择下拉菜单宽度

@interface CSTAnimationViewController () <UINavigationBarDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *menuButton;
@property (nonatomic, strong) CSTMenuTableView *menuView;
@property (nonatomic, strong) UIImageView *anmationView;
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
    [self.view addSubview:self.anmationView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)animationChanged:(CSTAnimation)animationType
{
    [self updateMenuButtonTitle:self.dataModel.menuData[animationType]];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark private
-(void)configNavibar
{
    //标题
    [self.navigationItem setTitleView:self.titleLabel];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                   target:self
                                   action:@selector(refreshAnimation:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:self.menuButton];
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void)updateMenuButtonTitle:(NSString *)title
{
    [self.menuButton setTitle:title forState:UIControlStateNormal];
}


#pragma mark - actions
-(void)refreshAnimation:(id)sender
{
    
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

-(UIImageView *)anmationView
{
    if (!_anmationView) {
        CGRect frame = CGRectMake((CST_SCREEN_WIDTH - CST_ANIMATION_VIEW_SIZE) * 0.5,
                                  (CST_SCREEN_HEIGHT - CST_ANIMATION_VIEW_SIZE - CST_NAVIBAR_HEIGHT) *0.5,
                                  CST_ANIMATION_VIEW_SIZE, CST_ANIMATION_VIEW_SIZE);
        _anmationView = [[UIImageView alloc] initWithFrame:frame];
        
        [_anmationView setImage:[UIImage imageNamed:@"cst_monster_img"]];
        _anmationView.hidden = YES;
    }
    return _anmationView;
}

@end
