//
//  discoverViewController.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/18.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "DiscoverViewController.h"
#import "FWSearchBar.h"

@implementation DiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    自定义搜索框，也可以用分类实现，但是分类是UITextFiled的分类，做一个搜索框，不太好，所以写一个FWSearchBar类继承自UITextFiled，更加明了
    FWSearchBar *searchBar = [FWSearchBar searchBar];
//    宽
    searchBar.width = 300;
//    高
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;
    
}

#pragma mark - UITableViewDataSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 16;
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
    NSString *str = [NSString stringWithFormat:@"发现测试数据--%lu", indexPath.row];
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
    vc.title = @"发现新控制器";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
