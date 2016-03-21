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
    UIImage *editedImage;
    if(type <= 6)
    {
        editedImage = [[ImageFilterHelper sharedInstance] CMYKHalftoneImageWithImage:originalImage andCenter:center];
    }else if (type >= 7 && 12 >= type)
    {
        editedImage = [[ImageFilterHelper sharedInstance] hexPixellateImageWithImage:originalImage andCenter:center];
    }else if (type >= 13 && 18 >= type)
    {
        editedImage = [[ImageFilterHelper sharedInstance] pixellateImageWithImage:originalImage andCenter:center];
    }else if (type >= 19 && 24 >= type)
    {
        editedImage = [[ImageFilterHelper sharedInstance] pointillizeImageWithImage:originalImage andCenter:center];
    }
    int rest = type % 6;

    // customize images
    switch (rest) {
        case 0:
            editedImage = [[ImageFilterHelper sharedInstance] hueImageWithImage:editedImage];
            break;
        case 1:
            break;
        case 2:
            editedImage = [[ImageFilterHelper sharedInstance] photoTonalImageWithImage:editedImage];
            break;
        case 3:
            editedImage = [[ImageFilterHelper sharedInstance] colorClampImageWithImage:editedImage];
            break;
        case 4:
            editedImage = [[ImageFilterHelper sharedInstance] crossPolynomialImageWithImage:editedImage];
            break;
        case 5:
            editedImage = [[ImageFilterHelper sharedInstance] monochromeImageWithImage:editedImage];
            break;
    }
    return editedImage;
}

@end
