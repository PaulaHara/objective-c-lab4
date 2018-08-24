//
//  NumberUtils.m
//  Threelow
//
//  Created by paula on 2018-08-23.
//  Copyright © 2018 paula. All rights reserved.
//

#import "NumberUtils.h"

@implementation NumberUtils

+ (int) getNumberizeWord:(NSString *)input{
    if([input isEqualToString:@"0"]){
        return 0;
    }
    
    int number = (int) [input integerValue];
    if(number == 0){
        return -1;
    }
    return number;
}

@end
