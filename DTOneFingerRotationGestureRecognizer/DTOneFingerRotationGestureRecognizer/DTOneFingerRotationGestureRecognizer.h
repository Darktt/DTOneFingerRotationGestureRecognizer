//
//  DTOneFingerRotationGestureRecognizer.h
//  OneFingerRotationGesture
//
//  Created by Darktt on 2013/11/1.
//  Copyright (c) 2013 Darktt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTOneFingerRotationGestureRecognizer : UIGestureRecognizer

@property (readonly, nonatomic) CGFloat angle;

@property (assign, nonatomic, getter = isScaleEnabled) BOOL scaleEnabled;
@property (readonly, nonatomic) CGFloat scale;

+ (instancetype)gestureRecognizerWithTarget:(id)targe action:(SEL)action;

@end
