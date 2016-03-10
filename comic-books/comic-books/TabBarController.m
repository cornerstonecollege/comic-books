//
//  TabBarController.m
//  comic-books
//
//  Created by Hiroshi on 3/8/16.
//  Copyright © 2016 Hiroshi. All rights reserved.
//

#import "TabBarController.h"
#import "FrameViewController.h"
#import "ExpressionViewController.h"

@interface TabBarController ()

@property (nonatomic) FrameViewController *firstVC;
@property (nonatomic) ExpressionViewController *secondVC;

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.commonView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage imageNamed:@"background"];
    [self.commonView addSubview:imageView];
    
    [self createTab];
}

- (void)createTab
{
    UIImage *image1 = [[UIImage imageNamed:@"layout.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.firstVC = [[FrameViewController alloc] init];
    self.firstVC.tabBarItem.image = image1;
    self.firstVC.tabBarItem.title = @"Layout";
    [self.firstVC.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }
                                           forState:UIControlStateNormal];
    
    self.secondVC = [[ExpressionViewController alloc] init];
    self.secondVC.tabBarItem.image = [[UIImage imageNamed:@"speechBubble.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.secondVC.tabBarItem.title = @"Speech Bubble";
    [self.secondVC.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }
                                            forState:UIControlStateNormal];
    
    self.viewControllers = @[self.firstVC, self.secondVC];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item == self.firstVC.tabBarItem)
    {
        [self.firstVC tabBarClicked];
    }
    else
    {
        [self.secondVC tabBarClicked];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
