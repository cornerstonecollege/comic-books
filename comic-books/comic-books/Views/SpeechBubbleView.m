//
//  SpeechBubbleView.m
//  comic-books
//
//  Created by CICCC1 on 2016-03-10.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "SpeechBubbleView.h"
#import "Utilities.h"
#import "SpeechBubbleUtilities.h"

@interface SpeechBubbleView () <UITextViewDelegate>

@property (nonatomic) UILabel *labelBack;
@property (nonatomic) UITextView *textView;
@property (nonatomic) NSArray<UIColor *> *arrColors;

@end

@implementation SpeechBubbleView

- (instancetype) initWithCode:(char)codeBubble andParent:(UIView *)parentView
{
    self = [super init];
    if (self)
    {
        [self addEvents];
        self.backgroundColor = [UIColor clearColor];
         _arrColors = @[[UIColor whiteColor], [Utilities penelopeColor], [Utilities heroBlueColor], [Utilities vitaminsColor], [Utilities vilainPurpleColor], [Utilities drifterColor]];
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
    [self setCustomKeyboardView];
}

- (void) setCustomKeyboardView
{
    UIToolbar* toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleDefault;
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
    
    [self addColorsToArray:arr];
    
    [arr addObject:[[UIBarButtonItem alloc]initWithTitle:@"Delete" style:UIBarButtonItemStyleDone target:self action:@selector(deleteView)]];
    
    [arr addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
    
    toolbar.items = arr;
    [toolbar sizeToFit];
    self.textView.inputAccessoryView = toolbar;
}

- (void) addColorsToArray:(NSMutableArray *)arr
{
    int count = 0;
    for (UIColor *color in self.arrColors)
    {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.text = @"    ";
        button.layer.backgroundColor = color.CGColor;
        [button sizeToFit];
        button.tag = 10 + count;
        [button addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [arr addObject: btnItem];
        
        count++;
    }
}

- (void) changeColor:(UIView *)sender
{
    UIColor *color = self.arrColors[sender.tag - 10];
    self.labelBack.textColor = color;
    
    if (color.CGColor == [UIColor whiteColor].CGColor)
    {
        self.textView.textColor = [UIColor blackColor];
    }
    else if ([color isEqual:[Utilities vilainPurpleColor]])
    {
        self.textView.textColor = [Utilities vilainGreenColor];
    }
    else
    {
        self.textView.textColor = [Utilities superLightGrayColor];
    }
}

- (void) deleteView
{
    [self removeFromSuperview];
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

- (void) setCircularExclusionPathWithCenter:(CGPoint)center radius:(CGFloat)radius textView:(UITextView *)textView
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

- (void) handleLongPress:(UILongPressGestureRecognizer *)longGesture
{
    NSLog(@"DEBUG");
}

- (UIEdgeInsets) UIEdgeInsetsWithCode:(char)code
{
    switch (tolower(code))
    {
        case 'b':
        case 'p':
            return [SpeechBubbleUtilities sbSizeP];
        case 'd':
            return [SpeechBubbleUtilities sbSizeD];
        case 'e':
        case 'f':
        case 'g':
        case 's':
            return [SpeechBubbleUtilities sbSizeS];
        case 'h':
            return [SpeechBubbleUtilities sbSizeH];
        case 'i':
            return [SpeechBubbleUtilities sbSizeI];
        case 'j':
            return [SpeechBubbleUtilities sbSizeJ];
        case 'k':
            return [SpeechBubbleUtilities sbSizeK];
        case 'l':
            return [SpeechBubbleUtilities sbSizeL];
        case 'm':
            return [SpeechBubbleUtilities sbSizeM];
        case 'n':
            return [SpeechBubbleUtilities sbSizeN];
        case 'o':
            return [SpeechBubbleUtilities sbSizeO];
        case 'q':
            return [SpeechBubbleUtilities sbSizeQ];
        case 't':
            return [SpeechBubbleUtilities sbSizeT];
        case '@':
            return [SpeechBubbleUtilities sbSizeFirst];
        default:
            return [SpeechBubbleUtilities sbSize];
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
        case 'a':
            return 2;
            break;
        case 'b':
        case 'n':
        case 'p':
            return 2;
            break;
        case 'd':
            return 3;
            break;
        case 'i':
            return 3;
            break;
        case 'q':
            return 3;
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
