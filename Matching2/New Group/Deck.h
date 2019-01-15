//
//  Deck.h
//  Matching2
//
//  Created by Ginny Fahs on 1/3/19.
//  Copyright © 2019 Ginny's Games. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "PlayingCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (Card *) drawRandomCard;
- (PlayingCard *) flipTopCard;

@end

NS_ASSUME_NONNULL_END
