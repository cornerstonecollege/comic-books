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
#import "SpeechBubbleViewController.h"

@interface TabBarController ()

@property (nonatomic) FrameViewController *firstVC;
@property (nonatomic) ExpressionViewController *secondVC;
@property (nonatomic) SpeechBubbleViewController *thirdVC;

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.commonView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage imageNamed:@"background"];
    [self.commonView addSubview:imageView];
    
    [self createMainView];
    [self createTab];
    [self.firstVC tabBarClickedFromSomewhere:YES];
}

- (void) createMainView
{
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(self.commonView.bounds.size.width*0.01,
                                                             self.commonView.bounds.size.height*0.09,
                                                             self.commonView.bounds.size.width*0.98,
                                                             self.commonView.bounds.size.width*0.98)];
    self.mainView.backgroundColor = [UIColor whiteColor];
    [self.commonView addSubview:self.mainView];
    
    //self.mainView.center = CGPointMake(self.mainView.center.x ,(self.commonView.frame.size.height - (self.commonView.bounds.size.height*0.13 + self.tabBarController.tabBar.frame.size.height)) / 2);
}

- (void)createTab
{
    self.firstVC = [[FrameViewController alloc] init];
    self.firstVC.tabBarItem.image = [[UIImage imageNamed:@"layout.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.firstVC.tabBarItem.title = @"Frame";
    [self.firstVC.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }
                                           forState:UIControlStateNormal];
    
    self.secondVC = [[ExpressionViewController alloc] init];
    self.secondVC.tabBarItem.image = [[UIImage imageNamed:@"stamp.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.secondVC.tabBarItem.title = @"Stamp";
    [self.secondVC.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }
                                            forState:UIControlStateNormal];
    
    self.thirdVC = [[SpeechBubbleViewController alloc] init];
    self.thirdVC.tabBarItem.image = [[UIImage imageNamed:@"speechBubble.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.thirdVC.tabBarItem.title = @"SpeechBubble";
    [self.thirdVC.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }
                                           forState:UIControlStateNormal];
    
    self.viewControllers = @[self.firstVC, self.secondVC, self.thirdVC];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item == self.firstVC.tabBarItem)
    {
        [self.firstVC tabBarClickedFromSomewhere:NO];
    }
    else if (item == self.secondVC.tabBarItem)
    {
        [self.secondVC tabBarClicked];
    }
    else if (item == self.thirdVC.tabBarItem)
    {
        [self.thirdVC tabBarClicked];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
