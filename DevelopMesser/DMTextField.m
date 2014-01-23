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

#import "DMTextField.h"

@implementation DMTextField

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //todo
    }
    
    return self;
}

-(CGRect)textRectForBounds:(CGRect)bounds
{
    
    return CGRectInset( bounds , self.leftView.bounds.size.width + 10 , 0 );
}

-(CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset( bounds , self.leftView.bounds.size.width + 10 , 0 );
}

-(void)setLeftImage:(NSString *)imageName frame:(CGRect)rect
{
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:rect];
    leftImageView.image = [UIImage imageNamed:imageName];
    [self setLeftView:leftImageView];
    self.leftViewMode = UITextFieldViewModeAlways;
}

@end
