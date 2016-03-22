//
//  StampGestureHelper.h
//  comic-books
//
//  Created by CICCC1 on 2016-03-15.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StampGestureHelper : NSObject

+ (instancetype) sharedInstance;

- (void) handlePan:(UIPanGestureRecognizer *)panGesture;
- (void) handlePinch:(UIPinchGestureRecognizer *)pinchGesture;
- (void) handleRotation:(UIRotationGestureRecognizer *)rotationGesture;
- (void) handleTap:(UITapGestureRecognizer *)tapGesture;
- (void) handleLongPress:(UILongPressGestureRecognizer *)longGesture;

@end
