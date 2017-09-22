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
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];

    if (@available(iOS 11.0, *)) {
        NSLog(@"fdsaf---%@",self.view.safeAreaLayoutGuide);

        self.view.directionalLayoutMargins = NSDirectionalEdgeInsetsMake(100, 100, 100, 100);
        UIEdgeInsets newSafeArea = self.view.safeAreaInsets;
        NSLog(@"newSafeArea---%@",NSStringFromUIEdgeInsets(newSafeArea));
//        newSafeArea.top+=88;
//        newSafeArea.bottom+=83;
        NSLog(@"ffffffff---%@",NSStringFromUIEdgeInsets(newSafeArea));

        self.additionalSafeAreaInsets = newSafeArea;
        
        NSLog(@"after ---%@",self.view.safeAreaLayoutGuide);
        [self.view safeAreaLayoutGuide];
        
        NSLog(@"gjhasdgfh ---%@",self.view.safeAreaLayoutGuide);
        NSLog(@"additionalSafeAreaInsets ---%@",NSStringFromUIEdgeInsets(self.additionalSafeAreaInsets));
        
        [self addPicConstraint];
    
        

    } else {
        
    }
    
}

- (void)viewSafeAreaInsetsDidChange
{
    [super viewSafeAreaInsetsDidChange];
    NSLog(@"viewSafeAreaInsetsDidChange");
    
    UIEdgeInsets newSafeArea = self.view.safeAreaInsets;
    NSLog(@"viewSafeAreaInsetsDidChange---%@",NSStringFromUIEdgeInsets(newSafeArea));
    
    
    NSLog(@"adfadf---top---%f----bottom---%f",newSafeArea.top,newSafeArea.bottom);
}

- (void)addPicConstraint{
    // 1.创建一个子视图，添加到父视图上面
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
#warning 注意点: 如果通过代码来设置Autolayout约束, 那么必须先禁用Autoresizing
    // 2.禁用autoresizing
    // 2.1给需要设置约束的视图禁用autoresizing，禁用父视图autoresizing对子控件无效
    //self.view.translatesAutoresizingMaskIntoConstraints = NO;//错误写法
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 3.添加约束
    // 3.1红色(红色距离顶部和左边以及右边的边距固定为20，高度固定为50)
    // 3.1.1顶部(基于父控件)
    /*
     constraintWithItem:需要设置约束的view
     attribute:需要设置约束的位置
     relatedBy:约束的条件
     toItem:约束依赖目标
     attribute:依赖目标约束位置
     multiplier:配置系数
     constant:额外需要添加的长度
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
    // 3.1.1.1创建约束对象
    NSLayoutConstraint *redTopCos = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:20];
    // 3.1.1.2判断约束条件的层级关系，并添加到对应的视图
    [self.view addConstraint:redTopCos];
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
    // 3.1.2左边约束(基于父控件)
    NSLayoutConstraint *redLeftCos = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20];
    // 3.1.2.2判断约束条件的层级关系，并添加到对应的视图
    [self.view addConstraint:redLeftCos];
    
    // 3.1.3右边约束(基于父控件)
    NSLayoutConstraint *redRightCos = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20];
    // 3.1.3.2判断约束条件的层级关系，并添加到对应的视图
    [self.view addConstraint:redRightCos];
    
    // 3.1.4 高度约束(自身)
    NSLayoutConstraint *redHeightCos = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0 constant:50];
    // 3.1.3.2判断约束条件的层级关系，并添加到对应的视图
    [redView addConstraint:redHeightCos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
