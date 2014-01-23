//
// Copyright 2013 lordking
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "DMDebug.h"
#import "DMTabBarController.h"

@interface DMTabBarController ()

@end

@implementation DMTabBarController


- (void)viewDidLoad
{
    [super viewDidLoad];
    DMPRINTMETHODNAME();
    
    [self hideTabBar];
    [self addCustomTabBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    DMPRINTMETHODNAME();
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark private method

- (void)hideTabBar
{
    DMPRINTMETHODNAME();
    
	for(UIView *view in self.view.subviews)
	{
		if([view isKindOfClass:[UITabBar class]])
		{
			view.hidden = YES;
			break;
		}
	}
}

- (void)addCustomTabBar
{
     DMPRINTMETHODNAME();

    self.customTabBar = [[DMTabBar alloc] init];
    _customTabBar.delegate = self;
    [self.view addSubview: self.customTabBar];
}

#pragma mark public method
- (void)setItems:(NSArray *)items
{
    [self.customTabBar setItems:items];
}

#pragma mark implement ESUITabBarDelegate

- (void)buttonClicked:(UIButton*)sender
{
     DMPRINTMETHODNAME();
    
	NSUInteger tabID = [sender tag];
	self.selectedIndex = tabID;
}

@end
