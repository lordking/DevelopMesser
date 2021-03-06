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
#import "TestFlight.h"

#define NSLog TFLog

//打印日志
#ifdef DEBUG
#define DMPRINT(__FORMAT__, ...) NSLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DMPRINT(xx, ...)  ((void)0)
#endif // #ifdef DEBUG

// 打印函数名
#define DMPRINTMETHODNAME() DMPRINT(@"%s", __PRETTY_FUNCTION__)


@interface DMDebug : NSObject

@end
