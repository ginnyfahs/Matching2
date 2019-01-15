//
//  Card.m
//  Matching2
//
//  Created by Ginny Fahs on 12/20/18.
//  Copyright © 2018 Ginny's Games. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]){
         score = 1;
        }
    }
    return score;
}

@end
