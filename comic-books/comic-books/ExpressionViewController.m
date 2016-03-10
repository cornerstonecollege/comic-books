//
//  ExpressionViewController.m
//  comic-books
//
//  Created by Hiroshi on 3/9/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "ExpressionViewController.h"
#import "TabBarController.h"

@interface ExpressionViewController ()

@property (nonatomic, weak) UIView *commonView;

@end

@implementation ExpressionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.commonView = ((TabBarController *)self.tabBarController).commonView;
    [self.view addSubview:self.commonView];
}

- (void) tabBarClicked
{
    // claim the view to itself
    [self.view addSubview:self.commonView];
}

@end
