//
//  MainViewController.m
//  comic-books
//
//  Created by Hiroshi on 3/14/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "MainViewController.h"
#import "Utilities.h"
#import "FrameHelper.h"
#import "ImageFilterHelper.h"
#import "StampGestureHelper.h"
#import "DialogHelper.h"
#import "SpeechBubbleView.h"
#import "FilterHelper.h"

@interface MainViewController ()

@property (nonatomic) UIView *mainView;
@property (nonatomic) UIView *tabView;
@property (nonatomic) NSArray<SelectionView *> *selectionArr;
@property (nonatomic) UIImage *originalChosenImage1;
@property (nonatomic) UIImage *originalChosenImage2;
@property (nonatomic) UIImage *originalChosenImage3;
@property (nonatomic) UIImage *originalChosenImage4;
@property (nonatomic) NSUInteger typeFrame;

@end

@implementation MainViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self createMainView];
    [self initializeView];
}

- (void) createMainView
{    
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width*0.01,
                                                             [Utilities startPositionMainView],
                                                             self.view.bounds.size.width*0.98,
                                                             self.view.bounds.size.width*0.98)];
    self.mainView.backgroundColor = [UIColor whiteColor];
    self.mainView.clipsToBounds = YES;
    [self.view addSubview:self.mainView];
}

- (void) initializeView
{
    self.view.backgroundColor = [Utilities specialGrayColor];
    
    SelectionView *selectionFilter = [[SelectionView alloc] initWithType:ST_FILTER andFrame:CGRectMake(0, self.view.frame.size.height - [Utilities sizeFrame], self.view.frame.size.width, [Utilities sizeFrame])];
    selectionFilter.selectionDelegate = self;
    [self.view addSubview:selectionFilter];
    
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
    
    self.selectionArr = @[selectionFrame, selectionFilter, selectionStamp, selectionSpeechBubble];
    
    [self createTabBar];
    [[FrameHelper sharedInstance] createLayouts:self.mainView type:1 andViewController:self];
    
    [self createBarButton];
}


- (void) createBarButton
{
    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0,
                                                                               0,
                                                                               self.view.bounds.size.width,
                                                                               [Utilities sizeBarHeightSize])];
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareContent)];
    
    UINavigationItem *item = [[UINavigationItem alloc] init];
    item.rightBarButtonItem = shareButton;
    
    UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoButton addTarget:self action:@selector(showInfoView) forControlEvents:UIControlEventTouchUpInside];
    item.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    
    navBar.items = [NSArray arrayWithObject:item];
    
    [self.view addSubview:navBar];
    [self.view bringSubviewToFront:navBar];
}

- (void) showInfoView
{
    [self dismissDialogView];
    [self setDialogView:[[UIView alloc] initWithFrame:CGRectMake(self.mainView.bounds.size.width*0.1,
                                                                 self.view.bounds.size.height*0.15,
                                                                 self.mainView.bounds.size.width*0.8,
                                                                 self.mainView.bounds.size.height)]];
    self.dialogView.backgroundColor = [Utilities speacialLighterGrayColor];
    self.dialogView.layer.cornerRadius = 25;
    self.dialogView.layer.masksToBounds = YES;
    
    [self createText];
    
    UILabel *cancelLabel = [self createLabelWithSize:CGRectMake(self.dialogView.bounds.size.width*0.5,
                                                                self.dialogView.bounds.size.height*0.80,
                                                                self.dialogView.bounds.size.width*0.5,
                                                                self.dialogView.bounds.size.height*0.15) text:@"Back" color:[Utilities superLightGrayColor]];
    cancelLabel.font = [UIFont fontWithName:@"Bangers" size:25];
    UITapGestureRecognizer *cancelGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap)];
    [cancelLabel addGestureRecognizer:cancelGesture];
    
    [self.dialogView addSubview:cancelLabel];
    [self.view addSubview:self.dialogView];
}

