//
//  TabBarControlDemoViewController.m
//  Example
//
//  Created by 金磊 on 14-2-17.
//  Copyright (c) 2014年 lordking. All rights reserved.
//

#import "TabBarControlDemoViewController.h"

#import "DMDebug.h"
#import "DMTabBarControl.h"

@interface TabBarControlDemoViewController ()

@property (nonatomic, weak) IBOutlet DMTabBarControl *tabBar;
@property (nonatomic, weak) IBOutlet UIButton *button1;
@property (nonatomic, weak) IBOutlet UIButton *button2;
@property (nonatomic, weak) IBOutlet UIButton *button3;

@end

@implementation TabBarControlDemoViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    DMPRINTMETHODNAME();
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    DMPRINTMETHODNAME();
    [super viewDidLoad];
    _tabBar.buttons = @[_button1, _button2, _button3];
}

- (void)didReceiveMemoryWarning
{
    DMPRINTMETHODNAME();
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

-(IBAction)switchButton:(id)sender
{
    DMPRINTMETHODNAME();
    DMPRINT(@"select: %ld", self.tabBar.selectedButtonIndex);
    
}

@end
