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

#import "DMUserinfo.h"

static NSString *USERINFO_KEY = @"userinfo";

@interface DMUserinfo ()
{
    NSDictionary *_data;
}

@end

@implementation DMUserinfo

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        _data = data;
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:_data forKey:USERINFO_KEY];
    }

    return self;
}

- (id)initByRead
{
    self = [super init];
    if (self) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        _data = [userDefaults objectForKey:USERINFO_KEY];
    }
    return self;
}

- (BOOL)isLogon
{
    if (_data && [_data count] > 0) {
        return YES;
    }
    
    return NO;
}

- (void)signOut
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:USERINFO_KEY];
    _data = nil;
}

- (id)objectForKeyedSubscript:(id)key
{
    if (_data != nil && [_data valueForKey:key]) {
        return _data[key];
    }
    
    return nil;
}


@end
