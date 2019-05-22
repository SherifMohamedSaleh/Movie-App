//
//  MyCollectionViewController.h
//  MovieApp
//
//  Created by Sherif Saleh on 4/10/19.
//  Copyright © 2019 Sherif Saleh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>


NS_ASSUME_NONNULL_BEGIN

@interface MyCollectionViewController : UICollectionViewController

@property (strong, nonatomic) IBOutlet UISegmentedControl *requestType;

- (IBAction)RequestAPI:(id)sender;

@end

NS_ASSUME_NONNULL_END
