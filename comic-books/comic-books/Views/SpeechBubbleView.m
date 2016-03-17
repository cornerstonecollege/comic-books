//
//  SpeechBubbleView.m
//  comic-books
//
//  Created by CICCC1 on 2016-03-10.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "SpeechBubbleView.h"
#import "Utilities.h"

@interface SpeechBubbleView () <UITextViewDelegate>

@property (nonatomic) UILabel *labelBack;
@property (nonatomic) UITextView *textView;

@end

@implementation SpeechBubbleView

- (instancetype)initWithCode:(char)codeBubble andParent:(UIView *)parentView
{
    self = [super init];
    if (self)
    {
        [self addEvents];
        self.backgroundColor = [UIColor clearColor];
        [self createSpeechBubbleWithCode:codeBubble];
        self.frame = _labelBack.frame;
        [self setPositionWithParent:parentView];
        [self createTextViewWithCodeBubble:codeBubble];
    }
    
    return self;
}

- (void) createTextViewWithCodeBubble:(char)codeBubble
{
    self.textView = [[UITextView alloc] initWithFrame:self.labelBack.frame];
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.textContainerInset = [self UIEdgeInsetsWithCode:codeBubble];
    self.textView.textContainer.maximumNumberOfLines = [self maximumNumberOfLinesWithCode:codeBubble];
    self.textView.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
    self.textView.font = [UIFont fontWithName:@"Bangers" size:18];
    [self.textView  setReturnKeyType: UIReturnKeyDone];
    self.textView.delegate = self;
    
    [self addSubview:self.textView];
    
    CGFloat radius = [self radiusWithCode:codeBubble];
    CGPoint center = [self centerWithCode:codeBubble];
    
    [self setCircularExclusionPathWithCenter:center radius:radius textView:self.textView];
}

- (BOOL) textView: (UITextView*) textView
shouldChangeTextInRange: (NSRange) range
  replacementText: (NSString*) text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)setCircularExclusionPathWithCenter:(CGPoint)center radius:(CGFloat)radius textView:(UITextView *)textView
{
    UIBezierPath *topHalf = [UIBezierPath bezierPath];
    [topHalf moveToPoint:CGPointMake(center.x - radius, center.y + radius)];
    [topHalf addLineToPoint:CGPointMake(center.x - radius, center.y)];
    [topHalf addArcWithCenter:center radius:radius startAngle:M_PI endAngle:0.0f clockwise:NO];
    [topHalf addLineToPoint:CGPointMake(center.x + radius, center.y + radius)];
    [topHalf closePath];
    
    UIBezierPath *bottomHalf = [UIBezierPath bezierPath];
    [bottomHalf moveToPoint:CGPointMake(center.x - radius, center.y - radius)];
    [bottomHalf addLineToPoint:CGPointMake(center.x - radius, center.y)];
    [bottomHalf addArcWithCenter:center radius:radius startAngle:M_PI endAngle:0 clockwise:YES];
    [bottomHalf addLineToPoint:CGPointMake(center.x + radius, center.y - radius)];
    [bottomHalf closePath];
    
    textView.textContainer.exclusionPaths = @[bottomHalf, topHalf];
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
    self.frame = CGRectMake(pinchGesture.view.frame.origin.x, pinchGesture.view.frame.origin.y, self.labelBack.frame.size.width, self.labelBack.frame.size.height);
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

- (UIEdgeInsets) UIEdgeInsetsWithCode:(char)code
{
    switch (tolower(code))
    {
        case 'b':
            return UIEdgeInsetsMake(50, 10, 0, 10);
            break;
        case 'd':
            return UIEdgeInsetsMake(30, 10, 0, 10);
            break;
        case 'e':
        case 'f':
        case 'g':
            return UIEdgeInsetsMake(40, 10, 0, 10);
            break;
        case 'h':
            return UIEdgeInsetsMake(30, 15, 0, 10);
            break;
        case 'i':
            return UIEdgeInsetsMake(30, 10, 0, 10);
        case 'j':
            return UIEdgeInsetsMake(55, 25, 0, 15);
        case 'k':
            return UIEdgeInsetsMake(55, 10, 0, 20);
            
        default:
            return UIEdgeInsetsMake(30, 0, 0, 0);
            break;
    }
}

- (CGFloat) radiusWithCode:(char)code
{
    switch (tolower(code))
    {
        case 'a':
        case 'c':
            return self.labelBack.frame.size.width / 2;
            break;
            
        default:
            return self.labelBack.frame.size.width;
            break;
    }
}

- (CGPoint) centerWithCode:(char)code
{
    switch (tolower(code))
    {
        default:
            return CGPointMake(self.textView.center.x, self.textView.center.y);
            break;
    }
}

- (NSInteger) maximumNumberOfLinesWithCode:(char)code
{
    switch (tolower(code))
    {
        case 'b':
            return 2;
            break;
        case 'd':
        case 'i':
            return 4;
            break;
        case 'j':
            return 2;
            break;
        default:
            return 3;
            break;
    }
}

@end
