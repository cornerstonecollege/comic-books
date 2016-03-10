//
//  FrameViewController.m
//  comic-books
//
//  Created by Hiroshi on 3/9/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "FrameViewController.h"
#import "TabBarController.h"

@interface FrameViewController ()

@property (nonatomic) NSArray *layoutArray;
@property (nonatomic, weak) UIView *commonView;
@property (nonatomic) UIView *mainView;
@property (nonatomic) UIImageView *imgView1;
@property (nonatomic) UIImageView *imgView2;
@property (nonatomic) UIImageView *imgView3;
@property (nonatomic) UIImageView *imgView4;

@end

@implementation FrameViewController


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
    _layoutArray = @[@"w1.png", @"w2.png", @"w3.png", @"w4.png", @"w5.png"];
    
    CGPoint point = CGPointMake(self.commonView.center.x, self.commonView.center.y);
    CGFloat tabBarTop = [[[self tabBarController] tabBar] frame].origin.y;
    
    if(self.parentViewController && [self.parentViewController isKindOfClass:[TabBarController class]])
    {
        TabBarController *obj = (TabBarController *)self.parentViewController;
        point = CGPointMake(self.commonView.center.x, self.commonView.center.y - obj.tabBar.frame.size.height);
    }
    
    UIScrollView *layoutView =
    [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                   self.commonView.bounds.size.height*0.15 + self.commonView.bounds.size.height,
                                                   self.commonView.bounds.size.width,
                                                   self.commonView.bounds.size.height*0.15)];
    layoutView.backgroundColor = [UIColor colorWithRed:224.0f/255.0f green:245.0f/255.0f blue:249.0f/255.0f alpha:1.0];
    layoutView.contentSize = CGSizeMake(_layoutArray.count*100, self.commonView.bounds.size.height*0.15);
    
    float moveX = layoutView.frame.size.width / 2;
    float moveY = tabBarTop - self.commonView.bounds.size.height*0.15 + layoutView.frame.size.height/2;
    
    [self.commonView addSubview:layoutView];
    
    [UIView animateWithDuration:0.5 animations:^{
        layoutView.center = CGPointMake(moveX, moveY);
    } completion:^(BOOL finished) {
        
        float xPosition = 50;
        float time = 0;
        NSInteger cnt = 1;
        for (NSString * name in _layoutArray)
        {
            [self addImageSize:CGRectMake(xPosition, self.commonView.bounds.size.height*0.15/4, 50, 50) name:name count:cnt time:time andParent:layoutView];
            xPosition += 100;
            time += 0.05;
            cnt +=1;
        }
    }];
}

- (void) addImageSize:(CGRect)size name:(NSString *)name count:(NSInteger)cnt time:(NSTimeInterval)time andParent:(UIScrollView *)parent
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:size];
    imageView.tag = cnt;
    [imageView setImage:[UIImage imageNamed:name]];
    
    
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [imageView addGestureRecognizer:tap];
    //[tap release];
    
    [parent addSubview:imageView];
    
    imageView.center = CGPointMake(size.origin.x, parent.frame.size.height + size.size.height / 2);
    [UIView animateWithDuration:time animations:^{
        imageView.center = CGPointMake(size.origin.x, size.origin.y + size.size.height / 2);
    }];
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer  {
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
    _mainView = [[UIView alloc] initWithFrame:CGRectMake(self.commonView.bounds.size.width*0.01,
                                                         self.commonView.bounds.size.height*0.15,
                                                         self.commonView.bounds.size.width*0.98,
                                                         self.commonView.bounds.size.width*0.98)];
    _mainView.backgroundColor = [UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:230.0f/255.0f alpha:1.0];
    [self.commonView addSubview:_mainView];
    
    _mainView.center = CGPointMake(_mainView.center.x ,(self.commonView.frame.size.height - (self.commonView.bounds.size.height*0.15 + self.tabBarController.tabBar.frame.size.height)) / 2);
    
    [self createLayouts:_mainView andType:[imageView tag]];
}

//- (void)

- (void)createLayouts:(UIView*)parent andType:(NSInteger)number
{
    switch(number)
    {
        case 1:
            _imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, parent.bounds.size.width, parent.bounds.size.height/2)];
            _imgView1.backgroundColor = [UIColor colorWithRed:251.0f/255.0f green:238.0f/255.0f blue:202.0f/255.0f alpha:1.0];
            [parent addSubview:_imgView1];
            break;
        case 2:
            NSLog(@"TEST2");
            break;
        case 3:
            NSLog(@"TEST3");
            break;
        case 4:
            NSLog(@"TEST4");
            break;
        case 5:
            NSLog(@"TEST5");
            break;
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

