//
//  DMSpinnerView.m
//  mygoods
//
//  Created by 金磊 on 14-1-9.
//  Copyright (c) 2014年 lordking. All rights reserved.
//

#import "DMSpinnerView.h"

@implementation DMSpinnerView

- (id)init
{
    self = [super init];
    if (self) {
        [self customStyle];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customStyle];
    }
    return self;
}

- (void)customStyle
{
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.frame = CGRectMake(floorf(floorf([[UIScreen mainScreen] bounds].size.width - 30) / 2), floorf(([[UIScreen mainScreen] bounds].size.width - 30) / 2), 30, 30);
    self.hidesWhenStopped = YES;
    [self resignFirstResponder];
}

@end
