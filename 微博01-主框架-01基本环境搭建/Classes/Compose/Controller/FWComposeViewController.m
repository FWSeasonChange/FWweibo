//
//  FWComposeViewController.m
//  微博01-主框架-01基本环境搭建
//
//  Created by 付玮 on 15/8/22.
//  Copyright (c) 2015年 付玮. All rights reserved.
//

#import "FWComposeViewController.h"
#import "FWTextView.h"
#import "FWComposeToolBar.h"
#import "FWComposePhotosView.h"
#import "FWAccountModel.h"
#import "FWAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "FWHttpTool.h"
#import "AFNetworking.h"

@interface FWComposeViewController ()<FWComposeToolBarDeleagte, UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (nonatomic, weak) FWTextView  *textView;

/**
 *  工具条
 */
@property (nonatomic, weak) FWComposeToolBar *toolBar;

/** 发送图片的View */
@property (nonatomic, weak) FWComposePhotosView *photosView;


@end

@implementation FWComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    设置导航栏
    [self setNavigationBar];
    
//    设置微博输入框
    [self setInputTextView];
    
//    设置工具条
    [self setToolBar];
    
//    设置显示发送图片的View
    [self setPhotosView];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    //    成为第一响应者(只要成为第一响应者就会弹出键盘)
    [self.textView becomeFirstResponder];
}

#pragma mark - FWComposeToolBarDeleagte
- (void)composeToolBar:(FWComposeToolBar *)composeToolBar didClickBtnTag:(FWComposeToolBarButtonType)composeToolBarButtonType;
{
    switch (composeToolBarButtonType) {
        case FWComposeToolBarButtonTypeCamera:
            [self openCamera];
            break;
        case FWComposeToolBarButtonTypeEmotion:
            FWLog(@"点击表情");
            break;
        case FWComposeToolBarButtonTypeMention:
            FWLog(@"点击提到@");
            break;
        case FWComposeToolBarButtonTypePicture:
            [self openPicture];
            break;
        case FWComposeToolBarButtonTypeTrend:
            FWLog(@"点击话题#");
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate
/**
 *  当图片被点击选中后调用的方法
 *  @param info   选中图片的信息的数据字典
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    选中一张图片之后退出相册，回到发微博
    [picker dismissViewControllerAnimated:YES completion:nil];
    
//    拿到选中的图片
    UIImage *selectedImage =info[@"UIImagePickerControllerOriginalImage"];
    
//    放入textView,创建一个专门显示图片的view,设置一个添加图片的方法
    [self.photosView addImage:selectedImage];
}

#pragma mark - UITextViewDelegate
/**
 *  拖动ScrollView调用
 */
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.text.length != 0;
}

#pragma mark - 私有方法
/**
 *  设置导航栏项目
 */
- (void)setNavigationBar
{
    //  左按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cannel)];
    //    右按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    //    发送按钮默认不能用
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    self.title = @"发微博";
    self.view.backgroundColor = [UIColor whiteColor];
}

/**
 *  取消按钮事件
 */
- (void)cannel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发送按钮事件
 */
- (void)send
{
    /*
        判断是否有图片可以判断photosView的子控件个数
     根据封装的思想FWComposePhotosView类提供一个方法返回一个子控件数组提供给外界使用
     */

    if (self.photosView.images.count) {
//        带图的微博
        [self sendStatuesWithImage];
    }
    else
    {
//        不带图的微博
        [self sendStatuesWithoutImage];

    }
    
    //    2.发送完成后关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  发送带有图片的微博
 */
- (void)sendStatuesWithImage
{
    //    1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //    2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [FWAccountTool getAccount].access_token;
    params[@"status"] = self.textView.text;
    
    //    3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
#warning 目前开放的借口只能发送一张图片
        UIImage *image = [self.photosView.images firstObject];
        NSData *data  = UIImageJPEGRepresentation(image, 1.0);
//        拼接文件AF框架方法

        /*
         appendPartWithFileData:本地需要发送的图片转换成的二进制
         name:服务器提供的文件参数名
         fileName:文件名
         */
        [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD showSuccess:@"发送微博成功"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD showError:@"发送微博失败"];

    }];
    

}

/**
 *  发送没有图片的微博
 */
