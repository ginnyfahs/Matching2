//
//  PlayingCard.m
//  Matching2
//
//  Created by Ginny Fahs on 1/3/19.
//  Copyright © 2019 Ginny's Games. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if ([self.suit isEqualToString:otherCard.suit]){
            score = 1;
        } else if (self.rank == otherCard.rank) {
            score = 4;
        }
    } else if ([otherCards count] == 2) {
        PlayingCard *firstOtherCard = [otherCards firstObject];
        PlayingCard *secondOtherCard = [otherCards objectAtIndex:1];
        if ([self.suit isEqualToString:firstOtherCard.suit] && [self.suit isEqualToString:secondOtherCard.suit]) {
            // give 3 card suit points
            score = 3;
        } else if ([self.suit isEqualToString:firstOtherCard.suit] || [self.suit isEqualToString:secondOtherCard.suit]) {
            // give 2 card suit points
            score = 1;
        } else if (self.rank == firstOtherCard.rank == secondOtherCard.rank){
            // give 3 card rank points
            score = 6;
        } else if (self.rank == firstOtherCard.rank || self.rank == secondOtherCard.rank) {
            // give 2 card rank points
            score = 2;
        }
    }
    return score;
}

- (NSString *) contents
{
    NSArray *rankStrings = @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    return [rankStrings[self.rank]stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because we provide custom setter AND getter

+ (NSArray *)validSuits
{
return @[@"♥︎",@"♠︎",@"♦︎",@"♣︎"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}
         
-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

+(NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

-(void)setRank: (NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

@end
