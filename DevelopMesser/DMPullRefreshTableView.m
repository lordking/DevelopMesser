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

#import "DMPullRefreshTableView.h"
#import "DMRefreshHeaderView.h"
#import "DMLoadMoreFooterView.h"

static CGFloat REFRESH_HEADER_HEIGHT = 50.0f;
static CGFloat LOADMORE_FOOTER_HEIGHT = 30.0f;

typedef enum {
    DMPullRefreshNormal = 0,
    DMPullRefreshDragging,
    DMPullRefreshLoading,
} DMPullRefreshState;

typedef enum {
    DMDraggingNone = 0,
    DMDraggingDown,
    DMDraggingUp
} DMDraggingDirection;

@interface DMPullRefreshTableView (){
    DMPullRefreshState _pullstate;
    DMDraggingDirection _dragDirection;
    UIEdgeInsets _inset;
}

@property (nonatomic, strong) DMRefreshHeaderView *refreshHeaderView;
@property (nonatomic, strong) DMLoadMoreFooterView *loadMoreFooterView;

@end

@implementation DMPullRefreshTableView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addRefreshHeaderView];
        [self addLoadMoreFooterView];
        
        self.delegate = self;
    }
    
    return self;
}

#pragma mark - private method

- (void)addRefreshHeaderView
{
    CGRect frame = CGRectMake(0, -REFRESH_HEADER_HEIGHT, self.bounds.size.width, REFRESH_HEADER_HEIGHT);
    self.refreshHeaderView = [[DMRefreshHeaderView alloc] initWithFrame:frame];
    
    [self addSubview:_refreshHeaderView];
}

- (void)addLoadMoreFooterView
{
    CGFloat y = MAX(self.contentSize.height, self.frame.size.height);
    self.loadMoreFooterView = [[DMLoadMoreFooterView alloc] initWithFrame:CGRectMake(0, y, self.bounds.size.width, LOADMORE_FOOTER_HEIGHT)];
    self.tableFooterView = _loadMoreFooterView;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    if (_pullstate == DMPullRefreshLoading) return;
    //1.开始拉动
    _pullstate = DMPullRefreshDragging;
    if (_inset.top == 0) {
        _inset = self.contentInset;
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (_pullstate == DMPullRefreshDragging) { //拉动状态
        
        if (self.contentOffset.y < 0 && self.contentOffset.y <= _inset.top) { //向下拉动
            
            _dragDirection = DMDraggingDown;
            
            if (self.contentOffset.y >= - (REFRESH_HEADER_HEIGHT + _inset.top) ) {
                [_refreshHeaderView setText:@"下拉将会刷新"];
                [_refreshHeaderView startAnimation:HeaderViewAnimationWithin];
                
            } else {
                [_refreshHeaderView setText:@"松开即可刷新"];
                [_refreshHeaderView startAnimation:HeaderViewAnimationAbove];
                
            }
            
        } else if ( self.contentOffset.y > 0 ) { //向上拉动
            _dragDirection = DMDraggingUp;
            [_loadMoreFooterView setText:@"上拉即可加载更多"];
        }
        
    } else if (_pullstate == DMPullRefreshLoading) {//加载状态
        if (_dragDirection == DMDraggingDown) {
            self.contentInset = UIEdgeInsetsMake(-self.contentOffset.y, _inset.left, _inset.bottom, _inset.right);
        } 
        
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_pullstate == DMPullRefreshLoading) return;
    
    if (_dragDirection == DMDraggingDown) {//向下拉动
        if (self.contentOffset.y <=  -(REFRESH_HEADER_HEIGHT + _inset.top)) {
            _pullstate = DMPullRefreshLoading;
            [_refreshHeaderView setText:@"刷新中..."];
            [_refreshHeaderView startAnimation:HeaderViewAnimationLoading];
            
            if ([_pullDelegate respondsToSelector:@selector(didTriggerRefreshHeaderView:)]) {
                [_pullDelegate didTriggerRefreshHeaderView:self];
            }
        }
        
    } else if (_dragDirection == DMDraggingUp) {//向上拉动
        CGFloat scrollDownOff = _inset.bottom + self.contentSize.height - self.frame.size.height - self.contentOffset.y;
        
        if (scrollDownOff <= 0) {
            _pullstate = DMPullRefreshLoading;
            [_loadMoreFooterView setText:@"加载中..."];
            [_loadMoreFooterView startAnimation:FooterViewAnimationLoading];
            
            if ([_pullDelegate respondsToSelector:@selector(didTriggerLoadMoreFooterView:)]) {
                [_pullDelegate didTriggerLoadMoreFooterView:self];
            }
        }
    }
}

- (void)stopLoading
{
    DMPRINTMETHODNAME();
    
    if (_pullstate == DMPullRefreshLoading) {
        
        if (_dragDirection == DMDraggingDown) {//向下拉动
            [_refreshHeaderView setText:@"刷新完成"];
            [_refreshHeaderView stopAnimation];
            
        } else if (_dragDirection == DMDraggingUp) {//向上拉动
            [_loadMoreFooterView setText:@""];
            [_loadMoreFooterView stopAnimation];
        }
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.contentInset = _inset;
                         }
                         completion:^(BOOL finished) {}];
        
        _pullstate = DMPullRefreshNormal;
        _dragDirection = DMDraggingNone;
    }
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMPRINTMETHODNAME();
    
    if ([_pullDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [_pullDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

@end
