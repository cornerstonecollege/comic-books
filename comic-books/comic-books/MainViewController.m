//
//  MainViewController.m
//  comic-books
//
//  Created by Hiroshi on 3/14/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "MainViewController.h"
#import "Utilities.h"
#import "SelectionView.h"
#import "ImageFilterHelper.h"
#import "StampGestureHelper.h"
#import "SpeechBubbleView.h"

@interface MainViewController () <SelectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic) UIView *mainView;
@property (nonatomic) UIView *tabView;
@property (nonatomic) UIView *dialogView;
@property (nonatomic) NSArray<SelectionView *> *selectionArr;
@property (nonatomic) UIImage *originalChosenImage;

@property (nonatomic) NSInteger imgFlag;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createMainView];
    [self initializeView];
}

- (void) createMainView
{
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width*0.01,
                                                             self.view.bounds.size.height*0.09,
                                                             self.view.bounds.size.width*0.98,
                                                             self.view.bounds.size.width*0.98)];
    self.mainView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainView];
}

- (void) initializeView
{
    self.view.backgroundColor = [Utilities specialGrayColor];
    
    SelectionView *selectionFrame = [[SelectionView alloc] initWithType:ST_FRAME andFrame:CGRectMake(0, self.view.frame.size.height - [Utilities sizeFrame], self.view.frame.size.width, [Utilities sizeFrame])];
    selectionFrame.selectionDelegate = self;
    [self.view addSubview:selectionFrame];
    
    SelectionView *selectionStamp = [[SelectionView alloc] initWithType:ST_STAMP andFrame:CGRectMake(0, self.view.frame.size.height - [Utilities sizeFrame], self.view.frame.size.width, [Utilities sizeFrame])];
    [self.view addSubview:selectionStamp];
    selectionStamp.selectionDelegate = self;
    selectionStamp.hidden = YES;
    
    SelectionView *selectionSpeechBubble = [[SelectionView alloc] initWithType:ST_SPEECH_BUBBLE andFrame:CGRectMake(0, self.view.frame.size.height - [Utilities sizeFrame], self.view.frame.size.width, [Utilities sizeFrame])];
    [self.view addSubview:selectionSpeechBubble];
    selectionSpeechBubble.selectionDelegate = self;
    selectionSpeechBubble.hidden = YES;
    
    self.selectionArr = @[selectionFrame, selectionStamp, selectionSpeechBubble];
    
    [self createTabBar];
    [self createLayouts:self.mainView andType:1];
}

- (void) createTabBar
{
    UIView *tabView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mainView.frame.origin.y + self.mainView.frame.size.height, self.view.frame.size.width, [Utilities sizeFrame])];
    [self.view addSubview:tabView];
    
    NSArray *arrayOfImages = @[@"layout_icon",  @"filter_icon", @"speech_bubble_icon", @"stamp_icon"];
    SELECTION_TYPE typeItem[4] = { ST_FRAME, ST_FILTER , ST_SPEECH_BUBBLE, ST_STAMP };
    for (int i = 0; i < [arrayOfImages count]; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:arrayOfImages[i]]];
        imageView.center = CGPointMake(tabView.frame.size.width / [arrayOfImages count] * i + (tabView.frame.size.width / [arrayOfImages count] / 2), tabView.frame.size.height / 2);
        imageView.tag = typeItem[i];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTabTap:)];
        [imageView addGestureRecognizer:tap];
        [tabView addSubview:imageView];
    }
}

- (void) handleTabTap:(UITapGestureRecognizer *)tapGesture
{
    __block NSUInteger tag = tapGesture.view.tag;
    [self.selectionArr enumerateObjectsUsingBlock:^(SelectionView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (tag != ((SelectionView *)obj).type)
            obj.hidden = YES;
        else
            obj.hidden = NO;
    }];
}

