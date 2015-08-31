//
//  homeViewController.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/18.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "HomeViewController.h"
#import "TitleButton.h"
#import "FWPopMenu.h"
#import "FWAccountTool.h"
#import "UIImageView+WebCache.h"
#import "FWStatesModel.h"
#import "FWUserModel.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"
#import "FWFooterView.h"
#import "FWHttpTool.h"

@interface HomeViewController ()<FWPopMenuelegate>

@property (nonatomic, strong) NSMutableArray  *statuses;

@property (nonatomic, strong) UIButton *titleBtn;

@end

@implementation HomeViewController
#pragma mark - lazyLoad
- (NSMutableArray *)statuses
{
    if (_statuses== nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置导航栏Navigation
    [self setupNavigation];
    
    //    集成刷新控件
    [self setupRefresh];
    
    //    获取用户信息
    [self getUserInfo];
    
}

- (void)getUserInfo
{
    //    //    1.获得请求管理者
    //    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //
    //    //    2.封装请求参数
    //    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    params[@"access_token"] = [FWAccountTool getAccount].access_token;
    //    params[@"uid"] = [FWAccountTool getAccount].uid;
    //
    //    //    3.发送请求
    //    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *statusDict) {
    //        FWLog(@"%@", statusDict);
    //        //        字典转模型
    //        FWUserModel *user = [FWUserModel objectWithKeyValues:statusDict];
    //        //        设置首页标题为用户名
    //        [self.titleBtn setTitle:user.name forState:UIControlStateNormal];
    //        /*
    //         获取到用户名后，下一次启动程序应该显示用户名，保存用户名到沙盒，可以在账号模型存储在沙盒在账号模型里面加上一个name保存最新用户名
    //         */
    //        //        存储账号用户名
    //        FWAccountModel *account = [FWAccountTool getAccount];
    //        account.name = user.name;
    //        [FWAccountTool saveAccount:account];
    //
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        [MBProgressHUD showError:@"用户信息获取失败"];
    //    }];
    
    //    1..封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [FWAccountTool getAccount].access_token;
    params[@"uid"] = [FWAccountTool getAccount].uid;
    
    //    2.发送请求
    [FWHttpTool get:@"https://api.weibo.com/2/users/show.json" params:params success:^(id respoenObj) {
        //        字典转模型
        FWUserModel *user = [FWUserModel objectWithKeyValues:respoenObj];
        //        设置首页标题为用户名
        [self.titleBtn setTitle:user.name forState:UIControlStateNormal];
        /*
         获取到用户名后，下一次启动程序应该显示用户名，保存用户名到沙盒，可以在账号模型存储在沙盒在账号模型里面加上一个name保存最新用户名
         */
        //        存储账号用户名
        FWAccountModel *account = [FWAccountTool getAccount];
        account.name = user.name;
        [FWAccountTool saveAccount:account];
        
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"用户信息获取失败"];
        
    }];
    
}
/**
 *  添加下拉刷新控件
 */
- (void)setupRefresh
{
    
    /*
     想要监听控件的事件第一系那个到用代理，第二用addTarget方法此方法属于UIControl看空间是否继承自UIControl
     */
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:refreshControl];
    
    //    监听刷新控件事件,只有手动下拉刷新才会触发[refreshControl beginRefreshing]不会触发
    [refreshControl addTarget:self action:@selector(refershStates:) forControlEvents:UIControlEventValueChanged];
    
    [refreshControl beginRefreshing];
    
    //    主动调用下拉刷新方法
    [self refershStates:refreshControl];
    
    //    设置footerView，
    /*
     第一次进入是刚显示TableView没有数据就会有tableFooterView，第一次显示tableView回去调用代理方法,我们可以在设置tableView的cell的行数方法里设置为没有数据就是数据为0行时隐藏
     */
    self.tableView.tableFooterView = [FWFooterView footerView];
    
    
}

/**
 *  下拉刷新
 */
