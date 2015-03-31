//
//  PNProgressLabel.h
//
//  Created by Alex on 09/06/13.
//  Copyright (c) 2013 Alexis Creuzot. All rights reserved.
//

#import "PNPropertyAnimation.h"

@class PNProgressLabel;

typedef void(^progressLabelValueChangedCompletion)(PNProgressLabel *label, CGFloat progress);
typedef CGFloat(^radiansFromDegreesCompletion)(CGFloat degrees);

typedef NS_ENUM(NSUInteger, ProgressLabelColorTable) {
    ProgressLabelFillColor,
    ProgressLabelTrackColor,
    ProgressLabelProgressColor
};

@interface PNProgressLabel : UILabel

@property (nonatomic, copy) progressLabelValueChangedCompletion progressLabelVCBlock;

@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) CGFloat startDegree;
@property (nonatomic, assign) CGFloat endDegree;
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, copy) NSDictionary *colorTable;

@property (nonatomic, assign) BOOL clockWise;


NSString *PNStringFromProgressLabelColorTableKey(ProgressLabelColorTable tableColor);
UIColor *PNColorDefaultForColorInProgressLabelColorTableKey(ProgressLabelColorTable tableColor);

// Progress is a float between 0.0 and 1.0
-(void)setProgress:(CGFloat)progress;
-(void)setProgress:(CGFloat)progress timing:(PNPropertyAnimationTiming)timing duration:(CGFloat) duration delay:(CGFloat)delay;


@end
