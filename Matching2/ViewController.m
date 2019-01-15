//
//  ViewController.m
//  Matching2
//
//  Created by Ginny Fahs on 12/20/18.
//  Copyright © 2018 Ginny's Games. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) Deck *deck; // of Deck
@property (strong, nonatomic) PlayingCardDeck *playingCardDeck; // of PlayingCardDeck
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation ViewController

//@synthesize segmentedControl;

-(CardMatchingGame *)game
{
    if (! _game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                           usingDeck:[self createDeck]
                                                             usingVC:self];
    return _game;
}

-(CardMatchingGame *)redealGame
{
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                              usingDeck:[self createDeck]
                                                usingVC:self];
    return _game;
}

- (Deck*)createDeck{
    return [[PlayingCardDeck alloc] init];
}

-(IBAction)touchRedealButton:(UIButton *)sender
{
    [self redealGame];
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self.game addCardToSelection:([self.game cardAtIndex:cardIndex])];
    [self updateUI];
}

-(IBAction)segmentController:(UISegmentedControl *)sender
{
    [self.game setMatchTypeFromIndex:sender.selectedSegmentIndex];
}

-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                    forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %@", @(self.game.score)];
}

-(void)setResultText:(NSString *)resultString
{
    NSLog(@"%@", self.game.resultString);
    self.resultLabel.text = [NSString stringWithFormat: @"%@", (self.game.resultString)];
}

-(NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}


@end