- (void)createLayouts:(UIView*)parent andType:(NSInteger)number
{
    [self.dialogView removeFromSuperview];
    [self clearChildrenMainView];
    float standardSize = parent.frame.size.width;
    switch(number)
    {
        case 1:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.98, standardSize*0.98) parent:self.mainView andTag:1];
            break;
        case 2:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.98, standardSize*0.485) parent:self.mainView  andTag:1];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:self.mainView  andTag:2];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:self.mainView  andTag:3];
            break;
        case 3:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:self.mainView  andTag:1];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:self.mainView  andTag:2];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.98, standardSize*0.485) parent:self.mainView  andTag:3];
            break;
        case 4:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.485, standardSize*0.98) parent:self.mainView  andTag:1];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:self.mainView  andTag:2];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:self.mainView  andTag:3];
            break;
        case 5:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:self.mainView  andTag:1];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.01, standardSize*0.485, standardSize*0.98) parent:self.mainView  andTag:2];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:self.mainView  andTag:3];
            break;
        case 6:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:self.mainView  andTag:1];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:self.mainView  andTag:2];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:self.mainView  andTag:3];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:self.mainView  andTag:4];
            break;
        case 7:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.98, standardSize*0.485) parent:self.mainView  andTag:1];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.32, standardSize*0.485) parent:self.mainView  andTag:2];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.34, standardSize*0.505, standardSize*0.32, standardSize*0.485) parent:self.mainView  andTag:3];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.67, standardSize*0.505, standardSize*0.32, standardSize*0.485) parent:self.mainView  andTag:4];
            break;
        case 8:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.485, standardSize*0.98) parent:self.mainView  andTag:1];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.01, standardSize*0.485, standardSize*0.32) parent:self.mainView  andTag:2];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.34, standardSize*0.485, standardSize*0.32) parent:self.mainView  andTag:3];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.67, standardSize*0.485, standardSize*0.32) parent:self.mainView  andTag:4];
            break;
        case 9:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.3, standardSize*0.485) parent:self.mainView  andTag:1];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.32, standardSize*0.01, standardSize*0.67, standardSize*0.485) parent:self.mainView  andTag:2];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.67, standardSize*0.485) parent:self.mainView  andTag:3];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.69, standardSize*0.505, standardSize*0.3, standardSize*0.485) parent:self.mainView  andTag:4];
            break;
    }
}

- (void) clearChildrenMainView
{
    [self.mainView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         [obj removeFromSuperview];
     }];
}

- (void)makeLayoutWithFrame:(CGRect)frame parent:(UIView *)parent andTag:(NSInteger)tag
{
    UIImageView *image = [[UIImageView alloc] initWithFrame:frame];
    image.backgroundColor = [UIColor colorWithRed:244.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0];
    [parent addSubview:image];
    image.tag = -tag;
    
    UILabel *plusLabel = [[UILabel alloc]init];
    plusLabel.text = @"+";
    plusLabel.tag = tag;
    plusLabel.font=[UIFont fontWithName:@"Helvetica" size:50];
    plusLabel.textAlignment = NSTextAlignmentCenter;
    [plusLabel sizeToFit];
    plusLabel.textColor = [UIColor lightGrayColor];
    plusLabel.center = image.center;
    
    plusLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(plusTap:)];
    [plusLabel addGestureRecognizer:tapGesture];
    
    [parent addSubview:plusLabel];
}


- (void)didTouchFrame:(TYPE_FRAME)typeFrame
{
    [self createLayouts:self.mainView andType:typeFrame];
}

- (void)plusTap:(UITapGestureRecognizer*)tapGestureRecognizer
{
    [self handlePlusTapWithTag:tapGestureRecognizer.view.tag];
}

