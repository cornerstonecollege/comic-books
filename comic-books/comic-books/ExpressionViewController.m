//
//  ExpressionViewController.m
//  comic-books
//
//  Created by Hiroshi on 3/9/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "ExpressionViewController.h"
#import "TabBarController.h"
#import "ImageFilterHelper.h"

@interface ExpressionViewController ()

@property (nonatomic, weak) UIView *commonView;
@property (nonatomic, weak) UIView *mainView;

@end

@implementation ExpressionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setViews];
    [self doTests];
}

- (void) setViews
{
    self.commonView = ((TabBarController *)self.tabBarController).commonView;
    [self.view addSubview:self.commonView];
    
    self.mainView = [self.commonView viewWithTag:-1];
}

- (void) doTests
{
    UIImageView *img = (UIImageView *) [self.mainView viewWithTag:0];
    img.image = [UIImage imageNamed:@"heroes"];
    
    UILabel *factLabel = [[UILabel alloc] init];
    [factLabel setFont:[UIFont fontWithName:@"Sound FX" size:100]];
    factLabel.text = @"T";
    [factLabel sizeToFit];
    factLabel.backgroundColor = [UIColor clearColor];
    factLabel.textColor = [UIColor whiteColor];
    factLabel.center = CGPointMake(self.mainView.frame.size.width / 2, self.mainView.frame.size.height / 2);
    [self.mainView addSubview:factLabel];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void) tabBarClicked
{
    if (self.isViewLoaded)
    {
        // claim the view to itself
        [self setViews];
    }
}

@end
