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

+ (CGFloat)percentageScreen
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 0.10 : 0.15;
}

+ (CGFloat)sizeFrame
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return 80;
    else if ([[UIScreen mainScreen] bounds].size.height < 568)
        return 60;
    else
        return 100;
}

@end
