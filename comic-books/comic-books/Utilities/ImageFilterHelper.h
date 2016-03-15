//
//  ImageFilterHelper.h
//  comic-books
//
//  Created by CICCC1 on 2016-03-08.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageFilterHelper : NSObject

+ (instancetype) sharedInstance;

- (UIImage *) hueImageWithImage:(UIImage *)img;
- (UIImage *) colorClampImageWithImage:(UIImage *)img;
- (UIImage *) crossPolynomialImageWithImage:(UIImage *)img;
- (UIImage *) monochromeImageWithImage:(UIImage *)img;
- (UIImage *) photoTonalImageWithImage:(UIImage *)img;

// NO
- (UIImage *) lineOverlayImageWithImage:(UIImage *)img;

// best for comic book style
- (UIImage *) CMYKHalftoneImageWithImage:(UIImage *)img andCenter:(CIVector *)center;

- (UIImage *) dotScreenImageWithImage:(UIImage *)img andCenter:(CIVector *)center;
- (UIImage *) hatchedScreenImageWithImage:(UIImage *)img andCenter:(CIVector *)center;
- (UIImage *) hexPixellateImageWithImage:(UIImage *)img andCenter:(CIVector *)center;
- (UIImage *) pixellateImageWithImage:(UIImage *)img andCenter:(CIVector *)center;
- (UIImage *) pointillizeImageWithImage:(UIImage *)img andCenter:(CIVector *)center;

@end
