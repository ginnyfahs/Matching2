//
//  PlayingCard.h
//  Matching2
//
//  Created by Ginny Fahs on 1/3/19.
//  Copyright © 2019 Ginny's Games. All rights reserved.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end

NS_ASSUME_NONNULL_END
