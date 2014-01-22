//
//  DMRefreshHeaderView.m
//  jinli
//
//  Created by 金磊 on 14-1-6.
//  Copyright (c) 2014年 lordking. All rights reserved.
//

#import "DMRefreshHeaderView.h"

@implementation DMRefreshHeaderView

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
        
        _refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
        _refreshArrow.frame = CGRectMake(floorf((height - 27) / 2)+10,
                                         (floorf(height - 44) / 2),
                                         27, 44);
        
        _refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _refreshSpinner.frame = CGRectMake(floorf(floorf(height - 20) / 2), floorf((height - 20) / 2), 20, 20);
        _refreshSpinner.hidesWhenStopped = YES;
        
        [self addSubview:_refreshLabel];
        [self addSubview:_refreshArrow];
        [self addSubview:_refreshSpinner];

    }
    return self;
}

#pragma mark - public method

- (void)setText:(NSString*)text
{
    self.refreshLabel.text = text;
}

- (void)startAnimation:(HeaderViewAnimationType)type
{
    [UIView animateWithDuration:0.25 animations:^{
    
        if (type == HeaderViewAnimationWithin) {
            [self.refreshSpinner stopAnimating];
            [self.refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
        
        } else if (type == HeaderViewAnimationAbove) {
            self.refreshArrow.hidden = NO;
            [self.refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        
        } else if (type == HeaderViewAnimationLoading) {
            self.refreshArrow.hidden = YES;
            [self.refreshSpinner startAnimating];
        }
    }];
    
}

- (void)stopAnimation
{
    [self.refreshSpinner stopAnimating];
    self.refreshArrow.hidden = NO;
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self.refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
                     }
                     completion:^(BOOL finished) {}];

}

@end