- (void) createText
{
    [self initTextViewWithSize:CGRectMake(self.dialogView.bounds.size.width*0.1,
                                          self.dialogView.bounds.size.height*0.1,
                                          self.dialogView.bounds.size.width*0.8,
                                          self.dialogView.bounds.size.height*0.2)
                          text:@"Created By" andFontSize:25];
    
    [self initTextViewWithSize:CGRectMake(self.dialogView.bounds.size.width*0.15,
                                          self.dialogView.bounds.size.height*0.3,
                                          self.dialogView.bounds.size.width*0.75,
                                          self.dialogView.bounds.size.height*0.5)
                          text:@"Luiz Peres\nHiroshi Tokutomi\nSreekanth Jagadeesan\nTomoko Tamura\nShawn Kyler" andFontSize:20];
    
    [self initTextViewWithSize:CGRectMake(self.dialogView.bounds.size.width*0.1,
                                          self.dialogView.bounds.size.height*0.7,
                                          self.dialogView.bounds.size.width*0.8,
                                          self.dialogView.bounds.size.height*0.1)
                          text:@"Copyright@2016 CICCC ALL Rights Reserved" andFontSize:13];
}

- (void) initTextViewWithSize:(CGRect)size text:(NSString*)text andFontSize:(NSInteger)font
{
    UITextView *textView = [[UITextView alloc]initWithFrame:size];
    textView.textColor = [Utilities superLightGrayColor];
    textView.backgroundColor = [UIColor clearColor];
    textView.text = text;
    textView.editable = NO;
    textView.font = [UIFont fontWithName:@"Bangers" size:font];
    
    [self.dialogView addSubview:textView];
}

- (void) cancelTap
{
    [self dismissDialogView];
}

- (void) createTabBar
{
    UIView *tabView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                               self.mainView.frame.origin.y + self.mainView.frame.size.height,
                                                               self.view.frame.size.width,
                                                               [Utilities sizeFrame])];
    [self.view addSubview:tabView];
    
    NSArray *arrayOfImages = @[@"layout_icon",  @"filter_icon", @"speech_bubble_icon", @"stamp_icon"];
    SELECTION_TYPE typeItem[4] = { ST_FRAME, ST_FILTER , ST_SPEECH_BUBBLE, ST_STAMP };
    for (int i = 0; i < [arrayOfImages count]; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:arrayOfImages[i]]];
        CGFloat size = [Utilities sizeIconWithParentSize:tabView.frame.size.width];
        imageView.frame = CGRectMake(0, 0, size, size);
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

- (void) clearChildrenMainView
{
    [self.mainView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         [obj removeFromSuperview];
     }];
}

- (void) dismissDialogView
{
    [self.dialogView removeFromSuperview];
}

- (void)makeLayoutWithFrame:(CGRect)frame parent:(UIView *)parent andTag:(NSInteger)tag
{
    UIImageView *image = [[UIImageView alloc] initWithFrame:frame];
    image.backgroundColor = [UIColor colorWithRed:244.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0];
    [parent addSubview:image];
    image.tag = -tag;
    image.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTap:)];
    [image addGestureRecognizer:tap];
    
    UILabel *plusLabel = [[UILabel alloc]init];
    plusLabel.text = @"+";
    plusLabel.tag = tag;
    plusLabel.font=[UIFont fontWithName:@"Helvetica" size:50];
    plusLabel.textAlignment = NSTextAlignmentCenter;
    [plusLabel sizeToFit];
    plusLabel.textColor = [Utilities heroBlueColor];
    plusLabel.center = image.center;
    
    plusLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(plusTap:)];
    [plusLabel addGestureRecognizer:tapGesture];
    
    UIImageView *waterImageView = [[UIImageView alloc]init];
    waterImageView.image = [UIImage imageNamed:@"water_mark"];
    waterImageView.frame = CGRectMake(parent.bounds.size.width - waterImageView.image.size.width - parent.bounds.size.width*0.01,
                                      parent.bounds.size.height - waterImageView.image.size.height - parent.bounds.size.width*0.01,
                                      waterImageView.image.size.width,
                                      waterImageView.image.size.height);
    [parent addSubview:waterImageView];
    waterImageView.layer.zPosition = 10;
    
    [parent addSubview:plusLabel];
}

