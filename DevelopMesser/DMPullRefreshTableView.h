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

