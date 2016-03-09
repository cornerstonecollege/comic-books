//
//  ViewController.m
//  comic-books
//
//  Created by CICCC1 on 2016-03-08.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "ViewController.h"
#import "ImageFilterHelper.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UIImageView *imgViewChanged;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self changeImage];
}

- (void) changeImage
{
    CGFloat centerX = self.imgView.bounds.origin.x + self.imgView.bounds.size.width / 2.0;
    CGFloat centerY = self.imgView.bounds.origin.y + self.imgView.bounds.size.height / 2.0;
    self.imgViewChanged.image = [[ImageFilterHelper sharedInstance] lineOverlayImageWithImage:self.imgView.image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
