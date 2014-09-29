//
//  ViewController.m
//  AnimationDemo
//
//  Created by shuting.chen on 14-9-28.
//  Copyright (c) 2014年 Violet Iris. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ViewController
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark public
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configNavibar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark private
-(void)configNavibar
{
    self.navigationItem.titleView = self.titleLabel;
    
//    self.navigationItem.rightBarButtonItem = ;
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark accessor
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        _titleLabel.text = @"动画效果";
    }
    return _titleLabel;
}

@end
