//
//  ViewController.m
//  iPhoneXTest
//
//  Created by user_lzz on 2017/9/22.
//  Copyright © 2017年 user_lzz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSLayoutConstraint *yellowViewTopConstraint;
    NSLayoutConstraint *blueViewLeadConstraint;
}
@end

@implementation ViewController

/*
 1.禁用autoresizing
 1.1给需要设置约束的视图禁用autoresizing，禁用父视图autoresizing对子控件无效
 self.view.translatesAutoresizingMaskIntoConstraints = NO;//错误写法
 */
/*
 计算公式:redView.attribute = self.view.attribute * multiplier + constant;
 其中:＝符号取决于relatedBy:参数
 typedef NS_ENUM(NSInteger, NSLayoutRelation) {
 NSLayoutRelationLessThanOrEqual = -1,   小于等于
 NSLayoutRelationEqual = 0,              等于
 NSLayoutRelationGreaterThanOrEqual = 1, 大于等于
 };
 */

/*
 attribute:传入的是枚举参数
 NSLayoutAttributeLeft = 1,  左边距
 NSLayoutAttributeRight,     右边距
 NSLayoutAttributeTop,       距离顶部边距
 NSLayoutAttributeBottom,    距离底部边距
 NSLayoutAttributeLeading,   左对齐
 NSLayoutAttributeTrailing,  右对齐
 NSLayoutAttributeWidth,     宽度
 NSLayoutAttributeHeight,    高度
 NSLayoutAttributeCenterX,   中点X
 NSLayoutAttributeCenterY,   中点Y
 NSLayoutAttributeBaseline,  文本底线对齐
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    switch (self.type) {
        case 0:{
            // UILayoutGuide 充当视图容器
            [self testbbbbb];
        }
            break;
         
        case 1:{
            // UILayoutGuide 充当占位图
            [self testgaga];
        }
            
            break;
        case 2:{
            // 系统类代码约束实现
            [self test];
//            [self testedddd];
        }
            break;
        default:
            break;
    }
}

// UILayoutGuide 充当视图容器
- (void)testbbbbb
{
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor lightGrayColor];
    label.text = @"UILabel";
#warning 注意点: 如果通过代码来设置Autolayout约束, 那么必须先禁用Autoresizing
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:label];
    
    UIView *testView = [[UIView alloc]init];
    testView.backgroundColor = [UIColor redColor];
    testView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:testView];
    
    UILayoutGuide *container = [[UILayoutGuide alloc]init];
//    container.heightAnchor
    [self.view addLayoutGuide:container];
    
    // 添加 width 约束
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150];
    [self.view addConstraint:widthConstraint];
    // 添加 height 约束
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40];
    [self.view addConstraint:heightConstraint];
    
    // 添加 left 约束
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [self.view addConstraint:leftConstraint];
    
    // 添加 CenterY 约束
    NSLayoutConstraint *labecenterYConstraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.view addConstraint:labecenterYConstraint];
    
    // testView
    // 添加 width 约束
    NSLayoutConstraint *widthConstraint1 = [NSLayoutConstraint constraintWithItem:testView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150];
    [self.view addConstraint:widthConstraint1];
    // 添加 height 约束
    NSLayoutConstraint *heightConstraint1 = [NSLayoutConstraint constraintWithItem:testView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40];
    [self.view addConstraint:heightConstraint1];
    
    NSLayoutConstraint *offYConstraint11 = [NSLayoutConstraint constraintWithItem:testView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:30];
    [self.view addConstraint:offYConstraint11];
    
    NSLayoutConstraint *leftConstraint12 = [NSLayoutConstraint constraintWithItem:testView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeRight multiplier:1.0 constant:5];
    [self.view addConstraint:leftConstraint12];
    
    NSLayoutConstraint *rightConstraint12 = [NSLayoutConstraint constraintWithItem:testView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self.view addConstraint:rightConstraint12];
    
    // container
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.view addConstraint:centerYConstraint];
    
    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:centerXConstraint];
    
    NSLayoutConstraint *containerHeightConstraint = [NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    [self.view addConstraint:containerHeightConstraint];
    
    
    NSLog(@"container---%@---owningView-----%@----layoutFrame-%@",container.identifier,container.owningView,NSStringFromCGRect(container.layoutFrame));
    
}

// UILayoutGuide 充当占位图
- (void)testgaga
{
   /*
    //iOS 6.0或者7.0调用addConstraints
    //[self.view addConstraints:@[leftConstraint, rightConstraint, topConstraint, heightConstraint]];
    
    //iOS 8.0以后设置active属性值
    leftConstraint.active = YES;
    rightConstraint.active = YES;
    topConstraint.active = YES;
    heightConstraint.active = YES;
    */
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor lightGrayColor];
    label.text = @"UILabel";
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:label];
    
    UIView *testView = [[UIView alloc]init];
    testView.backgroundColor = [UIColor redColor];
    testView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:testView];

    UILayoutGuide *container = [[UILayoutGuide alloc]init];
    [self.view addLayoutGuide:container];
    
    // 添加 width 约束
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150];
    [self.view addConstraint:widthConstraint];
    // 添加 height 约束
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40];
    [self.view addConstraint:heightConstraint];
    
    // 添加 left 约束
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20];
    [self.view addConstraint:leftConstraint];
    
    // 添加 top 约束
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:200];
    [self.view addConstraint:topConstraint];
    
    
    // container
    // 添加 width 约束
    NSLayoutConstraint *containerwidthConstraint = [NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40];
    [self.view addConstraint:containerwidthConstraint];

    // 添加 height 约束
    NSLayoutConstraint *containerheightConstraint = [NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40];
    [self.view addConstraint:containerheightConstraint];

    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.view addConstraint:centerYConstraint];
    
    NSLayoutConstraint *containerleftConstraint = [NSLayoutConstraint constraintWithItem:container attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self.view addConstraint:containerleftConstraint];

    
    // testView
    // 添加 width 约束
    NSLayoutConstraint *widthConstraint1 = [NSLayoutConstraint constraintWithItem:testView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150];
    [self.view addConstraint:widthConstraint1];
    // 添加 height 约束
    NSLayoutConstraint *heightConstraint1 = [NSLayoutConstraint constraintWithItem:testView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40];
    [self.view addConstraint:heightConstraint1];
    
    NSLayoutConstraint *offYConstraint11 = [NSLayoutConstraint constraintWithItem:testView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.view addConstraint:offYConstraint11];

    NSLayoutConstraint *leftConstraint12 = [NSLayoutConstraint constraintWithItem:testView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self.view addConstraint:leftConstraint12];

}

