//
//  PlayingCardDeck.m
//  Matching2
//
//  Created by Ginny Fahs on 1/3/19.
//  Copyright © 2019 Ginny's Games. All rights reserved.
//

#import "PlayingCard.h"
#import "PlayingCardDeck.h"

@implementation PlayingCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:NO];
            }
        }
    }
    return self;
}

@end
