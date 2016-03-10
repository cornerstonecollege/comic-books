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

@end

@implementation ExpressionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.commonView = ((TabBarController *)self.tabBarController).commonView;
    //[self.view addSubview:self.commonView];
    
    [self doTests];
}

- (void) doTests
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)];
    
    CGFloat centerX = imgView.bounds.origin.x + imgView.bounds.size.width / 2.0;
    CGFloat centerY = imgView.bounds.origin.y + imgView.bounds.size.height / 2.0;
    
    imgView.image = [[ImageFilterHelper sharedInstance] CMYKHalftoneImageWithImage:[UIImage imageNamed:@"heroes"] andCenter:[CIVector vectorWithX:centerX Y:centerY]];
    imgView.center = self.view.center;
    [self.view addSubview:imgView];
    
    UILabel *factLabel = [[UILabel alloc] init];
    [factLabel setFont:[UIFont fontWithName:@"Sound FX" size:100]];
    factLabel.text = @"e";
    [factLabel sizeToFit];
    factLabel.backgroundColor = [UIColor clearColor];
    factLabel.textColor = [UIColor whiteColor];
    factLabel.center = CGPointMake(imgView.frame.origin.x + factLabel.frame.size.width / 2, imgView.frame.origin.y + factLabel.frame.size.height / 2);
    [self.view addSubview:factLabel];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void) tabBarClicked
{
    // claim the view to itself
    //[self.view addSubview:self.commonView];
}

@end
