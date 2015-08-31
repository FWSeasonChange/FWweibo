一、黑马微博 ---> 用户的微博数据
1.成为新浪的开发者（加入新浪微博的开发阵营）
* 注册一个微博帐号，登录http://open.weibo.com
帐号：643055866@qq.com
密码：ios4762450
* 填写开发者的个人信息（比如姓名、出生日期、上传身份证）

2.创建应用
* 假设应用名称叫做“黑马微博”
* 应用创建完毕，默认就进入“开发”阶段，就具备了授权的资格
* 应用相关数据
App Key：3141202626 // 应用的唯一标识
App Secret：ee9de4d2431be061b22fe328332a5228
Redirect URI：http://www.itheima.com

3.用户对“黑马微博”进行资源授权----OAuth授权2.0
1> 获取未授权的Request Token ： 展示服务器提供商提供的登录页面
* URL : https://api.weibo.com/oauth2/authorize
* 参数
client_id 	true 	string 	申请应用时分配的AppKey // 得知道给哪个应用授权
redirect_uri 	true 	string 	授权回调地址 // 授权成功后跳转到哪个页面

2> 获取授权过的Request Token
* 授权成功后，自动跳转到回调页面，比如
http://www.itheima.com/?code=eabdc03cc4cc51484111b1cfd9c4cd0b
// 新浪会在回调页面后面拼接一个参数：授权成功后的Request Token

3> 根据授权过的Request Token换取一个Access Token
* URL : https://api.weibo.com/oauth2/access_token
* 参数
client_id 	true 	string 	申请应用时分配的AppKey。
client_secret 	true 	string 	申请应用时分配的AppSecret。
grant_type 	true 	string 	请求的类型，填写authorization_code
code 	true 	string 	调用authorize获得的code值。
redirect_uri 	true 	string 	回调地址，需需与注册应用里的回调地址一致
* 返回结果
{
    "access_token" = "2.00vWf4GEUSKa7D739148f7608SXA9B";
    "expires_in" = 157679999;
    "remind_in" = 157679999;
    uid = 3758830533;
}
// uid == user_id == 当前登录用户的ID   == 用户的唯一标识

{
    "access_token" = "2.00vWf4GEUSKa7D739148f7608SXA9B";
    "expires_in" = 157679999;
    "remind_in" = 157679999;
    uid = 3758830533;
}

* access_token和uid的去呗
access_token : 1个用户给1个应用授权成功后，就获得对应的1个access_token，作用是：允许1个应用访问1个用户的数据
uid:1个用户对应1个uid，每1个用户都有自己唯一的uid
举例：
张三
李四

应用1
应用2

张三给应用1、应用2授权成功了：1个uid、2个access_token
李四给应用2授权成功了：1个uid、1个access_token
上面操作：产生了2个uid，3个access_token

二、授权过程中常见错误：
1.invalid_request
1> 没有传递必填的请求参数
2> 请求参数不对
3> URL中间留有空格

2.invalid_client
1> client_id的值传递错误（AppKey不对）

3.redirect_uri_mismatch
1> 回调地址不对

三、授权帐号注意
1.如果应用还没有经过新浪审核，只能访问自己或者其他15个测试帐号的微博数据