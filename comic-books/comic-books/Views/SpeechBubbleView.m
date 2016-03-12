//
//  SpeechBubbleView.m
//  comic-books
//
//  Created by CICCC1 on 2016-03-10.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "SpeechBubbleView.h"

@implementation SpeechBubbleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    UIGraphicsPushContext ( ctx );
    
    CATextLayer *label = [[CATextLayer alloc] init];
    [label setFont:(__bridge CFTypeRef)[UIFont fontWithName:@"Komika Bubbles" size:100]];
    [label setFontSize:100.0];
    [label setFrame:CGRectMake( 0, 0, 100, 100 )];
    [label setString:@"a"];
    [label setBackgroundColor:[[UIColor whiteColor] CGColor]];
    [label setAlignmentMode:kCAAlignmentCenter];
    [label setForegroundColor:[[UIColor blueColor] CGColor]];
    [layer addSublayer:label];
    UIGraphicsPopContext();

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:50 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [[UIColor yellowColor] set];
    [path fill];
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.path = path.CGPath;
    
    [layer addSublayer:shape];
}

@end
