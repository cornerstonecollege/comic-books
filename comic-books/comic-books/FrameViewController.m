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
@property (nonatomic, weak) UIView *mainView;
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
    self.mainView = ((TabBarController *)self.tabBarController).mainView;
    [self.view addSubview:self.commonView];
}

- (void) tabBarClickedFromSomewhere:(BOOL)isInitialization;
{
    // claim the view to itself
    [self.view addSubview:self.commonView];
    
    self.layoutArray = @[@"w1.png", @"w2.png", @"w3.png", @"w4.png", @"w5.png", @"w1.png", @"w2.png", @"w3.png", @"w4.png"];
    
    CGPoint point = CGPointMake(self.commonView.center.x, self.commonView.center.y);
    CGFloat tabBarTop = [[[self tabBarController] tabBar] frame].origin.y;
    
    if(self.parentViewController && [self.parentViewController isKindOfClass:[TabBarController class]])
    {
        TabBarController *obj = (TabBarController *)self.parentViewController;
        point = CGPointMake(self.commonView.center.x, self.commonView.center.y - obj.tabBar.frame.size.height);
    }
    
    UIScrollView *layoutView = [self createScrollViewBottom];
    
    if (isInitialization)
    {
        [self makeLayoutWithFrame:CGRectMake(self.mainView.frame.size.width * 0.01,
                                         self.mainView.frame.size.height * 0.01,
                                         self.mainView.frame.size.width*0.98,
                                         self.mainView.frame.size.height*0.98) parent:self.mainView andImageView:self.imgView1];
        [self createLayouts:self.mainView andType:[self.imgView1 tag]];
    }
    
    float moveX = layoutView.frame.size.width / 2;
    float moveY = tabBarTop - self.commonView.bounds.size.height*0.15 + layoutView.frame.size.height/2;
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

- (UIScrollView *) createScrollViewBottom
{
    __block UIScrollView *layoutView = nil;
    
    [self.commonView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIScrollView class]])
            layoutView = (UIScrollView *)obj;
    }];
    
    if (!layoutView)
    {
        layoutView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                   self.commonView.bounds.size.height*0.15 + self.commonView.bounds.size.height,
                                                   self.commonView.bounds.size.width,
                                                   self.commonView.bounds.size.height*0.15)];
        [self.commonView addSubview:layoutView];
    }
    
    layoutView.backgroundColor = [UIColor colorWithRed:224.0f/255.0f green:245.0f/255.0f blue:249.0f/255.0f alpha:1.0];
    layoutView.contentSize = CGSizeMake(_layoutArray.count*100, self.commonView.bounds.size.height*0.15);
    
    return layoutView;
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
    
    [self clearChildrenMainView];
    [self createLayouts:self.mainView andType:[imageView tag]];
}

- (void)createLayouts:(UIView*)parent andType:(NSInteger)number
{
    float standardSize = parent.frame.size.width;
    
    switch(number)
    {
        case 1:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.98, standardSize*0.98) parent:parent andImageView:self.imgView1];
            break;
        case 2:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.98, standardSize*0.485) parent:parent andImageView:self.imgView1];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:parent andImageView:self.imgView2];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:parent andImageView:self.imgView3];
            break;
        case 3:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:parent andImageView:self.imgView1];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:parent andImageView:self.imgView2];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.98, standardSize*0.485) parent:parent andImageView:self.imgView3];
            break;
        case 4:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.485, standardSize*0.98) parent:parent andImageView:self.imgView1];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:parent andImageView:self.imgView2];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:parent andImageView:self.imgView3];
            break;
        case 5:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:parent andImageView:self.imgView1];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.01, standardSize*0.485, standardSize*0.98) parent:parent andImageView:self.imgView2];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:parent andImageView:self.imgView3];
            break;
    }
    
}

- (void) clearChildrenMainView
{
    [self.mainView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
    {
        [obj removeFromSuperview];
    }];
}

- (void)makeLayoutWithFrame:(CGRect)frame parent:(UIView *)parent andImageView:(UIImageView *)image
{
    image = [[UIImageView alloc] initWithFrame:frame];
    image.backgroundColor = [UIColor colorWithRed:244.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0];
    [parent addSubview:image];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

