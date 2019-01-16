//
//  ViewController.h
//  Matching2
//
//  Created by Ginny Fahs on 12/20/18.
//  Copyright © 2018 Ginny's Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface ViewController : UIViewController

-(void)setResultText:(NSString *)resultString;

// protected
// for subclasses
- (Deck *)createDeck; // abstract

@end

