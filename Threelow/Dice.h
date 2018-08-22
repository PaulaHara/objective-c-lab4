//
//  Dice.h
//  Threelow
//
//  Created by paula on 2018-08-21.
//  Copyright © 2018 paula. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dice : NSObject

@property int currentValue;
@property Boolean isDiceHold;

- (id)initWithDiceHold;

- (int)rollDice;

- (void)holdDice:(Boolean)hold;

@end
