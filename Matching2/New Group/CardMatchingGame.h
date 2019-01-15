//
//  CardMatchingGame.h
//  Matching2
//
//  Created by Ginny Fahs on 1/4/19.
//  Copyright © 2019 Ginny's Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"
#import "PlayingCard.h"
@class ViewController;

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame : NSObject

// designated initializer
-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck usingVC:(ViewController *)viewController;
-(void)chooseCardAtIndex:(NSUInteger)index;
-(void)setMatchTypeFromIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;
-(NSMutableArray *)addCardToSelection:(Card *)card;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSString *resultString;
@property (nonatomic, weak) ViewController *viewController;

@end

NS_ASSUME_NONNULL_END
