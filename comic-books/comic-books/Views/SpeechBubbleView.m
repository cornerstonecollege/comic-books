//
//  SpeechBubbleView.m
//  comic-books
//
//  Created by CICCC1 on 2016-03-10.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "SpeechBubbleView.h"
#import "Utilities.h"

@interface SpeechBubbleView ()

@property (nonatomic) UILabel *labelBack;

@end

@implementation SpeechBubbleView

- (instancetype)initWithCode:(char)codeStamp andParent:(UIView *)parentView
{
    self = [super init];
    if (self)
    {
        [self addEvents];
        self.backgroundColor = [UIColor redColor];
        [self createSpeechBubbleWithCode:codeStamp];
        self.frame = _labelBack.frame;
        [self setPositionWithParent:parentView];
    }
    
    return self;
}

- (void) setPositionWithParent:(UIView *)parentView
{
    CGFloat width = arc4random_uniform(parentView.frame.size.width - self.labelBack.frame.size.width) + self.labelBack.frame.size.width / 2;
    CGFloat height = arc4random_uniform(parentView.frame.size.height - self.labelBack.frame.size.height) + self.labelBack.frame.size.height / 2;
    self.center = CGPointMake(width, height);
}

- (void) addEvents
{
    self.userInteractionEnabled = YES;
    UIPinchGestureRecognizer *pinch =
    [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    
    self.gestureRecognizers = @[pinch, pan, rotation, doubleTap];
}

- (void) createSpeechBubbleWithCode:(char)codeStamp
{
    self.labelBack = [[UILabel alloc] init];
    [self.labelBack setFont:[UIFont fontWithName:@"Komika Bubbles Dark" size:[Utilities sizeFrame]+50]];
    self.labelBack.textColor = [UIColor whiteColor];
    self.labelBack.text = [NSString stringWithFormat:@"%c", codeStamp];
    [self.labelBack sizeToFit];
    
    [self addSubview:self.labelBack];
}

- (void) handleDoubleTap:(UITapGestureRecognizer *)tapGesture
{
    char theChar = [self.labelBack.text UTF8String][0];
    theChar += islower(theChar) ? -32 : 32;
    self.labelBack.text = [NSString stringWithFormat:@"%c", theChar];
}

- (void) handlePinch:(UIPinchGestureRecognizer *)pinchGesture
{
    CGFloat size = [Utilities sizeFrame]*pinchGesture.scale;
    size = (size < [Utilities sizeFrame] / 1.2) ? [Utilities sizeFrame] / 1.2 : size;
    size = (size > [Utilities sizeFrame] * 2.2) ? [Utilities sizeFrame] * 2.2 : size;
    
    [self.labelBack setFont:[UIFont fontWithName:@"Komika Bubbles Dark" size:size]];
    [self.labelBack sizeToFit];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.labelBack.frame.size.width, self.labelBack.frame.size.height);
}

- (void) handleRotation:(UIRotationGestureRecognizer *)rotationGesture
{
    [self setTransform:CGAffineTransformMakeRotation(rotationGesture.rotation)];
}

- (void) handlePan:(UIPanGestureRecognizer *)panGesture
{
    // superview is self.mainView
    
    CGPoint point = [panGesture locationInView:self.superview];
    
    if (point.x < self.frame.size.width / 2)
    {
        point.x = self.frame.size.width / 2;
    }
    else if (point.x > self.superview.frame.size.width - self.frame.size.width / 2)
    {
        point.x = self.superview.frame.size.width - self.frame.size.width / 2;
    }
    
    if (point.y <  self.frame.size.height / 2)
    {
        point.y = self.frame.size.height / 2;
    }
    else if (point.y > self.superview.frame.size.height - self.frame.size.height / 2)
    {
        point.y = self.superview.frame.size.height - self.frame.size.height / 2;
    }
    
    self.center = CGPointMake(point.x, point.y);
}


@end
