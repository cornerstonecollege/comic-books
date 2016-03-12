//
//  SpeechBubbleViewController.m
//  comic-books
//
//  Created by Hiroshi on 3/10/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "SpeechBubbleViewController.h"
#import "TabBarController.h"
#import "SpeechBubbleView.h"

@interface SpeechBubbleViewController ()

@property (nonatomic, weak) UIView *commonView;
@property (nonatomic, weak) UIView *mainView;

@end

@implementation SpeechBubbleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViews];
    [self doTests];
}

- (void) setViews
{
    self.commonView = ((TabBarController *)self.tabBarController).commonView;
    [self.view addSubview:self.commonView];
    
    self.mainView = [self.commonView viewWithTag:0];
}

- (void) doTests
{
    SpeechBubbleView *speech = [[SpeechBubbleView alloc] initWithFrame:CGRectMake(self.mainView.center.x, self.mainView.center.y, 200, 200)];
    [self.mainView addSubview:speech];
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
