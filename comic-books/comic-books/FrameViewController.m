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
    
    [self createMainView];
    self.imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(self.mainView.frame.size.width * 0.01,
                                                              self.mainView.frame.size.height * 0.01,
                                                              self.mainView.frame.size.width*0.98,
                                                              self.mainView.frame.size.height*0.98)];
    self.imgView1.backgroundColor = [UIColor colorWithRed:226.0f/255.0f green:226.0f/255.0f blue:226.0f/255.0f alpha:1.0];
    [self.mainView addSubview:self.imgView1];
    
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
    
    [self createMainView];
    
    [self createLayouts:self.mainView andType:[imageView tag]];
}

- (void)createMainView
{
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(self.commonView.bounds.size.width*0.01,
                                                         self.commonView.bounds.size.height*0.15,
                                                         self.commonView.bounds.size.width*0.98,
                                                         self.commonView.bounds.size.width*0.98)];
    self.mainView.backgroundColor = [UIColor whiteColor];
    [self.commonView addSubview:self.mainView];
    
    self.mainView.center = CGPointMake(self.mainView.center.x ,(self.commonView.frame.size.height - (self.commonView.bounds.size.height*0.15 + self.tabBarController.tabBar.frame.size.height)) / 2);
}

- (void)createLayouts:(UIView*)parent andType:(NSInteger)number
{
    float standardSize = parent.frame.size.width;
    
    switch(number)
    {
        case 1:
            self.imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.98, standardSize*0.98)];
            self.imgView1.backgroundColor = [UIColor colorWithRed:226.0f/255.0f green:226.0f/255.0f blue:226.0f/255.0f alpha:1.0];
            [parent addSubview:self.imgView1];
            break;
        case 2:
            self.imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.98, standardSize*0.485)];
            self.imgView1.backgroundColor = [UIColor colorWithRed:226.0f/255.0f green:226.0f/255.0f blue:226.0f/255.0f alpha:1.0];
            [parent addSubview:self.imgView1];
            
            self.imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.485, standardSize*0.485)];
            self.imgView2.backgroundColor = [UIColor colorWithRed:226.0f/255.0f green:226.0f/255.0f blue:226.0f/255.0f alpha:1.0];
            [parent addSubview:self.imgView2];
            
            self.imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(standardSize*0.505, standardSize*0.505, standardSize*0.485, standardSize*0.485)];
            self.imgView3.backgroundColor = [UIColor colorWithRed:226.0f/255.0f green:226.0f/255.0f blue:226.0f/255.0f alpha:1.0];
            [parent addSubview:self.imgView3];
            break;
        case 3:
            self.imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.485, standardSize*0.485)];
            self.imgView1.backgroundColor = [UIColor colorWithRed:226.0f/255.0f green:226.0f/255.0f blue:226.0f/255.0f alpha:1.0];
            [parent addSubview:self.imgView1];
            
            self.imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(standardSize*0.505, standardSize*0.01, standardSize*0.485, standardSize*0.485)];
            self.imgView2.backgroundColor = [UIColor colorWithRed:226.0f/255.0f green:226.0f/255.0f blue:226.0f/255.0f alpha:1.0];
            [parent addSubview:self.imgView2];
            
            self.imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.98, standardSize*0.485)];
            self.imgView3.backgroundColor = [UIColor colorWithRed:226.0f/255.0f green:226.0f/255.0f blue:226.0f/255.0f alpha:1.0];
            [parent addSubview:self.imgView3];
            break;

        case 4:
            self.imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.485, standardSize*0.98)];
            self.imgView1.backgroundColor = [UIColor colorWithRed:226.0f/255.0f green:226.0f/255.0f blue:226.0f/255.0f alpha:1.0];
            [parent addSubview:self.imgView1];
            
            self.imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(standardSize*0.505, standardSize*0.01, standardSize*0.485, standardSize*0.485)];
            self.imgView2.backgroundColor = [UIColor colorWithRed:226.0f/255.0f green:226.0f/255.0f blue:226.0f/255.0f alpha:1.0];
            [parent addSubview:self.imgView2];
            
            self.imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(standardSize*0.505, standardSize*0.505, standardSize*0.485, standardSize*0.485)];
            self.imgView3.backgroundColor = [UIColor colorWithRed:226.0f/255.0f green:226.0f/255.0f blue:226.0f/255.0f alpha:1.0];
            [parent addSubview:self.imgView3];
            break;

        case 5:
            self.imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.485, standardSize*0.485)];
            self.imgView1.backgroundColor = [UIColor colorWithRed:226.0f/255.0f green:226.0f/255.0f blue:226.0f/255.0f alpha:1.0];
            [parent addSubview:self.imgView1];
            
            self.imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(standardSize*0.505, standardSize*0.01, standardSize*0.485, standardSize*0.98)];
            self.imgView2.backgroundColor = [UIColor colorWithRed:226.0f/255.0f green:226.0f/255.0f blue:226.0f/255.0f alpha:1.0];
            [parent addSubview:self.imgView2];
            
            self.imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.485, standardSize*0.485)];
            self.imgView3.backgroundColor = [UIColor colorWithRed:226.0f/255.0f green:226.0f/255.0f blue:226.0f/255.0f alpha:1.0];
            [parent addSubview:self.imgView3];
            break;

    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

