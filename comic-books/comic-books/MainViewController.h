//
//  MainViewController.h
//  comic-books
//
//  Created by Hiroshi on 3/14/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

- (void)makeLayoutWithFrame:(CGRect)frame parent:(UIView *)parent andTag:(NSInteger)tag;
- (void) clearChildrenMainView;
- (void) dismissDialogView;

@end
