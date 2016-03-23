//
//  ImageFilterHelper.m
//  comic-books
//
//  Created by CICCC1 on 2016-03-08.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <CoreImage/CoreImage.h>
#import "ImageFilterHelper.h"

@implementation ImageFilterHelper

+ (instancetype) sharedInstance
{
    static ImageFilterHelper *instance;
    
    if (!instance)
    {
        instance = [[ImageFilterHelper alloc] initPrivate];
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

- (UIImage *) applyFilter:(CIFilter *)filter atImage:(UIImage *)img
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:[img CGImage]];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    CIImage *result = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *imageResult = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return imageResult;
}

- (UIImage *) hueImageWithImage:(UIImage*)img
{
    CIFilter *filter = [CIFilter filterWithName:@"CIHueAdjust"];
    [filter setValue:[NSNumber numberWithDouble:3*M_PI/8] forKey:@"inputAngle"];
    UIImage *imageResult = [self applyFilter:filter atImage:img];
    
    return imageResult;
}

- (UIImage *) colorClampImageWithImage:(UIImage*)img
{
    CIFilter *filter = [CIFilter filterWithName:@"CIColorClamp"];
    CIVector *vectorMin = [CIVector vectorWithX:0.1 Y:0.1 Z:0.1 W:0.0];
    [filter setValue:vectorMin forKey:@"inputMinComponents"];
    CIVector *vectorMax = [CIVector vectorWithX:0.5 Y:0.5 Z:0.5 W:1.0];
    [filter setValue:vectorMax forKey:@"inputMaxComponents"];
    UIImage *imageResult = [self applyFilter:filter atImage:img];
    
    return imageResult;
}

- (UIImage *) crossPolynomialImageWithImage:(UIImage *)img
{
    CIFilter *filter = [CIFilter filterWithName:@"CIColorCrossPolynomial"];
    CIVector *vectorRed = [CIVector vectorWithString:@"1.0 1.0 1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0"];
    CIVector *vectorGreen = [CIVector vectorWithString:@"0.0 1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0"];
    CIVector *vectorBlue = [CIVector vectorWithString:@"1.0 1.0 1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0"];
    [filter setValue:vectorRed forKey:@"inputRedCoefficients"];
    [filter setValue:vectorGreen forKey:@"inputGreenCoefficients"];
    [filter setValue:vectorBlue forKey:@"inputBlueCoefficients"];
    UIImage *imageResult = [self applyFilter:filter atImage:img];
    
    return imageResult;
}

- (UIImage *) monochromeImageWithImage:(UIImage *)img
{
    CIFilter *filter = [CIFilter filterWithName:@"CIColorMonochrome"];
    CIColor *color = [CIColor colorWithRed:1.0 green:1.0 blue:0.0];
    [filter setValue:color forKey:@"inputColor"];
    [filter setValue:[NSNumber numberWithDouble:1.0] forKey:@"inputIntensity"];
    UIImage *imageResult = [self applyFilter:filter atImage:img];
    
    return imageResult;
}

- (UIImage *) photoTonalImageWithImage:(UIImage *)img
{
    CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectTonal"];
    UIImage *imageResult = [self applyFilter:filter atImage:img];
    
    return imageResult;
}

- (UIImage *) lineOverlayImageWithImage:(UIImage *)img
{
    CIFilter *filter = [CIFilter filterWithName:@"CILineOverlay"];
    [filter setValue:[NSNumber numberWithDouble:0.005] forKey:@"inputNRNoiseLevel"];
    [filter setValue:[NSNumber numberWithDouble:0.4] forKey:@"inputEdgeIntensity"];
    [filter setValue:[NSNumber numberWithDouble:0.08] forKey:@"inputThreshold"];
    [filter setValue:[NSNumber numberWithDouble:50.0] forKey:@"inputContrast"];
    [filter setValue:[NSNumber numberWithDouble:0.5] forKey:@"inputNRSharpness"];
    UIImage *imageResult = [self applyFilter:filter atImage:img];
    
    return imageResult;
}

- (UIImage *) CMYKHalftoneImageWithImage:(UIImage *)img andCenter:(CIVector *)center
{
    CIFilter *filter = [CIFilter filterWithName:@"CICMYKHalftone"];
    [filter setValue:center forKey:@"inputCenter"];
    [filter setValue:[NSNumber numberWithDouble:0.7] forKey:@"inputSharpness"];
    UIImage *imageResult = [self applyFilter:filter atImage:img];
    
    return imageResult;
}

- (UIImage *) dotScreenImageWithImage:(UIImage *)img andCenter:(CIVector *)center
{
    CIFilter *filter = [CIFilter filterWithName:@"CIDotScreen"];
    [filter setValue:center forKey:@"inputCenter"];
    [filter setValue:[NSNumber numberWithDouble:0.5] forKey:@"inputSharpness"];
    [filter setValue:[NSNumber numberWithDouble:M_PI/2] forKey:@"inputAngle"];
    UIImage *imageResult = [self applyFilter:filter atImage:img];
    
    return imageResult;
}

- (UIImage *) hatchedScreenImageWithImage:(UIImage *)img andCenter:(CIVector *)center
{
    CIFilter *filter = [CIFilter filterWithName:@"CIHatchedScreen"];
    [filter setValue:center forKey:@"inputCenter"];
    [filter setValue:[NSNumber numberWithDouble:0.1] forKey:@"inputSharpness"];
    [filter setValue:[NSNumber numberWithDouble:M_PI/2] forKey:@"inputAngle"];
    UIImage *imageResult = [self applyFilter:filter atImage:img];
    
    return imageResult;
}

- (UIImage *) hexPixellateImageWithImage:(UIImage *)img andCenter:(CIVector *)center
{
    CIFilter *filter = [CIFilter filterWithName:@"CIHexagonalPixellate"];
    [filter setValue:center forKey:@"inputCenter"];
    //[filter setValue:[NSNumber numberWithDouble:5.5] forKey:@"inputScale"];
    UIImage *imageResult = [self applyFilter:filter atImage:img];
    
    return imageResult;
}

- (UIImage *) pixellateImageWithImage:(UIImage *)img andCenter:(CIVector *)center
{
    CIFilter *filter = [CIFilter filterWithName:@"CIPixellate"];
    [filter setValue:center forKey:@"inputCenter"];
    [filter setValue:[NSNumber numberWithDouble:8.0] forKey:@"inputScale"];
    UIImage *imageResult = [self applyFilter:filter atImage:img];
    return imageResult;
}

- (UIImage *) pointillizeImageWithImage:(UIImage *)img andCenter:(CIVector *)center
{
    CIFilter *filter = [CIFilter filterWithName:@"CIPointillize"];
    [filter setValue:center forKey:@"inputCenter"];
    [filter setValue:[NSNumber numberWithDouble:3.0] forKey:@"inputRadius"];
    UIImage *imageResult = [self applyFilter:filter atImage:img];
    
    return imageResult;
}

- (UIImage *) comicImageWithImage:(UIImage *)img
{
    CIFilter *filter = [CIFilter filterWithName:@"CIComicEffect"];
    UIImage *imageResult = [self applyFilter:filter atImage:img];
    
    return imageResult;
}

- (UIImage *) edgesImageWithImage:(UIImage *)img
{
    CIFilter *filter = [CIFilter filterWithName:@"CIEdges"];
    [filter setValue:[NSNumber numberWithDouble:50.0] forKey:@"inputIntensity"];
    UIImage *imageResult = [self applyFilter:filter atImage:img];
    
    return imageResult;
}

@end
