//
//  DTViewController.m
//  DTOneFingerRotationGestureRecognizer
//
//  Created by Darktt on 2013/4/17.
//  Copyright (c) 2013 Darktt. All rights reserved.
//

#import "DTViewController.h"
#import "DTOneFingerRotationGestureRecognizer.h"

@interface DTViewController ()
{
    UIView *_weakView;
    CGRect _defaultBounce;
}

@end

@implementation DTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    DTOneFingerRotationGestureRecognizer *oneRotation = [DTOneFingerRotationGestureRecognizer gestureRecognizerWithTarget:self action:@selector(rotationView:)];
    [oneRotation setScaleEnabled:YES];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
    [view setBackgroundColor:[UIColor redColor]];
    [view addGestureRecognizer:oneRotation];
    
    [self.view addSubview:view];
    _weakView = view;
    [view release];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [_weakView setCenter:self.view.center];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rotationView:(DTOneFingerRotationGestureRecognizer *)sender
{
    UIView *view = sender.view;
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        _defaultBounce = view.bounds;
    }
    
    if (sender.state != UIGestureRecognizerStateChanged) {
        return;
    }
    
    CGFloat minimumScale = (CGRectGetWidth(_defaultBounce) / 2) / CGRectGetWidth(_defaultBounce);
    
    CGFloat scale = MAX(sender.scale, minimumScale);
    
    CGRect scaledBounds = CGRectScale(_defaultBounce, scale, scale);
    [view setBounds:scaledBounds];
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(sender.angle);
    
    [view setTransform:transform];
}

@end
