//
//  DTOneFingerRotationGestureRecognizer.m
//
//  Created by Darktt on 2013/11/1.
//  Copyright © 2013 Darktt. All rights reserved.
//

@import UIKit.UIGestureRecognizerSubclass;

#import "DTOneFingerRotationGestureRecognizer.h"

CGRect CGRectScale(CGRect rect, CGFloat wScale, CGFloat hScale) {
    CGRect newRect = (CGRect) {
        .origin = rect.origin,
        .size = (CGSize) {
            .width = CGRectGetWidth(rect) * wScale,
            .height = CGRectGetHeight(rect) * hScale
        }
    };
    
    return newRect;
}

CG_INLINE CGFloat CGPointGetDistance(CGPoint point1, CGPoint point2) {
    CGFloat fx = (point2.x - point1.x);
    CGFloat fy = (point2.y - point1.y);
    
    return sqrt((fx * fx + fy * fy));
}

@interface DTOneFingerRotationGestureRecognizer ()
{
    CGFloat _distance;
}

@property (assign, nonatomic) CGFloat angle;
@property (assign, nonatomic) CGFloat scale;

@end

@implementation DTOneFingerRotationGestureRecognizer

+ (instancetype)gestureRecognizerWithTarget:(id)targe action:(SEL)action
{
    DTOneFingerRotationGestureRecognizer *gesture = [[DTOneFingerRotationGestureRecognizer alloc] initWithTarget:targe action:action];
    
    return [gesture autorelease];
}

- (instancetype)initWithTarget:(id)target action:(SEL)action
{
    self = [super initWithTarget:target action:action];
    if (self == nil) return nil;
    
    [self setAngle:0.0f];
    [self setScale:1.0f];
    [self setScaleEnabled:NO];
    
    return self;
}

- (void)dealloc
{
    
    [super dealloc];
}

#pragma mark - GestureRecognizer implementation

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if (touches.count > 1) {
        [self setState:UIGestureRecognizerStateFailed];
        
        return;
    }
    
    [self setState:UIGestureRecognizerStateBegan];
    
    if (!self.scaleEnabled) {
        return;
    }
    
    UITouch *touch = (UITouch *)[touches anyObject];
    
    CGPoint center = (CGPoint) {
        .x = CGRectGetMidX(self.view.bounds),
        .y = CGRectGetMidY(self.view.bounds)
    };
    
    CGPoint touchLocation = [touch locationInView:self.view];
    
    _distance = CGPointGetDistance(center, touchLocation);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = (UITouch *)[touches anyObject];
    
    CGPoint center = (CGPoint) {
        .x = CGRectGetMidX(self.view.bounds),
        .y = CGRectGetMidY(self.view.bounds)
    };
    
    CGPoint currentPoint = [touch locationInView:self.view];
    CGPoint previousPoint = [touch previousLocationInView:self.view];
    
    CGPoint currentPointDifference = CGPointMake(currentPoint.x - center.x, currentPoint.y - center.y);
    CGPoint previousPointDifference = CGPointMake(previousPoint.x - center.x, previousPoint.y - center.y);
    
    CGFloat angle = atan2f(currentPointDifference.y, currentPointDifference.x) - atan2f(previousPointDifference.y, previousPointDifference.x);
    
    self.angle += angle;
    
    if (self.scaleEnabled) {
        CGFloat scale = CGPointGetDistance(center, currentPoint) / _distance;
        [self setScale:scale];
    }
    
    [self setState:UIGestureRecognizerStateChanged];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    [self setState:UIGestureRecognizerStateEnded];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    [self setState:UIGestureRecognizerStateCancelled];
}

- (void)reset
{
    [super reset];
}

@end
