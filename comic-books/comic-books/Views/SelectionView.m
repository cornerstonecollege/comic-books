//
//  SelectionView.m
//  comic-books
//
//  Created by Hiroshi on 3/14/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "SelectionView.h"
#import "Utilities.h"
#import "FilterHelper.h"

@interface SelectionView ()

@property (nonatomic) NSArray *frameImagesArr;
@property (nonatomic) char *speechBubbleArr;
@property (nonatomic) char *soundFXArr;

@end

@implementation SelectionView

- (instancetype) initWithType:(SELECTION_TYPE)type andFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _type = type;
        [self initializeVars];
        [self initializeWithType:type];
    }
    
    return self;
}

- (void) initializeVars
{
    self.frameImagesArr = @[@"layout1.png", @"layout2.png", @"layout3.png", @"layout4.png", @"layout5.png", @"layout6.png", @"layout7.png", @"layout8.png", @"layout9.png"];
    self.soundFXArr = "ABCEFGHIJKLMOQRSTUVXZabcdefhijmoqruvy359%#),}|]^";
    self.speechBubbleArr = "@ABCDEFGHIJKLMNOPQST";
    self.backgroundColor = [Utilities heroBlueColor];
}

- (void) initializeWithType:(SELECTION_TYPE)type
{
    switch (type)
    {
        case ST_FRAME:
        {
            [self createLayoutWithType];
            break;
        }
        case ST_FILTER:
        {
            [self createLayoutWithType];
            break;
        }
        case ST_SPEECH_BUBBLE:
        {
            [self createStampAndSpeechBubbleLayout];
            break;
        }
        case ST_STAMP:
        {
            [self createStampAndSpeechBubbleLayout];
            break;
        }
    }
}

- (void) createLayoutWithType
{
    float xPosition = [Utilities sizeFrame] / 2;
    float time = 0;
    NSInteger cnt = 1;
    
    if (self.type == ST_FRAME)
    {
        for (NSString * name in self.frameImagesArr)
        {
            [self addImageSize:CGRectMake(xPosition,
                                          self.superview.bounds.size.height*[Utilities percentageScreen]/4,
                                          [Utilities sizeFrame] / 2,
                                          [Utilities sizeFrame] / 2) name:name count:cnt time:time andParent:self];
            xPosition += [Utilities sizeFrame];
            time += 0.05;
            cnt +=1;
        }
        self.contentSize = CGSizeMake(self.frameImagesArr.count*[Utilities sizeFrame], self.superview.bounds.size.height*[Utilities percentageScreen]);
    }
    
    if (self.type == ST_FILTER) {
        for (int i=0; i<24; i++)
        {
            [self addImageSize:CGRectMake(xPosition,
                                          self.superview.bounds.size.height*[Utilities percentageScreen]/4,
                                          [Utilities sizeFrame] / 2,
                                          [Utilities sizeFrame] / 2) name:@"filter.png" count:cnt time:time andParent:self];
            xPosition += [Utilities sizeFrame];
            time += 0.05;
            cnt +=1;
        }
        self.contentSize = CGSizeMake(24*[Utilities sizeFrame], self.superview.bounds.size.height*[Utilities percentageScreen]);
    }
}

- (void) addImageSize:(CGRect)size name:(NSString *)name count:(NSInteger)cnt time:(NSTimeInterval)time andParent:(UIScrollView *)parent
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:size];
    imageView.tag = cnt;
    
    UIImage *image = [[UIImage alloc]init];
    image = [UIImage imageNamed:name];
    
    if (self.type == ST_FILTER) {
        imageView.image = [FilterHelper imageFilterWithParent:parent type:cnt andOriginalImage:image];
    }
    else
    {
        [imageView setImage:image];
    }
    
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [imageView addGestureRecognizer:tap];
    
    [parent addSubview:imageView];
    
    imageView.center = CGPointMake(size.origin.x, parent.frame.size.height + size.size.height / 2);
    [UIView animateWithDuration:time animations:^{
        imageView.center = CGPointMake(size.origin.x, size.origin.y + size.size.height);
    }];
}

- (void) createStampAndSpeechBubbleLayout
{
    float xPosition = 50;
    float time = 0;
    
    char *arr = self.type == ST_STAMP ? self.soundFXArr : self.speechBubbleArr;
    
    for (int i = 0; i < strlen(arr); i++)
    {
        char character = arr[i];
        
        [self addStampWithFrame:CGRectMake(xPosition, self.superview.bounds.size.height*[Utilities percentageScreen]/4, [Utilities sizeFrame] / 2, [Utilities sizeFrame] / 2) character:character count:i time:time andParent:self];
        xPosition +=  [Utilities sizeFrame];
        time += 0.05;
    }
    
    if([self.subviews lastObject])
    {
        UIView *lastObject = [self.subviews lastObject];
        
        self.contentSize = CGSizeMake(lastObject.frame.origin.x + lastObject.frame.size.width + 10, self.superview.bounds.size.height*[Utilities percentageScreen]);
    }
}

- (void) addStampWithFrame:(CGRect)frame character:(char)character count:(NSInteger)cnt time:(NSTimeInterval)time andParent:(UIScrollView *)parent
{
    UILabel *label = [[UILabel alloc] init];
    label.tag = cnt;
    
    NSString *fontName = self.type == ST_STAMP ? @"Sound FX" : @"Komika Bubbles Dark";
    
    [label setFont:[UIFont fontWithName:fontName size:[Utilities sizeFrame]]];
    label.textColor = [Utilities heroGrayColor];
    label.text = [NSString stringWithFormat:@"%c", character];
    [label sizeToFit];
    
    CGPoint point;
    if ([parent.subviews lastObject])
    {
        UIView *lastObject = [parent.subviews lastObject];
        point = CGPointMake(lastObject.frame.origin.x + lastObject.frame.size.width + 10 + label.frame.size.width, frame.size.height);
    }
    else
    {
        CGFloat space = self.type == ST_STAMP ? 0 : 20;
        point = CGPointMake(frame.origin.x + frame.size.width + space, frame.origin.y + frame.size.height);
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

- (void) handleTap:(UITapGestureRecognizer *)recognizer
{
    if (self.selectionDelegate)
    {
        switch (self.type)
        {
            case ST_FRAME:
            {
                if ([self.selectionDelegate respondsToSelector:@selector(didTouchFrame:)])
                {
                    [self.selectionDelegate didTouchFrame:recognizer.view.tag];
                }
                break;
            }
            case ST_FILTER:
            {
                if ([self.selectionDelegate respondsToSelector:@selector(didTouchFilter:)])
                {
                    [self.selectionDelegate didTouchFilter:recognizer.view.tag];
                }
                break;
            }
            case ST_SPEECH_BUBBLE:
            {
                if ([self.selectionDelegate respondsToSelector:@selector(didTouchSpeechBubble:)])
                {
                    UILabel *label = (UILabel *)recognizer.view;
                    [self.selectionDelegate didTouchSpeechBubble:[label.text UTF8String][0]];
                }
                break;
            }
            case ST_STAMP:
            {
                if ([self.selectionDelegate respondsToSelector:@selector(didTouchStamp:)])
                {
                    UILabel *label = (UILabel *)recognizer.view;
                    [self.selectionDelegate didTouchStamp:[label.text UTF8String][0]];
                }
                break;
            }
        }
    }
}

@end
