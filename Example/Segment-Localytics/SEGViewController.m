//
//  SEGViewController.m
//  Segment-Localytics
//
//  Created by Prateek Srivastava on 11/10/2015.
//  Copyright (c) 2015 Prateek Srivastava. All rights reserved.
//

#import "SEGViewController.h"
#import "SEGAnalytics.h"

@interface SEGViewController ()

@end

@implementation SEGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[SEGAnalytics sharedAnalytics]identify:@"123" traits:@{@"dog": @"fido"}];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
