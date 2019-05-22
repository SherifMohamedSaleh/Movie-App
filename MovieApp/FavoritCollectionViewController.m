//
//  FavoritCollectionViewController.m
//  MovieApp
//
//  Created by Sherif Saleh on 4/14/19.
//  Copyright © 2019 Sherif Saleh. All rights reserved.
//

#import "FavoritCollectionViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MyTableViewController.h"

@interface FavoritCollectionViewController ()

@end

@implementation FavoritCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
RLMArray *movie ;
- (void)viewDidLoad {
    [super viewDidLoad];
     movie =[Movies allObjects];
    printf("------------%d--------" , movie.count);
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return movie.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
     UIImageView * imageView =(UIImageView *)[cell viewWithTag:9];
    
    NSString *urlAsStringImg = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w500%@",  movie [indexPath.row][@"posterPath"]];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString: urlAsStringImg] placeholderImage:[UIImage imageNamed:@"one.png"]];
    
    
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MyTableViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    [dvc setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:dvc animated:YES completion:nil];
//
//    MyTableViewController *Details = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
//    [self.navigationController pushViewController:Details animated:YES];

    [dvc setMo:movie[indexPath.row]];

}


@end
