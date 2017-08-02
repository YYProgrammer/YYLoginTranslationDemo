//
//  UIView+XMGExtension.h
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YYExtension)
@property (nonatomic, assign) CGSize yy_size;
@property (nonatomic, assign) CGFloat yy_width;
@property (nonatomic, assign) CGFloat yy_height;
@property (nonatomic, assign) CGFloat yy_x;
@property (nonatomic, assign) CGFloat yy_y;
@property (nonatomic, assign) CGFloat yy_centerX;
@property (nonatomic, assign) CGFloat yy_centerY;

//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/** 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量*/
@end
