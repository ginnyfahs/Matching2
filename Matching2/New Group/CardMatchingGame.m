//
//  CardMatchingGame.m
//  Matching2
//
//  Created by Ginny Fahs on 1/4/19.
//  Copyright © 2019 Ginny's Games. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCard.h"
#import "Card.h"
#import "ViewController.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSString *resultString;
@property (nonatomic, getter=isThreeCardMatch) BOOL threeCardMatch;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, strong) NSMutableArray *selectedCards; // of Card

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

-(NSMutableArray *)addCardToSelection:(Card *)card
{
    if (!_selectedCards || [self.selectedCards count] > 2) {
        NSLog(@"creating selected cards array");
        _selectedCards = [[NSMutableArray alloc] init];
        if (!self.threeCardMatch) {
            return _selectedCards;
        }
    }
    [self.selectedCards addObject:card];
    card.chosen = YES;
    return _selectedCards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                        usingVC:(nonnull ViewController *)viewController
{
    self = [super init];
    
    if (self){
        self.viewController = viewController;
        self.threeCardMatch = NO;
        for (int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)matchTwoCards:(Card *)card cardsChosen:(NSMutableArray *)cardsChosen {
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            // match against another card
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    NSLog(@"inside conditional");
                    int matchScore = [card match:@[otherCard]];
                    [cardsChosen addObject:otherCard];
                    if(matchScore){
                        NSLog(@"there is a match score!");
                        self.score += matchScore + MATCH_BONUS;
                        card.matched = YES;
                        otherCard.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    [self showResult:cardsChosen withPoints:matchScore];
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

-(void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSMutableArray *cardsChosen = [[NSMutableArray alloc]init];
    [cardsChosen addObject:card];
    
    if (!self.threeCardMatch) {
        [self matchTwoCards:card cardsChosen:cardsChosen];
    } else {
        NSLog(@"3 card matching");
        if ([self.selectedCards count] == 3) {
            NSLog(@"three selected cards: %@", self.selectedCards);
            [self matchThreeCards:self.selectedCards];
            
        }
    }
}

-(void)matchThreeCards:(NSMutableArray *)selectedCards
{
    Card *firstCard = [selectedCards objectAtIndex:0];
    Card *secondCard = [selectedCards objectAtIndex:1];
    Card *thirdCard = [selectedCards objectAtIndex: 2];
    
    if (firstCard.isChosen && secondCard.isChosen && thirdCard.isChosen && !firstCard.isMatched && !secondCard.isMatched && !thirdCard.isMatched){
        NSLog(@"no cards are matched");
        int matchScore = [firstCard match:@[secondCard, thirdCard]];
        NSLog(@"match score: %d", matchScore);
        if (matchScore) {
            self.score += matchScore + MATCH_BONUS;
            firstCard.matched = YES;
            secondCard.matched = YES;
            thirdCard.matched = YES;
        } else {
            self.score -= MISMATCH_PENALTY;
            firstCard.chosen = NO;
            secondCard.chosen = NO;
            thirdCard.chosen = NO;
        }
        self.score -= COST_TO_CHOOSE;
        [self showResult:selectedCards withPoints:(matchScore)];
    }
}

-(void)showResult:(NSMutableArray *)cardsEvaluated withPoints:(int)points
{
    NSLog(@"points: %d", points);
    NSMutableArray *cardsEvaluatedContents = [[NSMutableArray alloc]init];
    for (PlayingCard* card in cardsEvaluated) {
        NSString *cardText = card.contents;
        [cardsEvaluatedContents addObject:cardText];
    }
    NSString *cardString = [cardsEvaluatedContents componentsJoinedByString:@" "];
    
    if (points > 0){
        self.resultString = [[cardString stringByAppendingString:@" match!"] stringByAppendingString:[NSString stringWithFormat:@"%d points rewarded", points]];
    } else {
        self.resultString = [[cardString stringByAppendingString:@" don't match!"] stringByAppendingString:[NSString stringWithFormat:@"%d points detracted", MISMATCH_PENALTY]];
    }
    NSLog(@"%@", self.resultString);
    [self.viewController setResultText:self.resultString];
}

-(void)setMatchTypeFromIndex:(NSUInteger)index
{
    if (index == 0) {
        self.threeCardMatch = NO;
        NSLog(@"2 card match!");
    } else {
        self.threeCardMatch = YES;
        NSLog(@"3 card match!");
    }
    
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] :nil;
}

-(instancetype)init
{
    return nil;
}

@end