- (void)refershStates:(UIRefreshControl *)refreshControl
{
    //    /**
    //     *  不能直接调用请求加载微博数据，调用加载方法会重新加载20条数据覆盖原来的数据，而需求是加载相对于当前数据的最新数据在原数据之上，这样省流量
    //     */
    //
    //    /* since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。新浪为每条微博都设置了一个since_id越新的微博since_id越大
    //     max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
    //     */
    //    //    1.获得请求管理者
    //    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //
    //    //    2.封装请求参数
    //    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    params[@"access_token"] = [FWAccountTool getAccount].access_token;
    //    //        获取目前的第一条微博,这里不要用0可能会数组越界，如果数组为空就会越界
    //    FWStatesModel *fristStates = [self.statuses firstObject];
    //    if (fristStates) {
    //        params[@"since_id"] = fristStates.idstr;
    //    }
    //
    //    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *resultDict) {
    //        //        self.statuses = [NSMutableArray array];
    //        //        拿到请求出来的数据赋值给本地数组保存
    //        NSArray *statuses = resultDict[@"statuses"];
    //
    //        //          将statuses全是字典的数组转换全是FWStatesModel模型的数组
    //        NSArray *newStates = [FWStatesModel objectArrayWithKeyValuesArray:statuses];
    //
    //        //        将新数据插入到旧数组中
    //        /*
    //         atIndexes:需要插入数据的范围，就是需要插入多少条数据
    //         */
    //        NSRange range = NSMakeRange(0, newStates.count);
    //        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
    //        [self.statuses insertObjects:newStates atIndexes:indexSet];
    //        /*此方法是将整个object对象插入到self.statuses数组的index位置就是数组里有数组
    //         self.statuses insertObject:<#(id)#> atIndex:<#(NSUInteger)#>
    //         */
    //        //      有数据，接收好数据后需要刷新
    //        [self.tableView reloadData];
    //
    //        //        提示刷新后的数据状态
    //        [self showNewStatesCount:newStates.count];
    //
    //        //         告诉控件停止刷新，会停止动画，恢复默认状态
    //        [refreshControl endRefreshing];
    //
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        FWLog(@"请求失败---%@", error);
    //
    //        [refreshControl endRefreshing];
    //    }];
    
    
    //    1..封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [FWAccountTool getAccount].access_token;
    //        获取目前的第一条微博,这里不要用0可能会数组越界，如果数组为空就会越界
    FWStatesModel *fristStates = [self.statuses firstObject];
    if (fristStates) {
        params[@"since_id"] = fristStates.idstr;
    }
    
    //    2.发送请求
    [FWHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id respoenObj) {
        //        拿到请求出来的数据赋值给本地数组保存
        NSArray *statuses = respoenObj[@"statuses"];
        
        //          将statuses全是字典的数组转换全是FWStatesModel模型的数组
        NSArray *newStates = [FWStatesModel objectArrayWithKeyValuesArray:statuses];
        
        //        将新数据插入到旧数组中
        NSRange range = NSMakeRange(0, newStates.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStates atIndexes:indexSet];
        //      有数据，接收好数据后需要刷新
        [self.tableView reloadData];
        
        //        提示刷新后的数据状态
        [self showNewStatesCount:newStates.count];
        
        //         告诉控件停止刷新，会停止动画，恢复默认状态
        [refreshControl endRefreshing];
        
    } failure:^(NSError *error) {
        
        FWLog(@"请求失败---%@", error);
        
        [refreshControl endRefreshing];
    }];
    
}
/**
 * 提示微博刷新数据条数
 */
- (void)showNewStatesCount:(NSInteger )count
{
    //    1.创建一个label
    UILabel *label = [[UILabel alloc]init];
    if (count) {
        label.text = [NSString stringWithFormat:@"刷新了%lu条数据", (long)count];
    }
    else
    {
        label.text = @"没有新数据";
    }
    
    
    CGFloat labelX = 0;
    CGFloat labelH = 25;
    CGFloat labelY = 64 - labelH;
    CGFloat labelW = self.view.width;
    label.frame = CGRectMake(labelX, labelY, labelW, labelH);
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    //    做动画
    CGFloat duration = 1.0;
    //    淡进淡出
    label.alpha = 0.0;
    [UIView animateWithDuration:duration animations:^{
        //        label在Translation后实际位置并没有改变，只是我们看到的变了，当需要会原位就用transform，而不是y增加
        label.transform = CGAffineTransformMakeTranslation(0, labelH);
        label.alpha = 1.0;
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0;
        
        /*动画状态默认为第一个
         UIViewAnimationOptionCurveEaseInOut            = 0 << 16, 慢快慢
         UIViewAnimationOptionCurveEaseIn               = 1 << 16, 加速动画
         UIViewAnimationOptionCurveEaseOut              = 2 << 16, 减速动画
         UIViewAnimationOptionCurveLinear               = 3 << 16, 动画匀速
         */
        
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //            清空单位矩阵，清空位移量，就是回原位
            label.transform = CGAffineTransformIdentity;
            label.alpha = 0.0;
        } completion:^(BOOL finished) {
            
            [label removeFromSuperview];
        }];
        
        
    }];
    
}


/**
 *  请求加载新微博数据
 */
