//
//  Utilities.m
//  comic-books
//
//  Created by Hiroshi on 3/14/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+ (UIColor *) specialGrayColor
{
    return [UIColor colorWithRed:64.0/255.0 green:64.0/255.0 blue:64.0/255.0 alpha:1.0];
}

+ (UIColor *)speacialLighterGrayColor
{
    return [UIColor colorWithRed:96.0f/255.0f green:96.0f/255.0f blue:96.0f/255.0f alpha:1.0];
}

+ (UIColor *)penelopeColor
{
    return [UIColor colorWithRed:192.0/255.0 green:24.0/255.0 blue:24.0/255.0 alpha:1.0];
}

+ (UIColor *)citrusColor
{
    return [UIColor colorWithRed:240.0/255.0 green:192.0/255.0 blue:72.0/255.0 alpha:1.0];
}

+ (UIColor *)oldVelvetColor
{
    return [UIColor colorWithRed:48.0/255.0 green:24.0/255.0 blue:0.0/255.0 alpha:1.0];
}

+ (UIColor *)specialRedColor
{
    return [UIColor colorWithRed:240.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0];
}

+ (UIColor *)toastedWheatColor
{
    return [UIColor colorWithRed:216.0/255.0 green:192.0/255.0 blue:120.0/255.0 alpha:1.0];
}

+ (UIColor *)drifterColor
{
    return [UIColor colorWithRed:40.0/255.0 green:138.0/255.0 blue:143.0/255.0 alpha:1.0];
}

+ (UIColor *)shallowWatersColor
{
    return [UIColor colorWithRed:126.0/255.0 green:174.0/255.0 blue:164.0/255.0 alpha:1.0];
}

+ (UIColor *)paleSunshineColor
{
    return [UIColor colorWithRed:236.0/255.0 green:241.0/255.0 blue:140.0/255.0 alpha:1.0];
}

+ (UIColor *)vitaminsColor
{
    return [UIColor colorWithRed:255.0/255.0 green:136.0/255.0 blue:48.0/255.0 alpha:1.0];
}

+ (UIColor *)wrestlingColor
{
    return [UIColor colorWithRed:237.0/255.0 green:29.0/255.0 blue:29.0/255.0 alpha:1.0];
}

+ (CGFloat)percentageScreen
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 0.10 : 0.15;
}

+ (CGFloat)sizeFrame
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return 80;
    else if ([[UIScreen mainScreen] bounds].size.height < 568)
        return 50;
    else
        return 100;
}

+ (CGFloat)colorSizeFrame
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return 20;
    else if ([[UIScreen mainScreen] bounds].size.height < 568)
        return 10;
    else
        return 30;
}

+ (CGFloat)sizeIconWithParentSize:(CGFloat)size
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return size / 4 * 0.2;
    else if ([[UIScreen mainScreen] bounds].size.height < 568)
        return size / 4 * 0.3;
    else
        return size / 4 * 0.5;
}
@end