- (void) handleImageTap:(UITapGestureRecognizer*)tapGestureRecognizer
{
    UIView *view = tapGestureRecognizer.view; //cast pointer to the derived class if needed
    self.imgFlag = view.tag;
}

- (void) didTouchFrame:(TYPE_FRAME)typeFrame
{
    self.typeFrame = typeFrame;
    
    if (self.typeFrame == labs(self.imgFlag))
    {
        return;
    }
    
    if (!self.originalChosenImage1 && !self.originalChosenImage2 && !self.originalChosenImage3 && !self.originalChosenImage4) {
        [[FrameHelper sharedInstance] createLayouts:self.mainView type:self.typeFrame andViewController:self];
        return;
    }
    
    [self dismissDialogView];
    [self setDialogView:[[UIView alloc] initWithFrame:CGRectMake(self.mainView.bounds.size.width*0.1,
                                                                 self.mainView.bounds.size.height*0.35,
                                                                 self.mainView.bounds.size.width*0.8,
                                                                 self.mainView.bounds.size.height*0.8)]];
    self.dialogView.backgroundColor = [Utilities speacialLighterGrayColor];
    self.dialogView.layer.cornerRadius = 25;
    self.dialogView.layer.masksToBounds = YES;
    
    [self initTextViewWithSize:CGRectMake(self.dialogView.bounds.size.width*0.1,
                                          self.dialogView.bounds.size.height*0.1,
                                          self.dialogView.bounds.size.width*0.8,
                                          self.dialogView.bounds.size.height*0.8)
                          text:@"The pictures in this frame are going to be deleted.\nContinue?" andFontSize:25];
    
    UILabel *yesLabel = [self createLabelWithSize:CGRectMake(self.dialogView.bounds.size.width*0.6,
                                                              self.dialogView.bounds.size.height*0.80,
                                                              self.dialogView.bounds.size.width*0.3,
                                                              self.dialogView.bounds.size.height*0.15) text:@"yes" color:[Utilities superLightGrayColor]];
    yesLabel.font = [UIFont fontWithName:@"Bangers" size:25];
    UITapGestureRecognizer *yesGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yesTap)];
    [yesLabel addGestureRecognizer:yesGesture];
    
    UILabel *noLabel = [self createLabelWithSize:CGRectMake(self.dialogView.bounds.size.width*0.1,
                                                            self.dialogView.bounds.size.height*0.80,
                                                            self.dialogView.bounds.size.width*0.3,
                                                            self.dialogView.bounds.size.height*0.15) text:@"No" color:[Utilities heroRedColor]];
    noLabel.font = [UIFont fontWithName:@"Bangers" size:25];
    UITapGestureRecognizer *noGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap)];
    [noLabel addGestureRecognizer:noGesture];

    [self.dialogView addSubview:yesLabel];
    [self.dialogView addSubview:noLabel];
    [self.view addSubview:self.dialogView];
}


- (UILabel *) createLabelWithSize:(CGRect)size text:(NSString *)text color:(UIColor *)color
{
    UILabel *label = [[UILabel alloc]initWithFrame:size];
    label.text = text;
    label.textColor = color;
    label.userInteractionEnabled = YES;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void) yesTap
{
    [self dismissDialogView];
    self.originalChosenImage1 = nil;
    self.originalChosenImage2 = nil;
    self.originalChosenImage3 = nil;
    self.originalChosenImage4 = nil;
    [[FrameHelper sharedInstance] createLayouts:self.mainView type:self.typeFrame andViewController:self];
}

