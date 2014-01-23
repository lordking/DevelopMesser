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

#import "DMLoadMoreFooterView.h"

@implementation DMLoadMoreFooterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        
        _refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _refreshLabel.backgroundColor = [UIColor clearColor];
        _refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
        _refreshLabel.textAlignment = NSTextAlignmentCenter;
        
        _refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _refreshSpinner.frame = CGRectMake(floorf(floorf(height - 20) / 2), floorf((height - 20) / 2), 20, 20);
        _refreshSpinner.hidesWhenStopped = YES;
        
        [self addSubview:_refreshLabel];
        [self addSubview:_refreshSpinner];
    }
    return self;
}

- (void) setText:(NSString*)text
{
    self.refreshLabel.text = text;
}

-(void)startAnimation:(FooterViewAnimationType)type
{
    if (type == FooterViewAnimationLoading) {
        [self.refreshSpinner startAnimating];
    }
}

-(void)stopAnimation
{
    [self.refreshSpinner stopAnimating];
}

@end
