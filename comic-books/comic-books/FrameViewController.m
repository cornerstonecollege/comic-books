//
//  FrameViewController.m
//  comic-books
//
//  Created by Hiroshi on 3/9/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "FrameViewController.h"
#import "TabBarController.h"
#import "QuartzCore/QuartzCore.h"

@interface FrameViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic) NSArray *layoutArray;
@property (nonatomic, weak) UIView *commonView;
@property (nonatomic, weak) UIView *mainView;
@property (nonatomic) UIView *dialogView;
@property (nonatomic) UIImageView *imgView1;
@property (nonatomic) UIImageView *imgView2;
@property (nonatomic) UIImageView *imgView3;
@property (nonatomic) UIImageView *imgView4;
@property (nonatomic) CGFloat percentagePopup;
@property (nonatomic) NSInteger imgFlg;

@end

@implementation FrameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.commonView = ((TabBarController *)self.tabBarController).commonView;
    self.mainView = ((TabBarController *)self.tabBarController).mainView;
    [self.view addSubview:self.commonView];
    self.percentagePopup = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 0.10 : 0.15;
}

- (void) tabBarClickedFromSomewhere:(BOOL)isInitialization;
{
    // claim the view to itself
    [self.view addSubview:self.commonView];
    
    self.layoutArray = @[@"w1.png", @"w2.png", @"w3.png", @"w4.png", @"w5.png", @"w1.png", @"w2.png", @"w3.png", @"w4.png"];
    
    CGPoint point = CGPointMake(self.commonView.center.x, self.commonView.center.y);
    CGFloat tabBarTop = [[[self tabBarController] tabBar] frame].origin.y;
    
    if(self.parentViewController && [self.parentViewController isKindOfClass:[TabBarController class]])
    {
        TabBarController *obj = (TabBarController *)self.parentViewController;
        point = CGPointMake(self.commonView.center.x, self.commonView.center.y - obj.tabBar.frame.size.height);
    }
    
    UIScrollView *layoutView = [self createScrollViewBottom];
    
    if (isInitialization)
    {
        [self makeLayoutWithFrame:CGRectMake(self.mainView.frame.size.width * 0.01,
                                         self.mainView.frame.size.height * 0.01,
                                         self.mainView.frame.size.width*0.98,
                                         self.mainView.frame.size.height*0.98) parent:self.mainView imageView:self.imgView1 andTag:1];
        [self createLayouts:self.mainView andType:[self.imgView1 tag]];
    }
    
    float moveX = layoutView.frame.size.width / 2;
    float moveY = tabBarTop - self.commonView.bounds.size.height*self.percentagePopup + layoutView.frame.size.height/2;
    [UIView animateWithDuration:0.5 animations:^{
        layoutView.center = CGPointMake(moveX, moveY);
    } completion:^(BOOL finished) {
        
        float xPosition = 50;
        float time = 0;
        NSInteger cnt = 1;
        for (NSString * name in self.layoutArray)
        {
            [self addImageSize:CGRectMake(xPosition, self.commonView.bounds.size.height*self.percentagePopup/4, 50, 50) name:name count:cnt time:time andParent:layoutView];
            xPosition += 100;
            time += 0.05;
            cnt +=1;
        }
    }];
}

- (UIScrollView *) createScrollViewBottom
{
    __block UIScrollView *layoutView = nil;
    
    [self.commonView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIScrollView class]])
            layoutView = (UIScrollView *)obj;
    }];
    
    if (!layoutView)
    {
        layoutView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                   self.commonView.frame.size.height - self.tabBarController.tabBar.frame.size.height - self.commonView.bounds.size.height*self.percentagePopup,
                                                   self.commonView.bounds.size.width,
                                                   self.commonView.bounds.size.height*self.percentagePopup)];
        [self.commonView addSubview:layoutView];
    }
    else
    {
        [layoutView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    
    layoutView.backgroundColor = [UIColor colorWithRed:96.0f/255.0f green:96.0f/255.0f blue:96.0f/255.0f alpha:1.0];
    layoutView.contentSize = CGSizeMake(self.layoutArray.count*100, self.commonView.bounds.size.height*0.15);
    
    return layoutView;
}

- (void) addImageSize:(CGRect)size name:(NSString *)name count:(NSInteger)cnt time:(NSTimeInterval)time andParent:(UIScrollView *)parent
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:size];
    imageView.tag = cnt;
    [imageView setImage:[UIImage imageNamed:name]];
    
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [imageView addGestureRecognizer:tap];
    
    [parent addSubview:imageView];
    
    imageView.center = CGPointMake(size.origin.x, parent.frame.size.height + size.size.height / 2);
    [UIView animateWithDuration:time animations:^{
        imageView.center = CGPointMake(size.origin.x, size.origin.y + size.size.height / 2);
    }];
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer  {
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
    [self clearChildrenMainView];
    [self createLayouts:self.mainView andType:[imageView tag]];
}

