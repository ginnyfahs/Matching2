//
//  Deck.m
//  Matching2
//
//  Created by Ginny Fahs on 1/3/19.
//  Copyright © 2019 Ginny's Games. All rights reserved.
//

#import "Deck.h"
#import "PlayingCard.h"

@interface Deck()
@property(strong, nonatomic)NSMutableArray<Card *> *cards; // of Card

@end

@implementation Deck

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

- (void)addCard:(Card *)card
{
    [self addCard:card atTop: NO];
}

- (Card *) drawRandomCard
{
    Card *randomCard = nil;
    
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

- (PlayingCard *) flipTopCard
{
    return self.cards[0];
}

@end
