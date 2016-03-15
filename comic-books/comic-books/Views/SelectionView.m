//
//  SelectionView.m
//  comic-books
//
//  Created by Hiroshi on 3/14/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "SelectionView.h"
#import "Utilities.h"

@interface SelectionView ()

@property (nonatomic) NSArray *frameImagesArr;
@property (nonatomic) char *soundFXArr;

@end

@implementation SelectionView

- (instancetype)initWithType:(SELECTION_TYPE)type andFrame:(CGRect)frame
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
    self.frameImagesArr = @[@"w1.png", @"w2.png", @"w3.png", @"w4.png", @"w5.png", @"w1.png", @"w2.png", @"w3.png", @"w4.png"];
    self.soundFXArr = "ABCEFGHIJKLMOQRSTUVXZabcdefhijmoqruvy359%#),}|]^";
    self.backgroundColor = [Utilities speacialLighterGrayColor];
}

- (void) initializeWithType:(SELECTION_TYPE)type
{
    switch (type)
    {
        case ST_FRAME:
        {
            [self createFrameLayout];
            break;
        }
        case ST_STAMP:
        {
            [self createStampLayout];
            break;
        }
        default:
            break;
    }
}

- (void) createFrameLayout
{
    float xPosition = [Utilities sizeFrame] / 2;
    float time = 0;
    NSInteger cnt = 1;
    for (NSString * name in self.frameImagesArr)
    {
        [self addImageSize:CGRectMake(xPosition, self.superview.bounds.size.height*[Utilities percentageScreen]/4, [Utilities sizeFrame] / 2, [Utilities sizeFrame] / 2) name:name count:cnt time:time andParent:self];
        xPosition += [Utilities sizeFrame];
        time += 0.05;
        cnt +=1;
    }
    
    self.contentSize = CGSizeMake(self.frameImagesArr.count*[Utilities sizeFrame], self.superview.bounds.size.height*[Utilities percentageScreen]);
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
    
    [parent addSubview:imageView];
    
    imageView.center = CGPointMake(size.origin.x, parent.frame.size.height + size.size.height / 2);
    [UIView animateWithDuration:time animations:^{
        imageView.center = CGPointMake(size.origin.x, size.origin.y + size.size.height);
    }];
}

- (void) createStampLayout
{
    float xPosition = 50;
    float time = 0;
    for (int i = 0; i < strlen(self.soundFXArr); i++)
    {
        char character = self.soundFXArr[i];
        
        [self addStampWithFrame:CGRectMake(xPosition, self.superview.bounds.size.height*[Utilities percentageScreen]/4, [Utilities sizeFrame] / 2, [Utilities sizeFrame] / 2) character:character count:i time:time andParent:self];
        xPosition +=  [Utilities sizeFrame];
        time += 0.05;
    }
    
    if([self.subviews lastObject])
    {
        UIView *lastObject = [self.subviews lastObject];
        
        self.contentSize = CGSizeMake(lastObject.frame.origin.x + lastObject.frame.size.width + 20, self.superview.bounds.size.height*[Utilities percentageScreen]);
    }
}

- (void) addStampWithFrame:(CGRect)frame character:(char)character count:(NSInteger)cnt time:(NSTimeInterval)time andParent:(UIScrollView *)parent
{
    UILabel *label = [[UILabel alloc] init];
    label.tag = cnt;
    [label setFont:[UIFont fontWithName:@"Sound FX" size:[Utilities sizeFrame]]];
    label.textColor = [UIColor whiteColor];
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
            case ST_STAMP:
            {
                if ([self.selectionDelegate respondsToSelector:@selector(didTouchStamp:)])
                {
                    UILabel *label = (UILabel *)recognizer.view;
                    [self.selectionDelegate didTouchStamp:[label.text UTF8String][0]];
                }
                break;
            }
                
            default:
                break;
        }
    }
}

@end
