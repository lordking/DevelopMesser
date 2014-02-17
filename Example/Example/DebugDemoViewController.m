//
//  DebugDemoViewController.m
//  Example
//
//  Created by 金磊 on 14-2-16.
//  Copyright (c) 2014年 lordking. All rights reserved.
//

#import "DebugDemoViewController.h"

#import "DMDebug.h"

@interface DebugDemoViewController ()

@end

@implementation DebugDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self debugPrint];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (void)debugPrint
{
    DMPRINTMETHODNAME();
    
    DMPRINT(@"%@ This is a test!", @"Hi!");
}

@end