- (void)createLayouts:(UIView*)parent andType:(NSInteger)number
{
    [self.dialogView removeFromSuperview];
    float standardSize = parent.frame.size.width;
    switch(number)
    {
        case 1:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.98, standardSize*0.98) parent:parent imageView:self.imgView1 andTag:1];
            break;
        case 2:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.98, standardSize*0.485) parent:parent imageView:self.imgView1 andTag:1];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:parent imageView:self.imgView2 andTag:2];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:parent imageView:self.imgView3 andTag:3];
            break;
        case 3:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:parent imageView:self.imgView1 andTag:1];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:parent imageView:self.imgView2 andTag:2];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.98, standardSize*0.485) parent:parent imageView:self.imgView3 andTag:3];
            break;
        case 4:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.485, standardSize*0.98) parent:parent imageView:self.imgView1 andTag:1];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:parent imageView:self.imgView2 andTag:2];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:parent imageView:self.imgView3 andTag:3];
            break;
        case 5:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:parent imageView:self.imgView1 andTag:1];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.01, standardSize*0.485, standardSize*0.98) parent:parent imageView:self.imgView2 andTag:2];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:parent imageView:self.imgView3 andTag:3];
            break;
        case 6:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:parent imageView:self.imgView1 andTag:1];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.01, standardSize*0.485, standardSize*0.485) parent:parent imageView:self.imgView2 andTag:2];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:parent imageView:self.imgView3 andTag:3];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.505, standardSize*0.485, standardSize*0.485) parent:parent imageView:self.imgView4 andTag:4];
            break;
        case 7:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.98, standardSize*0.485) parent:parent imageView:self.imgView1 andTag:1];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.32, standardSize*0.485) parent:parent imageView:self.imgView2 andTag:2];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.34, standardSize*0.505, standardSize*0.32, standardSize*0.485) parent:parent imageView:self.imgView3 andTag:3];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.67, standardSize*0.505, standardSize*0.32, standardSize*0.485) parent:parent imageView:self.imgView4 andTag:4];
            break;
        case 8:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.485, standardSize*0.98) parent:parent imageView:self.imgView1 andTag:1];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.01, standardSize*0.485, standardSize*0.32) parent:parent imageView:self.imgView2 andTag:2];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.34, standardSize*0.485, standardSize*0.32) parent:parent imageView:self.imgView3 andTag:3];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.505, standardSize*0.67, standardSize*0.485, standardSize*0.32) parent:parent imageView:self.imgView4 andTag:4];
            break;
        case 9:
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.01, standardSize*0.3, standardSize*0.485) parent:parent imageView:self.imgView1 andTag:1];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.32, standardSize*0.01, standardSize*0.67, standardSize*0.485) parent:parent imageView:self.imgView2 andTag:2];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.01, standardSize*0.505, standardSize*0.67, standardSize*0.485) parent:parent imageView:self.imgView3 andTag:3];
            [self makeLayoutWithFrame:CGRectMake(standardSize*0.69, standardSize*0.505, standardSize*0.3, standardSize*0.485) parent:parent imageView:self.imgView4 andTag:4];
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

- (void)makeLayoutWithFrame:(CGRect)frame parent:(UIView *)parent imageView:(UIImageView *)image andTag:(NSInteger)tag
{
    image = [[UIImageView alloc] initWithFrame:frame];
    image.backgroundColor = [UIColor colorWithRed:244.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0];
    [parent addSubview:image];
    
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
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap:)];
    [plusLabel addGestureRecognizer:tapGesture];
    
    [parent addSubview:plusLabel];
}

- (void)labelTap:(UITapGestureRecognizer*)tapGestureRecognizer
{
    UILabel *currentLabel = (UILabel *)tapGestureRecognizer.view;
    switch (currentLabel.tag) {
        case 1:
            self.imgFlg = 1;
            break;
        case 2:
            self.imgFlg = 2;
            break;
        case 3:
            self.imgFlg = 3;
            break;
        case 4:
            self.imgFlg = 4;
            break;
    }
    
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
    cancelLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    cancelLabel.userInteractionEnabled = YES;
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
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    switch (self.imgFlg) {
        case 1:
            self.imgView1.image = chosenImage;
            [self.mainView addSubview:self.imgView1];
            NSLog(@"img1");
            break;
        case 2:
            self.imgView2.image = chosenImage;
            [self.mainView addSubview:self.imgView2];
            break;
        case 3:
            self.imgView3.image = chosenImage;
            [self.mainView addSubview:self.imgView3];
            break;
        case 4:
            self.imgView4.image = chosenImage;
            [self.mainView addSubview:self.imgView4];
            break;
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)cancelTap
{
    [self.dialogView removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

