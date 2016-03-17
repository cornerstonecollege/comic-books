//
//  FilterView.m
//  comic-books
//
//  Created by Hiroshi on 3/16/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import "FilterView.h"
#import "ImageFilterHelper.h"

@implementation FilterView

+ (UIImage *) imageFilterWithParent:(UIView *)mainView type:(NSInteger)type andOriginalImage:(UIImage*)originalImage
{
    CIVector * center = [CIVector vectorWithX:originalImage.size.width/2 Y:originalImage.size.height/2];

    // customize images
    UIImage *editedImage;
    switch (type) {
        case 1:
            editedImage = [[ImageFilterHelper sharedInstance] CMYKHalftoneImageWithImage:originalImage andCenter:center];
            break;
        case 2:
            editedImage = [[ImageFilterHelper sharedInstance] CMYKHalftoneImageWithImage:originalImage andCenter:center];
            editedImage = [[ImageFilterHelper sharedInstance] hueImageWithImage:editedImage];
            break;
        case 3:
            editedImage =  [[ImageFilterHelper sharedInstance] dotScreenImageWithImage:originalImage andCenter:center];
        default:
            break;
    }
    
    return editedImage;
}

@end
