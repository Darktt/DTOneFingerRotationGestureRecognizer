//
//  DTViewController.m
//  DTOneFingerRotationGestureRecognizer
//
//  Created by Darktt on 13/4/17.
//  Copyright (c) 2013 Darktt. All rights reserved.
//

#import "DTViewController.h"
#import "DTOneFingerRotationGestureRecognizer.h"

@interface DTViewController ()

@end

@implementation DTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
    [view setCenter:self.view.center];
    [view setBackgroundColor:[UIColor redColor]];
    
    DTOneFingerRotationGestureRecognizer *oneRotation = [DTOneFingerRotationGestureRecognizer gestureRecognizerWithTarge:self action:@selector(rotationView:)];
    [view setGestureRecognizers:@[oneRotation]];
    
    [self.view addSubview:view];
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
