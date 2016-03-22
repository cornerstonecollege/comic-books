//
//  FilterView.h
//  comic-books
//
//  Created by Hiroshi on 3/16/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterHelper : UIView

+ (UIImage *) imageFilterWithParent:(UIView *)mainView type:(NSInteger)type andOriginalImage:(UIImage*)originalImage;

@end
