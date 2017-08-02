//
//  YYAddView.m
//  YYDemo
//
//  Created by yy on 2017/7/19.
//  Copyright © 2017年 yy. All rights reserved.
//

#import "YYAddView.h"

#define MAIN_COLOR [UIColor colorWithRed:156/255.0 green:197/255.0 blue:251/255.0 alpha:1.0]

@implementation YYAddView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGPoint center = CGPointMake(rect.size.width*0.5,rect.size.height*0.5);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:(rect.size.width*0.5 - rect.size.width*0.03) startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    // 添加一根线到圆心
    //    [path addLineToPoint:center];
    
    // 封闭路径，关闭路径：从路径的终点到起点
    //    [path closePath];
    
    //    [path stroke];
    
    [MAIN_COLOR set];
    
    // 填充：必须是一个完整的封闭路径,默认就会自动关闭路径
    [path fill];
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    path1.lineWidth = rect.size.width*0.07;
    [[UIColor whiteColor] set];
    // 设置起点
    [path1 moveToPoint:CGPointMake(rect.size.width*0.25, rect.size.height*0.5)];
    
    // 添加一根线到某个点
    [path1 addLineToPoint:CGPointMake(rect.size.width*0.75, rect.size.height*0.5)];
    
    // 绘制路径
//    [path1 stroke];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    path2.lineWidth = rect.size.width*0.07;
    [[UIColor whiteColor] set];
    // 设置起点
    [path2 moveToPoint:CGPointMake(rect.size.width*0.5, rect.size.height*0.25)];
    
    // 添加一根线到某个点
    [path2 addLineToPoint:CGPointMake(rect.size.width*0.5, rect.size.height*0.75)];
    
    // 绘制路径
//    [path2 stroke];
    [self.layer addSublayer:[self makeShapeLayerWithPath:path1 lineWidth:path1.lineWidth]];
    [self.layer addSublayer:[self makeShapeLayerWithPath:path2 lineWidth:path2.lineWidth]];
    
    self.layer.shadowColor = MAIN_COLOR.CGColor;
    //阴影的透明度
    self.layer.shadowOpacity = 0.5f;
    //阴影的圆角
    self.layer.shadowRadius = 4.0f;
    //阴影偏移量
    self.layer.shadowOffset = CGSizeMake(0,0);
}

- (CAShapeLayer *)makeShapeLayerWithPath:(UIBezierPath *)path lineWidth:(CGFloat)lineWidth
{
    CAShapeLayer *shape=[CAShapeLayer layer];
    shape.lineWidth = lineWidth;
    shape.fillColor = [UIColor clearColor].CGColor;
    shape.strokeColor = [UIColor whiteColor].CGColor;
    shape.lineCap = kCALineCapRound;
    shape.lineJoin = kCALineJoinRound;
    shape.path = path.CGPath;
    
    return shape;
}

@end
