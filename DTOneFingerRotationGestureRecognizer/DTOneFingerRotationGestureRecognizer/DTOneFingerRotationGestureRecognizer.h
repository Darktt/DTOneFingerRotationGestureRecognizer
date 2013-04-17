//
//  DTOneFingerRotationGestureRecognizer.h
//  OneFingerRotationGesture
//
//  Created by Darktt on 11/1/13.
//  Copyright (c) 2013 Darktt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface DTOneFingerRotationGestureRecognizer : UIGestureRecognizer

@property(nonatomic) CGFloat rotation;

+ (id)gestureRecognizerWithTarge:(id)targe action:(SEL)action;

@end
