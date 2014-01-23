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

#import <Foundation/Foundation.h>

/*!
 *  用户信息保存和读取
 */
@interface DMUserinfo : NSObject

/*!
 *  用户信息保存初始化
 *
 *  @param data <#data description#>
 *
 *  @return <#return value description#>
 */
- (id)initWithData:(NSDictionary*)data;

/*!
 *  用户信息读取初始化。
 *
 *  @return <#return value description#>
 */
- (id)initByRead;

/*!
 *  判断是否登录成功
 *
 *  @return <#return value description#>
 */
- (BOOL)isLogon;

- (void)signOut;

/*!
 *  初始化成功后，通过userinfo[key]读取具体信息
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
- (id)objectForKeyedSubscript:(id)key;

@end