// 系统类代码约束实现
- (void)test
{
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor lightGrayColor];
    label.text = @"UILabel";
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:label];
    
    UIView *testView = [[UIView alloc]init];
    testView.backgroundColor = [UIColor redColor];
    testView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:testView];
    
    // 添加 width 约束
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:150];
    [self.view addConstraint:widthConstraint];
    // 添加 height 约束
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:40];
    // multiplier:1.0  // toItem:nil
    [self.view addConstraint:heightConstraint];
    
    // 添加 left 约束
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20];
    [self.view addConstraint:leftConstraint];
    
    // 添加 top 约束
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:200];
    [self.view addConstraint:topConstraint];
    
    // testView
    // 添加 width 约束
    NSLayoutConstraint *widthConstraint1 = [NSLayoutConstraint constraintWithItem:testView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150];
    [self.view addConstraint:widthConstraint1];
    // 添加 height 约束
    NSLayoutConstraint *heightConstraint1 = [NSLayoutConstraint constraintWithItem:testView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40];
    [self.view addConstraint:heightConstraint1];
    
    NSLayoutConstraint *heightConstraint11 = [NSLayoutConstraint constraintWithItem:testView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.view addConstraint:heightConstraint11];
    
    NSLayoutConstraint *leftConstraint12 = [NSLayoutConstraint constraintWithItem:testView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeRight multiplier:1.0 constant:20];
    [self.view addConstraint:leftConstraint12];
}

