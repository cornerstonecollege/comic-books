//
//  dialogHelper.h
//  comic-books
//
//  Created by Hiroshi on 3/16/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainViewController;

@interface DialogHelper : UIView

+ (instancetype) sharedInstance;
- (void) handlePlusTapWithTag:(NSInteger)tag andViewController:(MainViewController *)mainVC;
- (void) handleLongPressStampWithViewController:(MainViewController *)mainVC;
- (void) createDialogWithView:(MainViewController*)mainVC;
- (void) backlLabelWithView:(MainViewController*)mainVC;

@end