- (void) handlePlusTapWithTag:(NSInteger)tag
{
    self.imgFlag = -tag;
    
    [self.dialogView removeFromSuperview];
    self.dialogView = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.2,
                                                              self.view.bounds.size.height*0.25,
                                                              self.view.bounds.size.width*0.6,
                                                              self.view.bounds.size.height*0.3)];
    [self.dialogView setBackgroundColor: [UIColor colorWithRed:96.0f/255.0f green:96.0f/255.0f blue:96.0f/255.0f alpha:1.0]];
    self.dialogView.layer.cornerRadius = 25;
    self.dialogView.layer.masksToBounds = YES;
    
    [self createPopupImageWithSize:CGRectMake(self.dialogView.bounds.size.width*0.1,
                                              self.dialogView.bounds.size.height*0.25,
                                              self.dialogView.bounds.size.width*0.35,
                                              self.dialogView.bounds.size.width*0.35) imageName:@"camera.png" andFunction:@selector(cameraTap)];
    
    [self createPopupImageWithSize:CGRectMake(self.dialogView.bounds.size.width*0.55,
                                              self.dialogView.bounds.size.height*0.25,
                                              self.dialogView.bounds.size.width*0.35,
                                              self.dialogView.bounds.size.width*0.35) imageName:@"gallery.png" andFunction:@selector(galleryTap)];
    
    UILabel *cancelLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.dialogView.bounds.size.width*0.5,
                                                                    self.dialogView.bounds.size.height*0.80,
                                                                    self.dialogView.bounds.size.width*0.5,
                                                                    self.dialogView.bounds.size.height*0.15)];
    cancelLabel.text = @"cancel";
    cancelLabel.textColor = [UIColor colorWithRed:244.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0];
    cancelLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
    cancelLabel.userInteractionEnabled = YES;
    cancelLabel.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer *cancelGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap)];
    [cancelLabel addGestureRecognizer:cancelGesture];
    
    //[self.dialogView addSubview:galleryView];
    [self.dialogView addSubview:cancelLabel];
    [self.view addSubview:self.dialogView];
}


- (void)createPopupImageWithSize:(CGRect)size imageName:(NSString*)name andFunction:(nonnull SEL)function
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:size];
    [imageView setImage:[UIImage imageNamed:name]];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:function];
    [imageView addGestureRecognizer:tap];
    [self.dialogView addSubview:imageView];
}

- (void)cameraTap
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];}

- (void)galleryTap
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self.dialogView removeFromSuperview];
    self.originalChosenImage = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    UIImageView *imageView = (UIImageView*)[self.mainView viewWithTag:self.imgFlag];
    UIImage *editedImage = [[ImageFilterHelper sharedInstance] CMYKHalftoneImageWithImage:self.originalChosenImage andCenter:[CIVector vectorWithX:imageView.frame.size.width/2 Y:imageView.frame.size.height/2]];
    imageView.image = editedImage;

    // there is a bug on ios
    imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
}

- (void)cancelTap
{
    [self.dialogView removeFromSuperview];
}

- (void)didTouchStamp:(char)codeStamp
{
    [self createLabelWithChar:codeStamp];
}

- (void) createLabelWithChar:(char)codeStamp
{
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont fontWithName:@"Sound FX" size:[Utilities sizeFrame]]];
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"%c", codeStamp];
    [label sizeToFit];
    CGFloat width = arc4random_uniform(self.mainView.frame.size.width - label.frame.size.width) + label.frame.size.width / 2;
    CGFloat height = arc4random_uniform(self.mainView.frame.size.height - label.frame.size.height) + label.frame.size.height / 2;
    label.center = CGPointMake(width, height);
    
    label.userInteractionEnabled = YES;
    UIPinchGestureRecognizer *pinch =
    [[UIPinchGestureRecognizer alloc] initWithTarget:[StampGestureHelper sharedInstance] action:@selector(handlePinch:)];
    [label addGestureRecognizer:pinch];
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:[StampGestureHelper sharedInstance] action:@selector(handleRotation:)];
    [label addGestureRecognizer:rotation];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:[StampGestureHelper sharedInstance] action:@selector(handlePan:)];
    [label addGestureRecognizer:pan];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:[StampGestureHelper sharedInstance] action:@selector(handleTap:)];
    [label addGestureRecognizer:tap];
    
    [self.mainView addSubview:label];
}

- (void)didTouchSpeechBubble:(char)codeBubble
{
    SpeechBubbleView *speech = [[SpeechBubbleView alloc] initWithCode:codeBubble andParent:self.mainView];
    [self.mainView addSubview:speech];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
