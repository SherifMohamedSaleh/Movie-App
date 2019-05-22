//
//  Movies.h
//  MovieApp
//
//  Created by Sherif Saleh on 4/10/19.
//  Copyright © 2019 Sherif Saleh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>


NS_ASSUME_NONNULL_BEGIN

@interface Movies : RLMObject
@property  NSNumber <RLMInt> *identifier;
@property  NSNumber  <RLMDouble>* voteAverage;
@property  NSString *title;
@property  NSString *posterPath;
@property  NSString *backdropPath;
@property  NSString *overview;
@property  NSString *releaseDate;

@end

NS_ASSUME_NONNULL_END
