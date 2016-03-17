//
//  SelectionView.h
//  comic-books
//
//  Created by Hiroshi on 3/14/16.
//  Copyright © 2016 Ideia do Luiz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SELECTION_TYPE)
{
    ST_FRAME = 0,
    ST_FILTER = 1,
    ST_SPEECH_BUBBLE = 2,
    ST_STAMP = 3,
};

typedef NS_ENUM(NSUInteger, TYPE_FRAME)
{
    TF_FRAME1 = 1,
    TF_FRAME2 = 2,
    TF_FRAME3 = 3,
    TF_FRAME4 = 4,
    TF_FRAME5 = 5,
    TF_FRAME6 = 6,
    TF_FRAME7 = 7,
    TF_FRAME8 = 8,
    TF_FRAME9 = 9,
};

typedef NS_ENUM(NSUInteger, TYPE_SPEECH_BUBBLE)
{
    TSB_BUBBLE1 = 1,
};

typedef NS_ENUM(NSUInteger, TYPE_STYLE_FILTER)
{
    TSF_FILTER1 = 1,
    TSF_FILTER2 = 2,
    TSF_FILTER3 = 3,
    TSF_FILTER4 = 4,
    TSF_FILTER5 = 5,
    TSF_FILTER6 = 6,
    TSF_FILTER7 = 7,
    TSF_FILTER8 = 8,
    TSF_FILTER9 = 9,
};

@protocol SelectionViewDelegate <NSObject>

@optional

- (void) didTouchFrame:(TYPE_FRAME)typeFrame;
- (void) didTouchStamp:(char)codeStamp;
- (void) didTouchSpeechBubble:(char)codeBubble;
- (void) didTouchFilter:(TYPE_STYLE_FILTER)typeFilter;

@end

@interface SelectionView : UIScrollView

@property (nonatomic, weak) id<SelectionViewDelegate> selectionDelegate;
@property (nonatomic, readonly) SELECTION_TYPE type;

- (instancetype) initWithType:(SELECTION_TYPE)type andFrame:(CGRect)frame;

@end
