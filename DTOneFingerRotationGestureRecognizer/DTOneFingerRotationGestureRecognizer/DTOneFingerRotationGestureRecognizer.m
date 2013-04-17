//
//  DTOneFingerRotationGestureRecognizer.m
//  OneFingerRotationGesture
//
//  Created by Darktt on 11/1/13.
//  Copyright (c) 2013 Darktt. All rights reserved.
//

#import "DTOneFingerRotationGestureRecognizer.h"

@interface DTOneFingerRotationGestureRecognizer ()
{
    id _targe;
    SEL _action;
}

@end

@implementation DTOneFingerRotationGestureRecognizer

+ (id)gestureRecognizerWithTarge:(id)targe action:(SEL)action
{
#if __has_feature(objc_arc)
    // ARC is On
    DTOneFingerRotationGestureRecognizer *gesture = [[DTOneFingerRotationGestureRecognizer alloc] initWithTarget:targe action:action];
#else
    // ARC is Off
    DTOneFingerRotationGestureRecognizer *gesture = [[[DTOneFingerRotationGestureRecognizer alloc] initWithTarget:targe action:action] autorelease];
#endif
    
    return gesture;
}

- (id)initWithTarget:(id)target action:(SEL)action
{
    self = [super initWithTarget:target action:action];
    if (self == nil) return nil;
    
    _targe = target;
    _action = action;
    
    _rotation = 0.0f;
    
    return self;
}

#pragma mark - GestureRecognizer implementation

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if ([[event touchesForGestureRecognizer:self] count] > 1) {
        [self setState:UIGestureRecognizerStateFailed];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    
    CGPoint current = [touch locationInView:self.view];
    CGPoint previous = [touch previousLocationInView:self.view];
    
    CGPoint currentDiff = CGPointMake(current.x - center.x, current.y - center.y);
    CGPoint previousDiff = CGPointMake(previous.x - center.x, previous.y - center.y);
    
    CGFloat angle = atan2f(currentDiff.y, currentDiff.x) - atan2f(previousDiff.y, previousDiff.x);
    
    _rotation += angle;
    
    [[UIApplication sharedApplication] sendAction:_action to:_targe from:self forEvent:event];
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
