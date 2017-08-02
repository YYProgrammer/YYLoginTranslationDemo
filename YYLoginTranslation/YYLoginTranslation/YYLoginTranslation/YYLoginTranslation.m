//
//  YYLoginTranslation.m
//  YYLoginTranslation
//
//  Created by yy on 2017/7/31.
//  Copyright © 2017年 yy. All rights reserved.
//

#import "YYLoginTranslation.h"
#import "YYLoginViewController.h"
#import "YYFirstViewController.h"
#import "UIView+YYExtension.h"
#import "POP.h"

#define YYScreenW [UIScreen mainScreen].bounds.size.width
#define YYScreenH [UIScreen mainScreen].bounds.size.height

@interface YYLoginTranslation () <CAAnimationDelegate>

//做弧线运动的那个圆
@property (strong, nonatomic)UIView *circularAnimView;

@end

@implementation YYLoginTranslation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.doLogin)//登录转场动画
    {
        //transitionContext:转场上下文
        //转场过程中显示的view，所有动画控件都应该加在这上面
        __block UIView* containerView = [transitionContext containerView];
        //转场的来源控制器
        YYFirstViewController* toVC = (YYFirstViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        //转场去往的控制器
        YYLoginViewController* fromVC = (YYLoginViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        //1、fromVC背景变白 (fromVC.view默认已经加到了containerView中，所以不用再添加)
        [UIView animateWithDuration:0.15 animations:^{
            fromVC.view.backgroundColor = [UIColor whiteColor];
        }completion:^(BOOL finished) {
            [fromVC.view removeFromSuperview];
        }];
        
        //2、账号密码输入框消失
        [containerView addSubview:fromVC.userTextField];
        [containerView addSubview:fromVC.passwordTextField];
        
        [UIView animateWithDuration:0.1 animations:^{
            fromVC.userTextField.alpha = 0.0;
            fromVC.passwordTextField.alpha = 0.0;
        }];
        
        //3、logo图片移动消失
        [containerView addSubview:fromVC.LoginImage];
        
        [UIView animateWithDuration:0.15 delay:0.15 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            fromVC.LoginImage.alpha = 0.0;
        } completion:^(BOOL finished) {
            
        }];
        
        //4、logo文字缩小、移动
        [containerView addSubview:fromVC.LoginWord];
        
        CGFloat proportion = toVC.navWord.yy_width / fromVC.LoginWord.yy_width;
        CABasicAnimation * LoginWordScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        LoginWordScale.fromValue = [NSNumber numberWithFloat:1.0];
        LoginWordScale.toValue = [NSNumber numberWithFloat:proportion];
        LoginWordScale.duration = 0.4;
        LoginWordScale.beginTime = CACurrentMediaTime()+0.15;
        LoginWordScale.removedOnCompletion = NO;
        LoginWordScale.fillMode = kCAFillModeForwards;
        [fromVC.LoginWord.layer addAnimation:LoginWordScale forKey:LoginWordScale.keyPath];
        CGPoint newPosition = [toVC.view convertPoint:toVC.navWord.center fromView:toVC.navView];
        
        [UIView animateWithDuration:0.4 delay:0.15 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            fromVC.LoginWord.yy_centerX = newPosition.x;
            fromVC.LoginWord.yy_centerY = newPosition.y;
        } completion:^(BOOL finished) {
            
        }];

        //5、圆(登录加载的那个圆)的移动，因为登录页面的那个圆有正在动的sublayer，所以这里新建了个圆来做动画
        UIView *circularAnimView = [[UIView alloc] initWithFrame:fromVC.LoginAnimView.frame];
        self.circularAnimView = circularAnimView;
        circularAnimView.layer.cornerRadius = circularAnimView.yy_width*0.5;
        circularAnimView.layer.masksToBounds = YES;
        circularAnimView.frame = fromVC.LoginAnimView.frame;
        circularAnimView.backgroundColor = fromVC.LoginAnimView.backgroundColor;
        self.circularAnimView = circularAnimView;
        [containerView addSubview:circularAnimView];
        [fromVC.LoginAnimView removeFromSuperview];
        
        CGFloat bntSize = 44;
        fromVC.LoginAnimView.layer.cornerRadius = bntSize*0.5;
        CGFloat originalX = toVC.view.yy_width-bntSize-15;
        CGFloat originalY = toVC.view.yy_height-bntSize-15-49;
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, (circularAnimView.yy_x+circularAnimView.yy_width*0.5), (circularAnimView.yy_y+circularAnimView.yy_height*0.5));
        CGPathAddQuadCurveToPoint(path, NULL, YYScreenW*0.9, circularAnimView.yy_y+circularAnimView.yy_height, (originalX+circularAnimView.yy_width*0.5), (originalY+circularAnimView.yy_height*0.5));
        CAKeyframeAnimation *animate = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animate.delegate = self;
        animate.duration = 0.4;
        animate.beginTime = CACurrentMediaTime()+0.15;
        animate.fillMode = kCAFillModeForwards;
        animate.repeatCount = 0;
        animate.path = path;
        animate.removedOnCompletion = NO;
        CGPathRelease(path);
        [circularAnimView.layer addAnimation:animate forKey:@"circleMoveAnimation"];
        
        //导航栏出现
        UIView *navView = [[UIView alloc] init];
        navView.frame = toVC.navView.frame;
        navView.backgroundColor = toVC.navView.backgroundColor;
        [containerView insertSubview:navView atIndex:1];
        navView.alpha = 0.0;
        [UIView animateWithDuration:0.6 delay:0.15 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            navView.alpha = 1.0;
        } completion:^(BOOL finished) {
            
        }];
        
        //背景出现、移动
        UIImageView *backImage = [[UIImageView alloc] init];
        backImage.image = toVC.backImage.image;
        backImage.frame = toVC.backImage.frame;
        [containerView insertSubview:backImage atIndex:1];
        backImage.alpha = 0.0;
        backImage.yy_y += 100;
        
        POPSpringAnimation *backImageMove = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        backImageMove.fromValue = [NSValue valueWithCGRect:CGRectMake(backImage.yy_centerX, backImage.yy_centerY, backImage.yy_width, toVC.backImage.yy_height)];
        backImageMove.toValue = [NSValue valueWithCGRect:CGRectMake(backImage.yy_centerX, backImage.yy_centerY-100, backImage.yy_width, backImage.yy_height)];
        backImageMove.beginTime = CACurrentMediaTime()+0.15+0.2;
        backImageMove.springBounciness = 5.0;
        backImageMove.springSpeed = 10.0;
        [backImage pop_addAnimation:backImageMove forKey:nil];
        
        [UIView animateWithDuration:0.6 delay:0.15+0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            backImage.alpha = 1.0;
        } completion:^(BOOL finished) {
            [self cleanContainerView:containerView];//移除所有子控件
            [containerView addSubview:toVC.view];//将目标控制器的vc添加上去
            [transitionContext completeTransition:YES];//标志转场结束
            containerView = nil;
            [fromVC reloadView];//登录界面重载UI
        }];
    }
    else//退出登录转场动画
    {
        //transitionContext:转场上下文
        //转场过程中显示的view，所有动画控件都应该加在这上面
        UIView *containerView = [transitionContext containerView];
        //转场的来源控制器
        YYLoginViewController* toVC = (YYLoginViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        //转场去往的控制器
        YYFirstViewController* fromVC = (YYFirstViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        //做一个淡入淡出的效果
        toVC.view.alpha = 0;
        [containerView addSubview:toVC.view];
        [UIView animateWithDuration:1.0 animations:^{
            fromVC.view.alpha = 0;
        } completion:^(BOOL finished) {
    
        }];
        [UIView animateWithDuration:0.6 delay:0.4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            toVC.view.alpha = 1;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

/** 移除containerView的子控件 */
- (void)cleanContainerView:(UIView *)containerView
{
    int i = [[NSString stringWithFormat:@"%lu",(containerView.subviews.count-1)] intValue];
    for (; i >= 0; i--)
    {
        UIView *subView = containerView.subviews[i];
        [subView removeFromSuperview];
    }
}

/** 核心动画动画代理 */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if ([self.circularAnimView.layer animationForKey:@"circleMoveAnimation"] == anim)
    {
        /** 这里是在做加号按钮内部的白色加号的伸展开的效果 */
        //画线
        CGRect rect = self.circularAnimView.frame;
        CGPoint centerPoint = CGPointMake(rect.size.width*0.5, rect.size.height*0.5);
        
        //贝瑟尔线
        UIBezierPath *path1 = [UIBezierPath bezierPath];
        [path1 moveToPoint:centerPoint];
        [path1 addLineToPoint:CGPointMake(rect.size.width*0.5, rect.size.height*0.25)];
        UIBezierPath *path2 = [UIBezierPath bezierPath];
        [path2 moveToPoint:centerPoint];
        [path2 addLineToPoint:CGPointMake(rect.size.width*0.25, rect.size.height*0.5)];
        UIBezierPath *path3 = [UIBezierPath bezierPath];
        [path3 moveToPoint:centerPoint];
        [path3 addLineToPoint:CGPointMake(rect.size.width*0.5, rect.size.height*0.75)];
        UIBezierPath *path4 = [UIBezierPath bezierPath];
        [path4 moveToPoint:centerPoint];
        [path4 addLineToPoint:CGPointMake(rect.size.width*0.75, rect.size.height*0.5)];
        
        //ShapeLayer
        CAShapeLayer *shape1 = [self makeShapeLayerWithPath:path1 lineWidth:rect.size.width*0.07];
        [self.circularAnimView.layer addSublayer:shape1];
        CAShapeLayer *shape2 = [self makeShapeLayerWithPath:path2 lineWidth:rect.size.width*0.07];
        [self.circularAnimView.layer addSublayer:shape2];
        CAShapeLayer *shape3 = [self makeShapeLayerWithPath:path3 lineWidth:rect.size.width*0.07];
        [self.circularAnimView.layer addSublayer:shape3];
        CAShapeLayer *shape4 = [self makeShapeLayerWithPath:path4 lineWidth:rect.size.width*0.07];
        [self.circularAnimView.layer addSublayer:shape4];
        
        //动画
        CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        checkAnimation.duration = 0.25f;
        checkAnimation.fromValue = @(0.0f);
        checkAnimation.toValue = @(1.0f);
        checkAnimation.delegate = self;
        
        [shape1 addAnimation:checkAnimation forKey:@"checkAnimation"];
        [shape2 addAnimation:checkAnimation forKey:@"checkAnimation"];
        [shape3 addAnimation:checkAnimation forKey:@"checkAnimation"];
        [shape4 addAnimation:checkAnimation forKey:@"checkAnimation"];
    }
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
