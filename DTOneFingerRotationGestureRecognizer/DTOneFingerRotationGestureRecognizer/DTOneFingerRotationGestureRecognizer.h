//
//  DTOneFingerRotationGestureRecognizer.h
//  OneFingerRotationGesture
//
//  Created by Darktt on 2013/11/1.
//  Copyright (c) 2013 Darktt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTOneFingerRotationGestureRecognizer : UIGestureRecognizer

@property(assign, nonatomic) CGFloat rotation;
@property(readonly, nonatomic) CGFloat preRotation;

+ (instancetype)gestureRecognizerWithTarge:(id)targe action:(SEL)action;

@end
