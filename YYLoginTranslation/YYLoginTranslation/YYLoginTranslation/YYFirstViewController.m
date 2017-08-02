//
//  YYFirstViewController.m
//  YYDemo
//
//  Created by yy on 2017/7/31.
//  Copyright © 2017年 yy. All rights reserved.
//

#import "YYFirstViewController.h"
#import "UIView+YYExtension.h"
#import "YYAddView.h"

#define YYScreenW [UIScreen mainScreen].bounds.size.width
#define YYScreenH [UIScreen mainScreen].bounds.size.height

@interface YYFirstViewController ()

@end

@implementation YYFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUIComponent];
}

/** 初始化UI */
- (void)setupUIComponent
{
    self.backImage.hidden = NO;
    
    self.navView.hidden = NO;
    
    self.addView.hidden = NO;
    
    [self.navView addSubview:self.navWord];
    self.navWord.yy_centerX = self.navView.yy_centerX;
    self.navWord.yy_centerY = self.navView.yy_centerY+10;
}

/** 点击加号按钮 */
- (void)addViewClick
{
    //退回登录页面
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 懒加载
- (UIImageView *)backImage
{
    if (!_backImage)
    {
        _backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backImg.jpg"]];
        [self.view addSubview:_backImage];
        _backImage.frame = CGRectMake(0, 0, YYScreenW, YYScreenH);
    }
    return _backImage;
}

- (UIView *)navView
{
    if (!_navView)
    {
        _navView = [[UIView alloc] init];
        [self.view addSubview:_navView];
        _navView.backgroundColor = [UIColor whiteColor];
        _navView.frame = CGRectMake(0, 0, YYScreenW, 64);
    }
    return _navView;
}

- (UILabel *)navWord
{
    if (!_navWord)
    {
        _navWord = [[UILabel alloc] init];
        _navWord.font =  [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:24.0f];
        _navWord.textColor = [UIColor blackColor];
        _navWord.text = @"YY Anim Demo";
        _navWord.hidden = NO;
        [_navWord sizeToFit];
    }
    return _navWord;
}

- (YYAddView *)addView
{
    if (!_addView) {
        CGFloat bntSize = 44;
        _addView = [[YYAddView alloc] initWithFrame:CGRectMake(0, 0, bntSize, bntSize)];
        [self.view addSubview:_addView];
        _addView.userInteractionEnabled = YES;
        [_addView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addViewClick)]];
        _addView.frame = CGRectMake(YYScreenW-15-bntSize, YYScreenH-15-49-bntSize, bntSize, bntSize);
    }
    return _addView;
}

@end
