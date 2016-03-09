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
    
    if (self)
    {
        // initialize any global property or var
    }
    
    return self;
}

- (UIImage *) hueImageWithImage:(UIImage*)img
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:[img CGImage]];
    CIFilter *filter = [CIFilter filterWithName:@"CIHueAdjust"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithDouble:3*M_PI/4] forKey:@"inputAngle"];
    CIImage *result = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *imageResult = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return imageResult;
}

- (UIImage *) colorClampImageWithImage:(UIImage*)img
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:[img CGImage]];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorClamp"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    CIVector *vectorMin = [CIVector vectorWithX:0.1 Y:0.1 Z:0.1 W:0.0];
    [filter setValue:vectorMin forKey:@"inputMinComponents"];
    CIVector *vectorMax = [CIVector vectorWithX:0.5 Y:0.5 Z:0.5 W:1.0];
    [filter setValue:vectorMax forKey:@"inputMaxComponents"];
    CIImage *result = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *imageResult = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return imageResult;
}

- (UIImage *) crossPolynomialImageWithImage:(UIImage *)img
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:[img CGImage]];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorCrossPolynomial"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    CIVector *vectorRed = [CIVector vectorWithString:@"1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0"];
    CIVector *vectorGreen = [CIVector vectorWithString:@"0.0 1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0"];
    CIVector *vectorBlue = [CIVector vectorWithString:@"0.0 0.0 1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0"];
    [filter setValue:vectorRed forKey:@"inputRedCoefficients"];
    [filter setValue:vectorGreen forKey:@"inputGreenCoefficients"];
    [filter setValue:vectorBlue forKey:@"inputBlueCoefficients"];
    CIImage *result = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *imageResult = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return imageResult;
}

- (UIImage *) monochromeImageWithImage:(UIImage *)img
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:[img CGImage]];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorMonochrome"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    CIColor *color = [CIColor colorWithRed:1.0 green:0.0 blue:0.0];
    [filter setValue:color forKey:@"inputColor"];
    [filter setValue:[NSNumber numberWithDouble:1.0] forKey:@"inputIntensity"];
    CIImage *result = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *imageResult = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return imageResult;
}

- (UIImage *) photoTonalImageWithImage:(UIImage *)img
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:[img CGImage]];
    CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectTonal"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    CIImage *result = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *imageResult = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return imageResult;
}

- (UIImage *) lineOverlayImageWithImage:(UIImage *)img
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:[img CGImage]];
    CIFilter *filter = [CIFilter filterWithName:@"CILineOverlay"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    //[filter setValue:[NSNumber numberWithDouble:0.02] forKey:@"inputNRNoiseLevel"];
    // inputContrast
    [filter setValue:[NSNumber numberWithDouble:0.3] forKey:@"inputNRSharpness"];
    CIImage *result = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *imageResult = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return imageResult;
}

- (UIImage *) CMYKHalftoneImageWithImage:(UIImage *)img andCenter:(CIVector *)center
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:[img CGImage]];
    CIFilter *filter = [CIFilter filterWithName:@"CICMYKHalftone"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:center forKey:@"inputCenter"];
    [filter setValue:[NSNumber numberWithDouble:0.5] forKey:@"inputSharpness"];
    CIImage *result = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *imageResult = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return imageResult;
}

- (UIImage *) dotScreenImageWithImage:(UIImage *)img andCenter:(CIVector *)center
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:[img CGImage]];
    CIFilter *filter = [CIFilter filterWithName:@"CIDotScreen"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:center forKey:@"inputCenter"];
    [filter setValue:[NSNumber numberWithDouble:0.2] forKey:@"inputSharpness"];
    [filter setValue:[NSNumber numberWithDouble:M_PI/2] forKey:@"inputAngle"];
    
    CIImage *result = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *imageResult = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return imageResult;
}

- (UIImage *) hatchedScreenImageWithImage:(UIImage *)img andCenter:(CIVector *)center
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:[img CGImage]];
    CIFilter *filter = [CIFilter filterWithName:@"CIHatchedScreen"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:center forKey:@"inputCenter"];
    [filter setValue:[NSNumber numberWithDouble:0.1] forKey:@"inputSharpness"];
    [filter setValue:[NSNumber numberWithDouble:M_PI/2] forKey:@"inputAngle"];
    CIImage *result = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *imageResult = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return imageResult;
}

- (UIImage *) hexPixellateImageWithImage:(UIImage *)img andCenter:(CIVector *)center
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:[img CGImage]];
    CIFilter *filter = [CIFilter filterWithName:@"CIHexagonalPixellate"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:center forKey:@"inputCenter"];
    [filter setValue:[NSNumber numberWithDouble:5.5] forKey:@"inputScale"];
    CIImage *result = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *imageResult = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return imageResult;
}

- (UIImage *) pixellateImageWithImage:(UIImage *)img andCenter:(CIVector *)center
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:[img CGImage]];
    CIFilter *filter = [CIFilter filterWithName:@"CIPixellate"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:center forKey:@"inputCenter"];
    [filter setValue:[NSNumber numberWithDouble:5.5] forKey:@"inputScale"];
    CIImage *result = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *imageResult = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return imageResult;
}

- (UIImage *) pointillizeImageWithImage:(UIImage *)img andCenter:(CIVector *)center
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:[img CGImage]];
    CIFilter *filter = [CIFilter filterWithName:@"CIPointillize"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:center forKey:@"inputCenter"];
    [filter setValue:[NSNumber numberWithDouble:1.0] forKey:@"inputRadius"];
    CIImage *result = [filter outputImage];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *imageResult = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return imageResult;
}

@end
