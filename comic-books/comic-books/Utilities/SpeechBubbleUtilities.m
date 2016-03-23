//
//  SpeechBubbleUtilities.m
//  comic-books
//
//  Created by Hiroshi on 3/22/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "SpeechBubbleUtilities.h"

@implementation SpeechBubbleUtilities

// speech bubble @
+ (UIEdgeInsets) sbSizeFirst
{
    if ([[UIScreen mainScreen] bounds].size.height < 568)
        return UIEdgeInsetsMake(40, 5, 0, 5);
    else
        return UIEdgeInsetsMake(50, 5, 0, 5);
}

+ (UIEdgeInsets) sbSize
{
    if ([[UIScreen mainScreen] bounds].size.height < 568)
        return UIEdgeInsetsMake(20, 5, 0, 5);
    else
        return UIEdgeInsetsMake(30, 0, 0, 0);
}

+ (UIEdgeInsets) sbSizeP
{
    if ([[UIScreen mainScreen] bounds].size.height < 568)
        return UIEdgeInsetsMake(30, 10, 0, 10);
    else
        return UIEdgeInsetsMake(50, 10, 0, 10);
}

+ (UIEdgeInsets) sbSizeD
{
    if ([[UIScreen mainScreen] bounds].size.height < 568)
        return UIEdgeInsetsMake(20, 5, 0, 5);
    else
        return UIEdgeInsetsMake(30, 10, 0, 10);
}

+ (UIEdgeInsets) sbSizeS
{
    if ([[UIScreen mainScreen] bounds].size.height < 568)
        return UIEdgeInsetsMake(20, 0, 0, 0);
    else
        return UIEdgeInsetsMake(40, 10, 0, 10);
}

+ (UIEdgeInsets) sbSizeH
{
    if ([[UIScreen mainScreen] bounds].size.height < 568)
        return UIEdgeInsetsMake(10, 15, 0, 10);
    else
        return UIEdgeInsetsMake(30, 15, 0, 10);
}

+ (UIEdgeInsets) sbSizeI
{
    if ([[UIScreen mainScreen] bounds].size.height < 568)
        return UIEdgeInsetsMake(10, 0, 0, 0);
    else
        return UIEdgeInsetsMake(30, 10, 0, 10);
}

+ (UIEdgeInsets) sbSizeJ
{
    if ([[UIScreen mainScreen] bounds].size.height < 568)
        return UIEdgeInsetsMake(30, 15, 0, 5);
    else
        return UIEdgeInsetsMake(55, 25, 0, 15);
}

+ (UIEdgeInsets) sbSizeK
{
    if ([[UIScreen mainScreen] bounds].size.height < 568)
        return UIEdgeInsetsMake(20, 10, 0, 10);
    else
        return UIEdgeInsetsMake(55, 10, 0, 28);
}

+ (UIEdgeInsets) sbSizeL
{
    if ([[UIScreen mainScreen] bounds].size.height < 568)
        return UIEdgeInsetsMake(10, 15, 0, 10);
    else
        return UIEdgeInsetsMake(30, 20, 0, 15);
}

+ (UIEdgeInsets) sbSizeM
{
    if ([[UIScreen mainScreen] bounds].size.height < 568)
        return UIEdgeInsetsMake(20, 10, 0, 5);
    else
        return UIEdgeInsetsMake(40, 20, 0, 15);
}

+ (UIEdgeInsets) sbSizeN
{
    if ([[UIScreen mainScreen] bounds].size.height < 568)
        return UIEdgeInsetsMake(15, 15, 0, 15);
    else
        return UIEdgeInsetsMake(45, 20, 0, 25);
}

+ (UIEdgeInsets) sbSizeO
{
    if ([[UIScreen mainScreen] bounds].size.height < 568)
        return UIEdgeInsetsMake(20, 5, 0, 5);
    else
        return UIEdgeInsetsMake(50, 15, 0, 15);
}

+ (UIEdgeInsets) sbSizeQ
{
    if ([[UIScreen mainScreen] bounds].size.height < 568)
        return UIEdgeInsetsMake(30, 10, 0, 10);
    else
        return UIEdgeInsetsMake(50, 10, 0, 10);
}

+ (UIEdgeInsets) sbSizeT
{
    if ([[UIScreen mainScreen] bounds].size.height < 568)
        return UIEdgeInsetsMake(20, 5, 0, 5);
    else
        return UIEdgeInsetsMake(40, 15, 0, 15);
}

@end
