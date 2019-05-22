//
//  MyTableViewController.h
//  MovieApp
//
//  Created by Sherif Saleh on 4/10/19.
//  Copyright © 2019 Sherif Saleh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "Movies.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyTableViewController : UITableViewController

@property Movies *mo ;

- (IBAction)favoriteBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *button;




@end

NS_ASSUME_NONNULL_END