// 系统类实现约束布局（Masonry 实际是对系统类NSLayoutConstraint的封装）
- (void)testedddd
{
    UILayoutGuide *view_Guide = self.view.layoutMarginsGuide;
    
    // 左边黄色view
    UIView *yellow_View = [[UIView alloc]init];
    yellow_View.backgroundColor = [UIColor yellowColor];
    yellow_View.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:yellow_View];
    // 左边距约束
    NSLayoutConstraint *yellowView_Leading = [yellow_View.leadingAnchor constraintEqualToAnchor:view_Guide.leadingAnchor constant:10];
    // 顶部约束
    NSLayoutConstraint *yellowView_Top = [yellow_View.topAnchor constraintEqualToAnchor:view_Guide.topAnchor constant:84];
    // 宽度约束
    NSLayoutConstraint *yellowView_Width = [yellow_View.widthAnchor constraintEqualToConstant:100];
    // 高度约束
    NSLayoutConstraint *yellow_Height = [yellow_View.heightAnchor constraintEqualToConstant:100];
    [NSLayoutConstraint activateConstraints:@[yellowView_Leading,yellowView_Top,yellow_Height,yellowView_Width]];
    yellowViewTopConstraint = yellowView_Top;
    
    // 居中的红色view
    UIView *middleView = [[UIView alloc]init];
    middleView.backgroundColor = [UIColor redColor];
    middleView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:middleView];
    // 水平居中
    NSLayoutConstraint *middleView_CenterX = [middleView.centerXAnchor constraintEqualToAnchor:view_Guide.centerXAnchor];
    // 垂直居中
    NSLayoutConstraint *middleView_CenterY = [middleView.centerYAnchor constraintEqualToAnchor:view_Guide.centerYAnchor];
    // 宽度约束
    NSLayoutConstraint *middleView_Width = [middleView.widthAnchor constraintEqualToConstant:100];
    // 高度约束
    NSLayoutConstraint *middleView_Height = [middleView.heightAnchor constraintEqualToConstant:100];
    [NSLayoutConstraint activateConstraints:@[middleView_CenterX,middleView_CenterY,middleView_Height,middleView_Width]];
    
    // 创建一个与黄色view相聚10的蓝色view
    UIView *blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:blueView];
    //左边约束
    NSLayoutConstraint *blueView_Leading = [blueView.leadingAnchor constraintEqualToAnchor:yellow_View.trailingAnchor constant:10];
    //顶部约束于黄色view顶部对齐
    NSLayoutConstraint *blueView_Top = [blueView.topAnchor constraintEqualToAnchor:yellow_View.topAnchor];
    //宽度约束
    NSLayoutConstraint *blueView_Width = [blueView.widthAnchor constraintEqualToConstant:100];
    //高度约束
    NSLayoutConstraint *blueView_Height = [blueView.heightAnchor constraintEqualToConstant:100];
    [NSLayoutConstraint activateConstraints:@[blueView_Leading,blueView_Top,blueView_Width,blueView_Height]];
    blueViewLeadConstraint = blueView_Leading;
    
    //创建一个执行动画按钮
    UIButton *btnAnimate = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAnimate setBackgroundColor:[UIColor redColor]];
    [btnAnimate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnAnimate setTitle:@"执行动画" forState:UIControlStateNormal];
    [btnAnimate addTarget:self action:@selector(btnAnimateClick:) forControlEvents:UIControlEventTouchUpInside];
    btnAnimate.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:btnAnimate];
    //水平居中
    NSLayoutConstraint *btnAnimate_CenterX = [btnAnimate.centerXAnchor constraintEqualToAnchor:view_Guide.centerXAnchor];
    //底部约束
    NSLayoutConstraint *btnAnimate_Bottom = [btnAnimate.bottomAnchor constraintEqualToAnchor:view_Guide.bottomAnchor constant:-20];
    
    //宽度约束
    NSLayoutConstraint *btnAnimate_Width = [btnAnimate.widthAnchor constraintEqualToConstant:80];
    //高度约束
    NSLayoutConstraint *btnAnimate_Height = [btnAnimate.heightAnchor constraintEqualToConstant:32];
    
    [NSLayoutConstraint activateConstraints:@[btnAnimate_Height,btnAnimate_Width,btnAnimate_CenterX,btnAnimate_Bottom]];
    
}
- (void)btnAnimateClick:(UIButton *)sender
{
    [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionRepeat animations:^{
        yellowViewTopConstraint.constant += 10;
        blueViewLeadConstraint.constant += 10;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
