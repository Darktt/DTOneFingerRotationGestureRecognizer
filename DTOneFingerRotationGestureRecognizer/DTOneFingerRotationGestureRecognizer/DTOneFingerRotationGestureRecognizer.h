//
//  DTOneFingerRotationGestureRecognizer.h
//
//  Created by Darktt on 2013/11/1.
//  Copyright © 2013 Darktt. All rights reserved.
//

@import UIKit;

CG_EXTERN CGRect CGRectScale(CGRect rect, CGFloat wScale, CGFloat hScale) NS_SWIFT_NAME(CGRectScale(rect:wScale:hScale:));

NS_ASSUME_NONNULL_BEGIN
@interface DTOneFingerRotationGestureRecognizer : UIGestureRecognizer

/** @brief The rotate angle, Default is 0.0 (Read only).
 */
@property (readonly, nonatomic) CGFloat angle;

/** @brief The scale enable setting, Defauly is NO.
 */
@property (assign, nonatomic, getter = isScaleEnabled) BOOL scaleEnabled;

/** @bridf The scale value, Defaule is 1.0 (Read only).
 */
@property (readonly, nonatomic) CGFloat scale;

/**
 * @brief Create a one finger rotation grestre-recongnizer object with a target and an action selector.
 *
 * @param target An object that is the recipient of action messages sent by the receiver when it recognizes a gesture. nil is not a valid value.
 *
 * @param action A selector that identifies the method implemented by the target to handle the gesture recognized by the receiver. The action selector must conform to the signature described in the class overview. NULL is not a valid value.
 *
 * @return The gesture recongnizer object instance.
 *
 */
+ (instancetype)gestureRecognizerWithTarget:(nullable id)targe action:(nullable SEL)action;

@end
NS_ASSUME_NONNULL_END