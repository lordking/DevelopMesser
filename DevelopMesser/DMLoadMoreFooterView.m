//
//  DMLoadMoreFooterView.m
//  jinli
//
//  Created by 金磊 on 14-1-6.
//  Copyright (c) 2014年 lordking. All rights reserved.
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
