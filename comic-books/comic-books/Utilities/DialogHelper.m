//
//  dialogHelper.m
//  comic-books
//
//  Created by Hiroshi on 3/16/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "DialogHelper.h"
#import "MainViewController.h"

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
    //self.imgFlag = -tag;
    [mainVC setImgFlag:-tag];
    
    //[self.dialogView removeFromSuperview];
    [mainVC.getDlogView removeFromSuperview];
    [mainVC setDlogView:[[UIView alloc] initWithFrame:CGRectMake(mainVC.view.bounds.size.width*0.2,
                                                              mainVC.view.bounds.size.height*0.25,
                                                              mainVC.view.bounds.size.width*0.6,
                                                              mainVC.view.bounds.size.height*0.3)]];
     
    [mainVC.getDlogView setBackgroundColor: [UIColor colorWithRed:96.0f/255.0f green:96.0f/255.0f blue:96.0f/255.0f alpha:1.0]];
    mainVC.getDlogView.layer.cornerRadius = 25;
    mainVC.getDlogView.layer.masksToBounds = YES;
    
    [mainVC createPopupImageWithSize:CGRectMake(mainVC.getDlogView.bounds.size.width*0.1,
                                              mainVC.getDlogView.bounds.size.height*0.25,
                                              mainVC.getDlogView.bounds.size.width*0.35,
                                                mainVC.getDlogView.bounds.size.width*0.35) imageName:@"camera.png" andFunction:@selector(cameraTap)];
    
    [mainVC createPopupImageWithSize:CGRectMake(mainVC.getDlogView.bounds.size.width*0.55,
                                              mainVC.getDlogView.bounds.size.height*0.25,
                                              mainVC.getDlogView.bounds.size.width*0.35,
                                              mainVC.getDlogView.bounds.size.width*0.35) imageName:@"gallery.png" andFunction:@selector(galleryTap)];
    
    UILabel *cancelLabel = [[UILabel alloc]initWithFrame:CGRectMake(mainVC.getDlogView.bounds.size.width*0.5,
                                                                    mainVC.getDlogView.bounds.size.height*0.80,
                                                                    mainVC.getDlogView.bounds.size.width*0.5,
                                                                    mainVC.getDlogView.bounds.size.height*0.15)];
    cancelLabel.text = @"cancel";
    cancelLabel.textColor = [UIColor colorWithRed:244.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0];
    cancelLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
    cancelLabel.userInteractionEnabled = YES;
    cancelLabel.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer *cancelGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap)];
    [cancelLabel addGestureRecognizer:cancelGesture];
    
    //[self.dialogView addSubview:galleryView];
    //[mainVC.getDlogView addSubview:cancelLabel];
    //[mainVC.view addSubview:mainVC.getDlogView];
}

- (void)cameraTap
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //picker.delegate = mainVC;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    //[mainVC presentViewController:picker animated:YES completion:NULL];
}

- (void)galleryTap
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //picker.delegate = mainVC;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //[mainVC presentViewController:picker animated:YES completion:NULL];
}

- (void)cancelTap
{
    //[mainVC.getDlogView removeFromSuperview];
}



@end
