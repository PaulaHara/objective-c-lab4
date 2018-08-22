//
//  Dice.m
//  Threelow
//
//  Created by paula on 2018-08-21.
//  Copyright © 2018 paula. All rights reserved.
//

#import "Dice.h"
#import <stdlib.h>

@implementation Dice

- (id)initWithDiceHold{
    self = [super init];
    if(self){
        self.isDiceHold = false;
    }
    return self;
}

- (int)rollDice{
    if(!self.isDiceHold){
        self.currentValue = arc4random_uniform(6) + 1;
        return self.currentValue;
    }
    return self.currentValue;
}

- (void)holdDice:(Boolean)hold{
    self.isDiceHold = hold;
}

@end
