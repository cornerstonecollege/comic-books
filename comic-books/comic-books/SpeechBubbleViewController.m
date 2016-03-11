//
//  SpeechBubbleViewController.m
//  comic-books
//
//  Created by Hiroshi on 3/10/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "SpeechBubbleViewController.h"
#import "TabBarController.h"

@interface SpeechBubbleViewController ()

@property (nonatomic, weak) UIView *commonView;
@property (nonatomic, weak) UIView *mainView;

@end

@implementation SpeechBubbleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViews];
}

- (void) setViews
{
    self.commonView = ((TabBarController *)self.tabBarController).commonView;
    [self.view addSubview:self.commonView];
    
    self.mainView = [self.commonView viewWithTag:-1];
}

- (void) tabBarClicked
{
    if (self.isViewLoaded)
    {
        // claim the view to itself
        [self setViews];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
