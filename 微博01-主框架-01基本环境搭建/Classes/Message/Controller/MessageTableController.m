//
//  messageTableController.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/18.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "MessageTableController.h"

@implementation MessageTableController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    需要写私信的文字颜色变成橙色，可以用button代替或者设置navigationItem的主题
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(write)];

}
- (void)write
{
    self.navigationItem.rightBarButtonItem.enabled = NO;

}

#pragma mark - UITableViewDataSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

#pragma mark - UItableViewDelegate
/**
 *  设置tableView内容
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NSString *str = [NSString stringWithFormat:@"消息测试数据--%lu", (long)indexPath.row];
    cell.textLabel.text = str;
    return cell;
}

/**
 *  点击cell触发的方法
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor redColor];
    vc.title = @"消息新控制器";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
