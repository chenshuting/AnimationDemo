//
//  CSTMenuTableView.m
//  AnimationDemo
//
//  Created by 溸馨 on 14-9-28.
//  Copyright (c) 2014年 Violet Iris. All rights reserved.
//

#import "CSTMenuTableView.h"
#import "CSTGlobal.h"

#define CSTMENU_CELL_HEIGHT 30

@interface CSTMenuTableView() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *menuTable;
@end

@implementation CSTMenuTableView
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Initialize
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.menuTable.delegate = self;
    self.menuTable.dataSource = self;
    [self addSubview:self.menuTable];
    
    return self;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public
/**
 *  下降渐入渐出效果
 */
-(void)showMenu
{
    __weak UITableView *weakTableView = self.menuTable;
    float timeInterval = 0.1 * self.dataModel.menuData.count;
    
    [self.menuTable setContentOffset:CGPointMake(0, 0)];
    [self setHidden:NO];
    self.menuTable.alpha = 0;
    
    [UIView animateWithDuration:timeInterval animations:^{
        CGRect frame = CGRectMake(0, 0, weakTableView.frame.size.width,
                                  weakTableView.frame.size.height);
        weakTableView.frame = frame;
        weakTableView.alpha = 1;
    }];
}

/**
 *  上升渐入渐出效果
 */
-(void)hideMenu
{
    __weak UITableView *weakTableView = self.menuTable;
    __weak CSTMenuTableView *weakSelf = self;
    float timeInterval = 0.1 * self.dataModel.menuData.count;
    
    __block float height = [self menuTableHeight];
    [UIView animateWithDuration:timeInterval animations:^{
        weakTableView.frame = CGRectMake(0, -height, weakSelf.frame.size.width, height);
        [weakTableView setAlpha:0];
    }];
//    [self setHidden:YES];
//    [weakTableView setHidden:YES];
}
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private
-(float)menuTableHeight
{
    float realHeight = self.dataModel.menuData.count * CSTMENU_CELL_HEIGHT;
    float height = realHeight < self.frame.size.height ?
    realHeight : self.frame.size.height;
    
    return height;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Accessor
-(void)setDataModel:(CSTAnimationModel *)dataModel
{
    _dataModel = dataModel;
    
    [self.menuTable reloadData];
    
    /*设置tableView的frame*/
    float height = [self menuTableHeight];
    float y = 0; //即将使tableView消失
    if (self.menuTable.alpha == 0) { //即将显示tableView
        y = -height;
    }
    CGRect frame = CGRectMake(0, y, self.frame.size.width, height);
    [self.menuTable setFrame:frame];
}

#pragma mark - Private Accessor
-(UITableView *)menuTable
{
    if (!_menuTable) {
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _menuTable = [[UITableView alloc] initWithFrame:frame
                                                  style:UITableViewStylePlain];
        [_menuTable setBackgroundColor:[UIColor blueColor]];
        _menuTable.tag = CSTMENU_VIEW_TAG;
        _menuTable.alpha = 0;
    }
    return _menuTable;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataModel.menuData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"menuCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) { //cell为空
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:cellIdentifier];
    }
    
    //设置cell数据
    cell.textLabel.text = self.dataModel.menuData[indexPath.row];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.textLabel setHighlightedTextColor:[UIColor yellowColor]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:CSTMENU_FONT_SIZE]];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hideMenu];
    [self.viewController animationChanged:indexPath.row];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CSTMENU_CELL_HEIGHT;
}

@end
