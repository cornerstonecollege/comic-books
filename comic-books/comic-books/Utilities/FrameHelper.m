//
//  FrameView.m
//  comic-books
//
//  Created by Hiroshi on 3/16/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "FrameHelper.h"
#import "MainViewController.h"

@implementation FrameHelper

+ (instancetype) sharedInstance
{
    static FrameHelper *instance;
    
    if (!instance)
    {
        instance = [[FrameHelper alloc] initPrivate];
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
    return self;
}

- (void) createLayouts:(UIView*)parent type:(NSInteger)number andViewController:(MainViewController *)mainVC
{
    [mainVC dismissDialogView];
    [mainVC clearChildrenMainView];

    float standardSize = parent.frame.size.width;
    switch(number)
    {
        case 1:
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.98, standardSize*0.98) parent:parent andTag:1];
            break;
        case 2:
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.98, standardSize*0.485) parent:parent  andTag:1];
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:parent  andTag:2];
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:parent  andTag:3];
            break;
        case 3:
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:parent  andTag:1];
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:parent  andTag:2];
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.98, standardSize*0.485) parent:parent  andTag:3];
            break;
        case 4:
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.485, standardSize*0.98) parent:parent  andTag:1];
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:parent  andTag:2];
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:parent  andTag:3];
            break;
        case 5:
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:parent  andTag:1];
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.01, standardSize*0.485, standardSize*0.98) parent:parent  andTag:2];
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:parent  andTag:3];
            break;
        case 6:
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:parent  andTag:1];
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:parent  andTag:2];
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:parent  andTag:3];
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:parent  andTag:4];
            break;
        case 7:
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.98, standardSize*0.485) parent:parent  andTag:1];
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.32, standardSize*0.485) parent:parent  andTag:2];
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.34, standardSize*0.505, standardSize*0.32, standardSize*0.485) parent:parent  andTag:3];
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.67, standardSize*0.505, standardSize*0.32, standardSize*0.485) parent:parent  andTag:4];
            break;
        case 8:
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.485, standardSize*0.98) parent:parent  andTag:1];
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.01, standardSize*0.485, standardSize*0.32) parent:parent  andTag:2];
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.34, standardSize*0.485, standardSize*0.32) parent:parent  andTag:3];
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.67, standardSize*0.485, standardSize*0.32) parent:parent  andTag:4];
            break;
        case 9:
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.3, standardSize*0.485) parent:parent  andTag:1];
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.32, standardSize*0.01, standardSize*0.67, standardSize*0.485) parent:parent  andTag:2];
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.67, standardSize*0.485) parent:parent  andTag:3];
            [mainVC makeLayoutWithFrame:CGRectMake(standardSize*0.69, standardSize*0.505, standardSize*0.3, standardSize*0.485) parent:parent  andTag:4];
            break;
    }
}

@end
