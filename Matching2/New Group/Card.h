//
//  Card.h
//  Matching2
//
//  Created by Ginny Fahs on 12/20/18.
//  Copyright © 2018 Ginny's Games. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

-(int)match:(NSArray *)otherCards;

@end

NS_ASSUME_NONNULL_END
