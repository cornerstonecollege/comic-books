//
//  SpeechBubbleView.h
//  comic-books
//
//  Created by CICCC1 on 2016-03-10.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeechBubbleView : UIView

- (instancetype) initWithCode:(char)codeBubble andParent:(UIView *)parentView;

- (void) handleRotation:(UIRotationGestureRecognizer *)rotationGesture;
- (void) handlePan:(UIPanGestureRecognizer *)panGesture;

@end
