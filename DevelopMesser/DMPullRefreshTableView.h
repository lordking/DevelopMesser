//
//  DMRefreshTableView.h
//  mygoods
//
//  Created by 金磊 on 14-1-7.
//  Copyright (c) 2014年 lordking. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 *  UITableView已经继承了UITableViewDelegate，并且将其delegate指向了自己。所以在使用是不能重复调用delegate。UITableViewDelegate由DMPullRefreshTableViewDelegate的相同名称的方法替代。
 */
@class DMPullRefreshTableView;

@protocol DMPullRefreshTableViewDelegate<NSObject>

@optional
/*!
 *  用于替代TableViewDelaget的代理方法
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)didTriggerRefreshHeaderView:(DMPullRefreshTableView *)pullRefreshTableView;
- (void)didTriggerLoadMoreFooterView:(DMPullRefreshTableView *)pullRefreshTableView;

@end

@interface DMPullRefreshTableView : UITableView<UIScrollViewDelegate, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet id <DMPullRefreshTableViewDelegate> pullDelegate;

- (void) stopLoading;

@end