- (void) didTouchFilter:(TYPE_STYLE_FILTER)typeFilter
{
    UIImageView *imageView = (UIImageView*)[self.mainView viewWithTag:self.imgFlag];
    
    if (self.imgFlag)
    {
        UIImage * currentImage = [self currentImage];
        if (currentImage != nil) {
            imageView.image = [FilterHelper imageFilterWithParent:self.mainView type:typeFilter andOriginalImage:currentImage];
        }
    }
}

- (UIImage *) currentImage
{
    UIImage *currentImage= nil;
    switch (labs(self.imgFlag)) {
        case 1:
            currentImage = self.originalChosenImage1;
            break;
        case 2:
            currentImage = self.originalChosenImage2;
            break;
        case 3:
            currentImage = self.originalChosenImage3;
            break;
        case 4:
            currentImage = self.originalChosenImage4;
            break;
    }
    return currentImage;
}

- (void) setCurrentImage:(UIImage *)img
{
    switch (labs(self.imgFlag)) {
        case 1:
            self.originalChosenImage1 = img;
            break;
        case 2:
            self.originalChosenImage2 = img;
            break;
        case 3:
            self.originalChosenImage3 = img;
            break;
        case 4:
            self.originalChosenImage4 = img;
            break;
    }
}

- (void) plusTap:(UITapGestureRecognizer*)tapGestureRecognizer
{
    [[DialogHelper sharedInstance] handlePlusTapWithTag:tapGestureRecognizer.view.tag andViewController:self];
}

- (void) createPopupImageWithSize:(CGRect)size imageName:(NSString*)name target:(id)target andFunction:(nonnull SEL)function
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:size];
    [imageView setImage:[UIImage imageNamed:name]];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:target action:function];
    [imageView addGestureRecognizer:tap];
    [self.dialogView addSubview:imageView];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{    
    [self dismissDialogView];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    UIImage * currentImage = info[UIImagePickerControllerEditedImage];
    [self setCurrentImage:currentImage];
    
    UIImageView *imageView = (UIImageView*)[self.mainView viewWithTag:self.imgFlag];

    // customize images
    UIImage *editedImage = [[ImageFilterHelper sharedInstance] CMYKHalftoneImageWithImage:currentImage andCenter:[CIVector vectorWithX:imageView.frame.size.width/2 Y:imageView.frame.size.height/2]];
    
    imageView.image = editedImage;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
}

- (void) didTouchStamp:(char)codeStamp
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
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:[StampGestureHelper sharedInstance] action:@selector(handleLongPress:)];
    [longPress setMinimumPressDuration:0.5];
    [label addGestureRecognizer:longPress];
    
    [self.mainView addSubview:label];
}

-(void) shareContent
{
    NSString * message = @"Share Images";
    for (UIView *subview in [self.mainView subviews]){
        if ([subview isKindOfClass:[UILabel class]] && subview.tag)
        {
            subview.hidden = YES;
        }
    }
    
    UIImage * image = [self imageWithView:self.mainView];
    NSArray * shareItems = @[message, image];
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    //if iPhone
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentViewController:avc animated:YES completion:nil];
    }
    //if iPad
    else {
        // Change Rect to position Popover
        avc.modalPresentationStyle = UIModalPresentationPopover;
        avc.popoverPresentationController.sourceView = self.mainView;
        [self presentViewController:avc animated:YES completion:nil];
    }
    
    for (UIView *subview in [self.mainView subviews]){
        if ([subview isKindOfClass:[UILabel class]] && subview.tag)
        {
            subview.hidden = NO;
        }
    }
}

- (void) didTouchSpeechBubble:(char)codeBubble
{
    SpeechBubbleView *speech = [[SpeechBubbleView alloc] initWithCode:codeBubble andParent:self.mainView];
    [self.mainView addSubview:speech];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}


@end
