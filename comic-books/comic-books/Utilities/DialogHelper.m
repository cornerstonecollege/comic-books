//
//  dialogHelper.m
//  comic-books
//
//  Created by Hiroshi on 3/16/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "DialogHelper.h"
#import "MainViewController.h"

@interface DialogHelper ()

@property (nonatomic, weak) MainViewController *mainVC;

@end

@implementation DialogHelper

+ (instancetype) sharedInstance
{
    static DialogHelper *instance;
    
    if (!instance)
    {
        instance = [[DialogHelper alloc] initPrivate];
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

- (void) handlePlusTapWithTag:(NSInteger)tag andViewController:(MainViewController *)mainVC
{
    if (!self.mainVC)
    {
        self.mainVC = mainVC;
    }
    //self.imgFlag = -tag;
    [mainVC setImgFlag:-tag];
    
    [mainVC dismissDialogView];
    [mainVC setDialogView:[[UIView alloc] initWithFrame:CGRectMake(mainVC.view.bounds.size.width*0.2,
                                                              mainVC.view.bounds.size.height*0.25,
                                                              mainVC.view.bounds.size.width*0.6,
                                                              mainVC.view.bounds.size.height*0.3)]];
     
    mainVC.dialogView.backgroundColor = [UIColor colorWithRed:96.0f/255.0f green:96.0f/255.0f blue:96.0f/255.0f alpha:1.0];
    mainVC.dialogView.layer.cornerRadius = 25;
    mainVC.dialogView.layer.masksToBounds = YES;
    
    [mainVC createPopupImageWithSize:CGRectMake(mainVC.dialogView.bounds.size.width*0.1,
                                              mainVC.dialogView.bounds.size.height*0.25,
                                              mainVC.dialogView.bounds.size.width*0.35,
                                                mainVC.dialogView.bounds.size.width*0.35) imageName:@"camera.png" target:self andFunction:@selector(cameraTap)];
    
    [mainVC createPopupImageWithSize:CGRectMake(mainVC.dialogView.bounds.size.width*0.55,
                                              mainVC.dialogView.bounds.size.height*0.25,
                                              mainVC.dialogView.bounds.size.width*0.35,
                                              mainVC.dialogView.bounds.size.width*0.35) imageName:@"gallery.png" target:self andFunction:@selector(galleryTap)];
    
    UILabel *cancelLabel = [[UILabel alloc]initWithFrame:CGRectMake(mainVC.dialogView.bounds.size.width*0.5,
                                                                    mainVC.dialogView.bounds.size.height*0.80,
                                                                    mainVC.dialogView.bounds.size.width*0.5,
                                                                    mainVC.dialogView.bounds.size.height*0.15)];
    cancelLabel.text = @"cancel";
    cancelLabel.textColor = [UIColor colorWithRed:244.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0];
    cancelLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
    cancelLabel.userInteractionEnabled = YES;
    cancelLabel.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer *cancelGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap)];
    [cancelLabel addGestureRecognizer:cancelGesture];
    
    [self.mainVC.dialogView addSubview:cancelLabel];
    [self.mainVC.view addSubview:self.mainVC.dialogView];
}

- (void)cameraTap
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self.mainVC;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self.mainVC presentViewController:picker animated:YES completion:NULL];
}

- (void)galleryTap
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self.mainVC;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.mainVC presentViewController:picker animated:YES completion:NULL];
}

- (void)cancelTap
{
    [self.mainVC dismissDialogView];
}



@end
