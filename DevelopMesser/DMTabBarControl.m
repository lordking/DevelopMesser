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

#import "DMTabBarControl.h"

@implementation DMTabBarControl

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
        self.selectedButtonIndex = 0;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutIfNeeded];
    
    for (UIButton *button in _buttons) {
        [button addTarget:self action:@selector(didValueChanged:) forControlEvents:UIControlEventTouchDown];
    }
}

#pragma mark - private method

- (void)didValueChanged:(id)sender
{
    
    self.selectedButtonIndex = [_buttons indexOfObject:sender];
    
    for (UIButton *button in _buttons) {
        if ([button isEqual:sender]) {
            button.selected = YES;
        } else {
            button.selected = NO;
        }
    }
    
    //通知事件动作，即:IBAction
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}


@end
