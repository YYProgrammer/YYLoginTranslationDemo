//
//  YYFirstViewController.h
//  YYDemo
//
//  Created by yy on 2017/7/31.
//  Copyright © 2017年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYAddView.h"

@interface YYFirstViewController : UIViewController

//导航栏
@property (nonatomic,strong) UIView *navView;
//导航栏上面的文字
@property (nonatomic,strong) UILabel *navWord;
//加号按钮
@property (nonatomic,strong) YYAddView *addView;
//背景
@property (nonatomic,strong) UIImageView *backImage;

@end
