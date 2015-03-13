//
//  DTOneFingerRotationGestureRecognizer.m
//  OneFingerRotationGesture
//
//  Created by Darktt on 2013/11/1.
//  Copyright (c) 2013 Darktt. All rights reserved.
//

#import <UIKit/UIGestureRecognizerSubclass.h>

#import "DTOneFingerRotationGestureRecognizer.h"

@interface DTOneFingerRotationGestureRecognizer ()
{
    id _targe;
    SEL _action;
}

@property(assign, nonatomic) CGFloat preRotation;

@end

@implementation DTOneFingerRotationGestureRecognizer

+ (instancetype)gestureRecognizerWithTarge:(id)targe action:(SEL)action
{
#if __has_feature(objc_arc)
    // ARC is On
    DTOneFingerRotationGestureRecognizer *__autoreleasing gesture = [[DTOneFingerRotationGestureRecognizer alloc] initWithTarget:targe action:action];
#else
    // ARC is Off
    DTOneFingerRotationGestureRecognizer *gesture = [[[DTOneFingerRotationGestureRecognizer alloc] initWithTarget:targe action:action] autorelease];
#endif
    
    return gesture;
}

- (instancetype)initWithTarget:(id)target action:(SEL)action
{
    self = [super initWithTarget:target action:action];
    if (self == nil) return nil;
    
    _targe = target;
    _action = action;
    
    _rotation = 0.0f;
    
    return self;
}

- (void)dealloc
{
    _targe = nil;
    _action = nil;
    
#if !__has_feature(objc_arc)
    
    [super dealloc];
    
#endif
}

#pragma mark - GestureRecognizer implementation

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    NSSet *_touches = [event touchesForGestureRecognizer:self];
    
    if ([_touches count] > 1) {
        [self setState:UIGestureRecognizerStateFailed];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint center = (CGPoint) {
        .x = CGRectGetMidX(self.view.bounds),
        .y = CGRectGetMidY(self.view.bounds)
    };
    
    CGPoint currentPoint = [touch locationInView:self.view];
    CGPoint previousPoint = [touch previousLocationInView:self.view];
    
    CGPoint currentPointDifference = CGPointMake(currentPoint.x - center.x, currentPoint.y - center.y);
    CGPoint previousPointDifference = CGPointMake(previousPoint.x - center.x, previousPoint.y - center.y);
    
    CGFloat angle = atan2f(currentPointDifference.y, currentPointDifference.x) - atan2f(previousPointDifference.y, previousPointDifference.x);
    
    [self setPreRotation:_rotation];
    self.rotation += angle;
    
    if (_action != nil) {
        [[UIApplication sharedApplication] sendAction:_action to:_targe from:self forEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
}

- (void)reset
{
    [super reset];
}

@end
