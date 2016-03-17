//
//  MainViewController.h
//  comic-books
//
//  Created by Hiroshi on 3/14/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectionView.h"

@interface MainViewController : UIViewController <SelectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic) NSInteger imgFlag;
@property (nonatomic) UIView * _Nonnull dialogView;

- (void) makeLayoutWithFrame:(CGRect)frame parent:( UIView * _Nonnull)parent andTag:(NSInteger)tag;
- (void) clearChildrenMainView;
- (void) dismissDialogView;
- (void) setImgFlag:(NSInteger)tag;
- (void) createPopupImageWithSize:(CGRect)size imageName:(NSString * _Nonnull)name target:(_Nonnull id)target andFunction:(nonnull SEL)function;

@end
