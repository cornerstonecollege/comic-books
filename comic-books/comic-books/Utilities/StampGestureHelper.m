//
//  StampGestureHelper.m
//  comic-books
//
//  Created by CICCC1 on 2016-03-15.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "StampGestureHelper.h"
#import "Utilities.h"

@interface StampGestureHelper ()

@property (nonatomic) NSArray *arrColors;

@end

@implementation StampGestureHelper

+ (instancetype) sharedInstance
{
    static StampGestureHelper *instance;
    
    if (!instance)
    {
        instance = [[StampGestureHelper alloc] initPrivate];
    }
    
    return instance;
}

- (instancetype) init
{
    @throw [NSException exceptionWithName:@"Wrong Initializer" reason:@"Please use sharedInstance" userInfo:nil];
}

- (instancetype) initPrivate
{
    self = [super init];
    if(self)
    {
        _arrColors = @[[UIColor whiteColor], [Utilities penelopeColor], [Utilities citrusColor], [Utilities oldVelvetColor], [Utilities specialRedColor], [Utilities toastedWheatColor], [Utilities wrestlingColor], [Utilities vitaminsColor], [Utilities paleSunshineColor], [Utilities shallowWatersColor], [Utilities drifterColor]];
    }
    
    return self;
}

- (void) handleTap:(UITapGestureRecognizer *)tapGesture
{
    UILabel *label = (UILabel *)tapGesture.view;
    for (int i = 0; i < [self.arrColors count]; i++)
    {
        if (label.textColor.CGColor == ((UIColor *)self.arrColors[i]).CGColor)
        {
            int j = i == [self.arrColors count] - 1 ? 0 : i + 1;
            label.textColor = (UIColor *)self.arrColors[j];
            break;
        }
    }
}

- (void) handleRotation:(UIRotationGestureRecognizer *)rotationGesture
{
    UILabel *label = (UILabel *)rotationGesture.view;
    [label setTransform:CGAffineTransformMakeRotation(rotationGesture.rotation)];
}

- (void) handlePinch:(UIPinchGestureRecognizer *)pinchGesture
{
    UILabel *label = (UILabel *)pinchGesture.view;
    CGFloat size = [Utilities sizeFrame]*pinchGesture.scale;
    size = (size < [Utilities sizeFrame] / 1.5) ? [Utilities sizeFrame] / 1.5 : size;
    size = (size > [Utilities sizeFrame] * 2) ? [Utilities sizeFrame] * 2 : size;
    
    [label setFont:[UIFont fontWithName:@"Sound FX" size:size]];
    [label sizeToFit];
}

- (void) handlePan:(UIPanGestureRecognizer *)panGesture
{
    // superview is self.mainView
    
    CGPoint point = [panGesture locationInView:panGesture.view.superview];
    
    if (point.x < panGesture.view.frame.size.width / 2)
    {
        point.x = panGesture.view.frame.size.width / 2;
    }
    else if (point.x > panGesture.view.superview.frame.size.width - panGesture.view.frame.size.width / 2)
    {
        point.x = panGesture.view.superview.frame.size.width - panGesture.view.frame.size.width / 2;
    }
    
    if (point.y <  panGesture.view.frame.size.height / 2)
    {
        point.y = panGesture.view.frame.size.height / 2;
    }
    else if (point.y > panGesture.view.superview.frame.size.height - panGesture.view.frame.size.height / 2)
    {
        point.y = panGesture.view.superview.frame.size.height - panGesture.view.frame.size.height / 2;
    }
    
    panGesture.view.center = CGPointMake(point.x, point.y);
}

@end
