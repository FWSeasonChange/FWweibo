//
//  下拉刷新.h
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/28.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

想要监听控件的事件第一系那个到用代理，第二用addTarget方法此方法属于UIControl看空间是否继承自UIControl

提示新微博条数
可以通过MBProgressHUD实现提示但是不好看，需要做成官方那样的
思考：
1.可以显示文字的控件有UILael，UIButton等这里只需要显示文字不需要点击用UILabel就可以了
2.添加到哪里，如果添加到tableView就会随着tableView滚动不行，靠近navigationController就可以添加到navigationController的view，尝试
3.动画label从上至下显示出来，又按原来的的回去隐藏，完全回去之后销毁，将label添加到navigationController的NavigationBar的后面
//将label添加到self.navigationController.view的navigationBar后面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
navigationController的结构看官方文档
4.回到原处
//            清空单位矩阵，清空位移量，就是回原位
label.transform = CGAffineTransformIdentity;

/*
 第一次进入是刚显示TableView没有数据就会有tableFooterView，第一次显示tableView回去调用代理方法,我们可以在设置tableView的cell的行数方法里设置为没有数据就是数据为0行时隐藏
 */

// 也可以再其他代理方法中设置，显示tableView就会询问调用代理方法，此时没有数据，当请求数据后reloadData就会再次调用代理方法
