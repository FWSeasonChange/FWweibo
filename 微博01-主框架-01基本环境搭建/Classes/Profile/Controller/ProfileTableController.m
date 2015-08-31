//
//  MeTableController.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/18.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "ProfileTableController.h"
#import "FWPopMenu.h"

@implementation ProfileTableController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
}

- (void)setting
{
    UIViewController *two = [[UIViewController alloc]init];
    two.title = @"设置";
//    [self.navigationController pushViewController:two animated:YES];
//    设置下拉菜单
    
    UITableView *tableView = [[UITableView alloc] init];
//    tableView.backgroundColor = [UIColor redColor];
    
    FWPopMenu *menu = [FWPopMenu popMenuWithContentButton:tableView];
    CGFloat menuW = 100;
    CGFloat menuH = 200;
    CGFloat menuY = 55;
    CGFloat menuX = self.view.width - menuW - 20;
    menu.dismissBackground = YES;
    menu.popMenuArrowPostion = FWPopMenuArrowPostionCenter;
    [menu showInRect:CGRectMake(menuX, menuY, menuW, menuH)];
}
@end