- (void)loadNewStates
{
    
    //    //    1.获得请求管理者
    //    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //
    //    //    2.封装请求参数
    //    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    params[@"access_token"] = [FWAccountTool getAccount].access_token;
    //    //    包装成对象@1
    //    params[@"count"] = @20;
    //
    //
    //    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *resultDict) {
    //        //        self.statuses = [NSMutableArray array];
    //        //        拿到请求出来的数据赋值给本地数组保存
    //        NSArray *statuses = resultDict[@"statuses"];
    //
    //        //          将statuses全是字典的数组转换全是FWStatesModel模型的数组
    //        self.statuses = [FWStatesModel objectArrayWithKeyValuesArray:statuses];
    //
    //        ////      遍历得到的数组
    //        //        for (NSDictionary *statuesDict in statuses) {
    //        ////            字典转模型
    //        //            FWStatesModel *status = [FWStatesModel objectWithKeyValues:statuesDict];
    //        ////            将模型加入数组
    //        //            [self.statuses addObject:status];
    //        //
    //        //        }
    //
    //        //        最开始没有数据，接收好数据后需要刷新
    //        [self.tableView reloadData];
    //
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        FWLog(@"请求失败---%@", error);
    //
    //    }];
    
    
    //    2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [FWAccountTool getAccount].access_token;
    [FWHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" params:params success:^(id respoenObj) {
        self.statuses = [NSMutableArray array];
        //        拿到请求出来的数据赋值给本地数组保存
        NSArray *statuses = respoenObj[@"statuses"];
        
        //          将statuses全是字典的数组转换全是FWStatesModel模型的数组
        self.statuses = [FWStatesModel objectArrayWithKeyValuesArray:statuses];
        
        //        最开始没有数据，接收好数据后需要刷新
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        FWLog(@"请求失败---%@", error);
        
    }];
    
}

/**
 *  设置导航栏Navigation
 */
- (void)setupNavigation
{
    //左按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barBtnWithImageName:@"navigationbar_friendsearch" highImageName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendsearch)];
    //    右按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barBtnWithImageName:@"navigationbar_pop" highImageName:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    //    默认图片在左边文字在右边，想要图片在右边，自定义按钮,死的属性可以放入初始化方法
    //    首页按钮
    TitleButton *btn = [[TitleButton alloc]init];
    //    按钮的宽度根据文字的宽度和图片的宽度决定，到setTitle方法里可以获取到最新的文字
    //    btn.width = 100;
    btn.height = 40;
    //    按钮文字,三目运算
    NSString *name = [FWAccountTool getAccount].name;
    [btn setTitle:name ? name : @"首页" forState:UIControlStateNormal];
    //    图片
    [btn setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    //    背景图片
    [btn setBackgroundImage:[UIImage imageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    
    [btn addTarget:self action:@selector(titleBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btn;
    
    self.titleBtn = btn;
}
/**
 *  实现代理方法
 */
- (void)popMenuDidDismissed:(FWPopMenu *)popmenu
{
    //    取出原来的titltView
    TitleButton *titleButton = (TitleButton *)self.navigationItem.titleView;
    //    设置回原来的图片
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
}

/**
 *  按钮
 */
- (void)titleBtn:(UIButton *)btn
{
    //        点击按钮图片向上
    [btn setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    
    //   创建按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    FWPopMenu *popMenu = [[FWPopMenu alloc]initWithContentButton:button];
    //    设置图片，可以多种状态选择
    popMenu.popMenuArrowPostion = FWPopMenuArrowPostionCenter;
    //     时候设置背景变灰，可以多种状态选择
    popMenu.dismissBackground = YES;
    //    设置代理
    popMenu.delegate = self;
    
    [popMenu showInRect:CGRectMake(100, 100, 200, 100)];
    
}
- (void)btnClick:(UIButton *)btn
{
    FWLog(@"btnClick");
}
- (void)friendsearch
{
    UIViewController *one = [[UIViewController alloc]init];
    one.title = @"one";
    [self.navigationController pushViewController:one animated:YES];
}
- (void)pop
{
    FWLog(@"right-pop");
}

#pragma mark - UITableViewDataSource
/**
 *  设置tableView的行数
 */
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    也可以再其他代理方法中设置，显示tableView就会询问调用代理方法，此时没有数据，当请求数据后reloadData就会再次调用代理方法
    tableView.tableFooterView.hidden = self.statuses.count == 0;
    return self.statuses.count;
}

#pragma mark -	 UItableViewDelegate
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
    //    取出对应行的数据，plist文件中为字典
    FWStatesModel *status = [FWStatesModel objectWithKeyValues:self.statuses[indexPath.row]];
    //    新浪返回的JSON文件用户信息为一个字典
    FWUserModel *user = status.user;
    
    //    取出文本数据设置正文
    cell.textLabel.text = status.text;
    
    //    设置用户名字
    cell.detailTextLabel.text = user.name;
    
    //    设置头像，图片一多就需要释放内存在APPDelegate的内存警告方法写
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    
    return cell;
}
/**
 *  点击cell触发的方法
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.title = @"首页新控制器";
    [self.navigationController pushViewController:vc animated:YES];
}
@end
