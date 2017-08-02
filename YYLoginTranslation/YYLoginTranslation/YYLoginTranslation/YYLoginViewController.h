//
//  YYLoginViewController.h
//  YYDemo
//
//  Created by yy on 2017/7/31.
//  Copyright © 2017年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYLoginViewController : UIViewController

//logo图
@property (nonatomic,strong) UIImageView *LoginImage;
//logo下面的文字
@property (nonatomic,strong) UILabel *LoginWord;
//get按钮
@property (nonatomic,strong) UIButton *GetButton;
//login按钮
@property (nonatomic,strong) UIButton *LoginButton;
//登录时加一个看不见的蒙版，让控件不能再被点击
@property (nonatomic,strong) UIView *HUDView;
//执行登录按钮动画的view (动画效果不是按钮本身，而是这个view)
@property (nonatomic,strong) UIView *LoginAnimView;
//登录转圈的那条白线所在的layer
@property (nonatomic,strong) CAShapeLayer *shapeLayer;
//get按钮动画view
@property (nonatomic,strong) UIView *animView;
//账号输入框
@property (nonatomic,strong) UITextField *userTextField;
//密码输入框
@property (nonatomic,strong) UITextField *passwordTextField;


- (void)reloadView;


@end