- (void)sendStatuesWithoutImage
{
////    1.获得请求管理者
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    
////    2.封装请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [FWAccountTool getAccount].access_token;
//    params[@"status"] = self.textView.text;
//    
////    3.发送请求
//    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *statusDict) {
//        [MBProgressHUD showSuccess:@"发送微博成功"];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"发送微博失败"];
//    }];
    
    //    2.封装请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"access_token"] = [FWAccountTool getAccount].access_token;
        params[@"status"] = self.textView.text;
    [FWHttpTool post:@"https://api.weibo.com/2/statuses/update.json" params:params success:^(id responseObj) {
                [MBProgressHUD showSuccess:@"发送微博成功"];

    } failure:^(NSError *error) {
                [MBProgressHUD showError:@"发送微博失败"];

    }];
    
}

/**
 *  设置输入微博View
 */
- (void)setInputTextView
{
    /*
     iOS7以后view默认都是全屏的这里的textView点击输入开始输入在navigationBar下面因为，默认设置了64的位置用来显示NavigationBar
     tableView也是一样
     */
    FWTextView *textView = [[FWTextView alloc]init];
    textView.frame = self.view.bounds;
    //    设置提示文字，多提供一个属性可以供外界设置
    textView.placeholder = @"请输入微博内容";
    //    垂直方法向上永远有弹簧效果
    textView.alwaysBounceVertical = YES;
    //    成为第一响应者(只要成为第一响应者就会弹出键盘)在view完全显示后弹出键盘，在ViewDidLoad里面设置会很慢
    //    [textView becomeFirstResponder];
    textView.delegate = self;
    textView.placeholderColor = [UIColor lightGrayColor];
    textView.font = [UIFont systemFontOfSize:14];
    
    [self.view addSubview:textView];
    self.textView = textView;
}

/**
 *  打开相册
 */
- (void)openPicture
{
    //    如果图片源不可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    //    modal
    UIImagePickerController *pic = [[UIImagePickerController alloc]init];
    //    展示的控制器，图片来源
    pic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //    设置代理
    pic.delegate = self;
    [self presentViewController:pic animated:YES completion:nil];
}

/**
 *  打开相机
 */
- (void)openCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    //    modal
    UIImagePickerController *pic = [[UIImagePickerController alloc]init];
    //    展示的控制器,图片来源
    pic.sourceType = UIImagePickerControllerSourceTypeCamera;
    pic.delegate = self;
    [self presentViewController:pic animated:YES completion:nil];
}

//设置显示发送图片的view
- (void)setPhotosView
{
    FWComposePhotosView *photosView = [[FWComposePhotosView alloc]init];
    
    //    photosView.backgroundColor = [UIColor grayColor];
    photosView.x = 0;
    photosView.y = 100;
    photosView.width = self.view.width;
    photosView.height = self.view.height;
    
    [self.textView addSubview:photosView];
    
    self.photosView = photosView;
    
    
}

- (void)keyboardWillchange:(NSNotification *)notification{
    /*
     通知信息
     键盘弹出节奏
     UIKeyboardAnimationCurveUserInfoKey = 7;
     键盘弹出动画时间
     UIKeyboardAnimationDurationUserInfoKey = "0.25";
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 253}}";
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 606.5}";
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 353.5}";
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 480}, {320, 253}}";
     
     键盘弹出时的frame
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 227}, {320, 253}}";
     
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 227}, {320, 253}}";
     
     键盘隐藏式的frame
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 480}, {320, 253}}";
     */
    
    
    //   NSLog(@"键盘将要改变 %@", notification);
    //    键盘弹出时使view向上移动253view上的控件都会上移
    /*
     计算需要移动的距离
     弹出时移动的值 ＝ 键盘的Y值 － view高度
     
     隐藏时移动的值 ＝ 键盘的Y值 － view高度
     
     */
    //    1.获取键盘的Y值
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat keyboadrdY = keyboardRect.origin.y;
    
    //    获取动画执行时间
    CGFloat animationtime = [notification.userInfo [UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    //    2.计算需要移动的距离
    CGFloat translaY = keyboadrdY - self.view.frame.size.height;
    [UIView animateWithDuration:animationtime delay:0.0 options:7 << 16 animations:^{
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, translaY);
        
    } completion:^(BOOL finished){
        
    }];
    
    
}

//    设置工具条
- (void)setToolBar
{
    CGFloat toolBarX = 0;
    CGFloat toolBarH = 44;
    CGFloat toolBarY =self.view.height - toolBarH;
    CGFloat toolBarW = self.view.width;
    FWComposeToolBar *toolBar = [[FWComposeToolBar alloc]initWithFrame:CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH)];
    toolBar.delegate = self;
    
    [self.view addSubview:toolBar];
    
    self.toolBar = toolBar;
    
    //    监听键盘
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillchange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)dealloc
{
#warning 必须要移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
