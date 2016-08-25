//
//  GuideController.m
//  GuideViewDemo
//
//  Created by 铁拳科技 on 16/8/25.
//  Copyright © 2016年 铁哥哥. All rights reserved.
//

#import "GuideController.h"
#import "ViewController.h"

@interface GuideController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIButton *startButton;


@end

@implementation GuideController

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width * self.pageControl.numberOfPages ,self.view.frame.size.height);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        for (NSUInteger i = 0; i < self.pageControl.numberOfPages; i ++) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"guide%zd",i]]];
            imageView.frame = CGRectMake(i * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
            [_scrollView addSubview:imageView];
            imageView.userInteractionEnabled = NO;
        }
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake(self.view.frame.size.width / 2 - 50, self.view.frame.size.height - 68, 100, 20);
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:36 / 255.0 green:171 / 255.0 blue:27 / 255.0 alpha:1.0];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:175 / 255.0 green:234 / 255.0 blue:174 / 255.0 alpha:1.0];
        [self.view addSubview:_pageControl];
    }
    return _pageControl;
}

- (UIButton *)startButton {
    if (!_startButton) {
        _startButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _startButton.frame = CGRectMake((self.pageControl.numberOfPages - 1) * self.view.frame.size.width + self.view.frame.size.width / 2 - 50, self.view.frame.size.height - 120, 100, 36);
        [_startButton setTitle:@"马上体验" forState:UIControlStateNormal];
        [_startButton setTitleColor:[UIColor colorWithRed:36 / 255.0 green:171 / 255.0 blue:27 / 255.0 alpha:1.0] forState:UIControlStateNormal];
        [_startButton addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchUpInside];
        _startButton.layer.shadowOpacity = 0.1;
        _startButton.layer.shadowOffset = CGSizeMake(3, 3);
        _startButton.layer.cornerRadius = 8;
        _startButton.layer.borderColor = [UIColor colorWithRed:36 / 255.0 green:171 / 255.0 blue:27 / 255.0 alpha:1.0].CGColor;
        _startButton.layer.borderWidth = 1;
        _startButton.userInteractionEnabled = YES;
    }
    return _startButton;
}

- (void)startAction {
    NSLog(@"开启成功");
    
//    [UIApplication sharedApplication].keyWindow.rootViewController = [[UIViewController alloc] init];
//    
//    //更换根控制器
//    MainTabBarController *mainTabVC = [[MainTabBarController alloc]init];
//    mainTabVC.view.transform = CGAffineTransformMakeScale(.1, .1);
//    mainTabVC.view.alpha = 0.0;
//    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        mainTabVC.view.transform = CGAffineTransformIdentity;
//        mainTabVC.view.alpha = 1.0;
//    } completion:nil];
//    [UIApplication sharedApplication].keyWindow.rootViewController = mainTabVC;
//    self.view.window.rootViewController = mainTabVC;
    
}


#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置下页书
    self.pageControl.numberOfPages = 5;
    // 添加下ScrollView
    [self.view insertSubview:self.scrollView belowSubview:self.pageControl];
    
    [self.scrollView addSubview:self.startButton];
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x / self.view.frame.size.width;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat indexfloat = scrollView.contentOffset.x / self.view.frame.size.width;
    NSInteger indexInt = (NSInteger)indexfloat;
    CGFloat value = indexfloat - indexInt;
    self.pageControl.currentPage = value > 0.5 ? indexfloat + 0.5 : indexInt;
}

@end
