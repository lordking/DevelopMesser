//
//  DMLoadMoreFooterView.h
//  jinli
//
//  Created by 金磊 on 14-1-6.
//  Copyright (c) 2014年 lordking. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    FooterViewAnimationWithin = 0,
    FooterViewAnimationAbove,
    FooterViewAnimationLoading
} FooterViewAnimationType;

@interface DMLoadMoreFooterView : UIView

@property (nonatomic, strong) UILabel *refreshLabel;
@property (nonatomic, strong) UIActivityIndicatorView *refreshSpinner;

- (void) setText:(NSString*)text;
- (void)startAnimation:(FooterViewAnimationType)type;
- (void)stopAnimation;

@end
