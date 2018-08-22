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

- (int)rollDice{
    int diceNumber = arc4random_uniform(6) + 1;
    self.currentValue = diceNumber;
    return diceNumber;
}

@end
