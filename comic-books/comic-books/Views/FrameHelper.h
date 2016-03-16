//
//  FrameView.h
//  comic-books
//
//  Created by Hiroshi on 3/16/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainViewController;

@interface FrameHelper : NSObject

+ (instancetype) sharedInstance;
- (void)createLayouts:(UIView*)parent type:(NSInteger)number andViewController:(MainViewController *)mainVC;

@end
