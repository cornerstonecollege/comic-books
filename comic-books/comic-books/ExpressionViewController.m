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
@property (nonatomic) char *soundFXArr;
@property (nonatomic) CGFloat percentagePopup;

@end

@implementation ExpressionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setViews];
    [self createFrame];
}

- (void) setViews
{
    self.soundFXArr = "ABCEFGHIJKLMOQRSTUVXZabcdefhijmoqruvy359%#),}|]^";
    self.percentagePopup = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 0.10 : 0.15;
    
    self.commonView = ((TabBarController *)self.tabBarController).commonView;
    [self.view addSubview:self.commonView];
    
    self.mainView = [self.commonView viewWithTag:0];
}

- (void) createFrame
{
    UIScrollView *layoutView = [self createScrollViewBottom];
    
    CGFloat tabBarTop = [[[self tabBarController] tabBar] frame].origin.y;
    float moveX = layoutView.frame.size.width / 2;
    float moveY = tabBarTop - self.commonView.bounds.size.height*self.percentagePopup + layoutView.frame.size.height/2;
    [UIView animateWithDuration:0.5 animations:^{
        layoutView.center = CGPointMake(moveX, moveY);
    } completion:^(BOOL finished) {
        
        float xPosition = 50;
        float time = 0;
        for (int i = 0; i < strlen(self.soundFXArr); i++)
        {
            char character = self.soundFXArr[i];
            
            [self addStampWithFrame:CGRectMake(xPosition, self.commonView.bounds.size.height*self.percentagePopup/4, 50, 50) character:character count:i time:time andParent:layoutView];
            xPosition += 100;
            time += 0.05;
        }
        
        if([layoutView.subviews lastObject])
        {
            UIView *lastObject = [layoutView.subviews lastObject];
            
            layoutView.contentSize = CGSizeMake(lastObject.frame.origin.x + lastObject.frame.size.width + 20, self.commonView.bounds.size.height*0.15);
        }
    }];
}

- (void) addStampWithFrame:(CGRect)frame character:(char)character count:(NSInteger)cnt time:(NSTimeInterval)time andParent:(UIScrollView *)parent
{
    UILabel *label = [[UILabel alloc] init];
    label.tag = cnt;
    [label setFont:[UIFont fontWithName:@"Sound FX" size:100]];
    label.text = [NSString stringWithFormat:@"%c", character];
    [label sizeToFit];
    
    CGPoint point;
    if ([parent.subviews lastObject])
    {
        UIView *lastObject = [parent.subviews lastObject];
        point = CGPointMake(lastObject.frame.origin.x + lastObject.frame.size.width + 20 + label.frame.size.width, frame.size.height);
    }
    else
    {
        point = CGPointMake(frame.origin.x + frame.size.width / 2, frame.origin.y + frame.size.height / 2);
    }
    
    label.center = point;
    
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [label addGestureRecognizer:tap];
    
    [parent addSubview:label];
    
    [UIView animateWithDuration:time animations:^{
        label.center = CGPointMake(label.frame.origin.x, label.frame.origin.y + label.frame.size.height / 2);
    }];
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    UILabel *label = (UILabel *)recognizer.view;
    NSLog(@"%c", self.soundFXArr[label.tag]);
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
                                                                    self.commonView.frame.size.height - self.tabBarController.tabBar.frame.size.height - self.commonView.bounds.size.height*self.percentagePopup,
                                                                    self.commonView.bounds.size.width,
                                                                    self.commonView.bounds.size.height*self.percentagePopup)];
        [self.commonView addSubview:layoutView];
    }
    else
    {
        [layoutView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    
    layoutView.backgroundColor = [UIColor colorWithRed:224.0f/255.0f green:245.0f/255.0f blue:249.0f/255.0f alpha:1.0];
    layoutView.contentSize = CGSizeMake(strlen(self.soundFXArr)*100, self.commonView.bounds.size.height*0.15);
    
    return layoutView;
}

- (void) tabBarClicked
{
    if (self.isViewLoaded)
    {
        // claim the view to itself
        [self setViews];
        [self createFrame];
    }
}

@end
