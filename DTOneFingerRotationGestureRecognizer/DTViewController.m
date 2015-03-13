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
    UIView *_view;
}

@end

@implementation DTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
    [_view setBackgroundColor:[UIColor redColor]];
    
    DTOneFingerRotationGestureRecognizer *oneRotation = [DTOneFingerRotationGestureRecognizer gestureRecognizerWithTarge:self action:@selector(rotationView:)];
    [_view addGestureRecognizer:oneRotation];
    
    [self.view addSubview:_view];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [_view setCenter:self.view.center];
}

- (void)dealloc
{
    _view = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rotationView:(DTOneFingerRotationGestureRecognizer *)sender
{
    UIView *view = sender.view;
    
    [view setTransform:CGAffineTransformMakeRotation(sender.rotation)];
}

@end
