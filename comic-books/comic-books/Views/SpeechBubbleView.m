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
    CGFloat size = codeBubble == '@' ? 28 : 18;
    self.textView.font =  [UIFont fontWithName:@"Bangers" size:size];
    [self.textView  setReturnKeyType: UIReturnKeyDone];
    self.textView.delegate = self;
    self.textView.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.textView];
    
    CGFloat radius = [self radiusWithCode:codeBubble];
    CGPoint center = [self centerWithCode:codeBubble];
    
    [self setCircularExclusionPathWithCenter:center radius:radius textView:self.textView];
}

- (BOOL) textView:(UITextView*)textView
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
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [longPress setMinimumPressDuration:0.5];
    
    self.gestureRecognizers = @[pan, rotation, doubleTap, longPress];
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
    
    if (theChar == '@')
        return;
    
    theChar += islower(theChar) ? -32 : 32;
    self.labelBack.text = [NSString stringWithFormat:@"%c", theChar];
}

- (void) handleRotation:(UIRotationGestureRecognizer *)rotationGesture
{
    [self setTransform:CGAffineTransformMakeRotation(rotationGesture.rotation)];
}

- (void) handlePan:(UIPanGestureRecognizer *)panGesture
{
    // superview is self.mainView
    
    CGPoint point = [panGesture locationInView:self.superview];
    
  /*  if (point.x < self.frame.size.width / 2 )
    {
        point.x = self.frame.size.width / 2;
    }
    else if (point.x > self.superview.frame.size.width - self.frame.size.width / 2)
    {
        point.x = self.superview.frame.size.width - self.frame.size.width / 2;
    }
    
    if (point.y <  self.textView.contentSize.width / 2 - self.textView.textContainerInset.top + 10)
    {
        point.y = self.textView.contentSize.width / 2 - self.textView.textContainerInset.top + 10;
    }
    else if (point.y > self.superview.frame.size.height - self.textView.contentSize.height / 2)
    {
        point.y = self.superview.frame.size.height - self.textView.contentSize.height / 2;
    }*/
    
    self.center = CGPointMake(point.x, point.y);
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)longGesture
{
    NSLog(@"DEBUG");
}

- (UIEdgeInsets) UIEdgeInsetsWithCode:(char)code
{
    switch (tolower(code))
    {
        case 'b':
        case 'p':
            return UIEdgeInsetsMake(50, 10, 0, 10);
        case 'd':
            return UIEdgeInsetsMake(30, 10, 0, 10);
        case 'e':
        case 'f':
        case 'g':
        case 's':
            return UIEdgeInsetsMake(40, 10, 0, 10);
        case 'h':
            return UIEdgeInsetsMake(30, 15, 0, 10);
        case 'i':
            return UIEdgeInsetsMake(30, 10, 0, 10);
        case 'j':
            return UIEdgeInsetsMake(55, 25, 0, 15);
        case 'k':
            return UIEdgeInsetsMake(55, 10, 0, 28);
        case 'l':
            return UIEdgeInsetsMake(30, 20, 0, 15);
        case 'm':
            return UIEdgeInsetsMake(40, 20, 0, 15);
        case 'n':
            return UIEdgeInsetsMake(45, 20, 0, 25);
        case 'o':
            return UIEdgeInsetsMake(40, 10, 0, 10);
        case 'q':
            return UIEdgeInsetsMake(50, 15, 0, 15);
        case 't':
            return UIEdgeInsetsMake(40, 15, 0, 15);
        case '@':
            return UIEdgeInsetsMake(50, 5, 0, 5);
            
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
        case 'n':
        case 'p':
            return 2;
            break;
        case 'd':
        case 'i':
        case 'q':
            return 4;
            break;
        case 'j':
            return 2;
            break;
        case '@':
            return 1;
        default:
            return 3;
            break;
    }
}

@end
