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
#import "DMTabBar.h"
#import "DMTabBarItem.h"

@interface DMTabBar()

@end

@implementation DMTabBar

- (void)setButtons:(NSArray*)buttons
{
    if (buttons == nil) {
        buttons = [[NSMutableArray alloc] init];
    }
}

- (void)setItems:(NSArray *)items
{
    DMPRINTMETHODNAME();
    _items = items;
    
    [self createTabs];
}

- (void)layoutSubviews
{
    DMPRINTMETHODNAME();

    if (self.backgroundImage) {
        self.backgroundColor = [UIColor colorWithPatternImage:self.backgroundImage];
    } else {
        self.backgroundColor = [UIColor grayColor];
    }

}

#pragma mark private method

-(void) createTabs
{
    DMPRINTMETHODNAME();
        
    NSUInteger tabCount = self.items.count;
    CGFloat tabWidth = self.frame.size.width / tabCount;
    CGFloat tabBarHeight = self.frame.size.height;
    
    NSLog(@"tabBarHeight:%f",tabBarHeight);

    int tabCounter = 0;
    for (DMTabBarItem *item in self.items) {
        
        CGFloat buttonXValue = tabWidth*tabCounter;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = tabCounter;
        button.frame = CGRectMake(buttonXValue, 0.0, tabWidth, tabBarHeight);
        
        [button setImage:item.image forState:UIControlStateNormal];
        [button setImage:item.selectedImage forState:UIControlStateHighlighted];
        [button setImage:item.selectedImage forState:UIControlStateSelected];
        
        [button setBackgroundImage:self.selectionIndicatorImage forState:UIControlStateHighlighted];
        [button setBackgroundImage:self.selectionIndicatorImage forState:UIControlStateSelected];
                
        [button addTarget:self action:@selector(tabTouchedDown:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(tabTouchedUp:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];

        tabCounter += 1;
    }
    
    [self tabTouchedDown:[self.subviews objectAtIndex:0]];
}

- (void)tabTouchedDown:(UIButton*)touchedTab
{
    DMPRINTMETHODNAME();

    //select button
    for (UIButton *button in self.subviews) {
        [button setSelected:NO];
    }
    
    [touchedTab setSelected:YES];
}

- (void)tabTouchedUp:(UIButton*)touchedTab
{
    DMPRINTMETHODNAME();
    
    [self.delegate buttonClicked:touchedTab];
}


@end
