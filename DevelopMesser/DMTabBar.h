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

#import <UIKit/UIKit.h>

@protocol DMTabBarDelegate <NSObject>

@required 
- (void)buttonClicked:(UIButton*)sender;

@end

@interface DMTabBar : UIView

@property(nonatomic, retain) id <DMTabBarDelegate> delegate;

@property (nonatomic, strong) NSArray* items;
@property (nonatomic, strong) UIImage* backgroundImage;
@property (nonatomic, strong) UIImage* selectionIndicatorImage;

@end

