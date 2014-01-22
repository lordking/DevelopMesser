//
//  DMRefreshHeaderView.h
//  jinli
//
//  Created by 金磊 on 14-1-6.
//  Copyright (c) 2014年 lordking. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HeaderViewAnimationWithin = 0,
    HeaderViewAnimationAbove,
    HeaderViewAnimationLoading
} HeaderViewAnimationType;

@interface DMRefreshHeaderView : UIView

@property (nonatomic, strong) UILabel *refreshLabel;
@property (nonatomic, strong) UIImageView *refreshArrow;
@property (nonatomic, strong) UIActivityIndicatorView *refreshSpinner;

- (void)setText:(NSString*)text;
- (void)startAnimation:(HeaderViewAnimationType)type;
- (void)stopAnimation;

@end
