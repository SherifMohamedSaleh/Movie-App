
//
//  MyCollectionViewController.m
//  SDWebImage
//
//  Created by Sherif Saleh on 4/5/19.
//  Copyright © 2019 Sherif Saleh. All rights reserved.
//

#import "MyCollectionViewController.h"
#import <AFNetworking.h>
#import "MyTableViewController.h"

#import "Movies.h"
#define API_KEY @"42e82cf8cc14e69e50b2f1369c96c8f4"
#define TOP @"top_rated";
#define MOST @"popular"

@interface MyCollectionViewController ()

@end


@implementation MyCollectionViewController
NSMutableArray *Array  ;
NSMutableDictionary *dic ;
NSURLRequest *request ;
NSMutableData *myData ;
@synthesize requestType;
NSString * urlAsString ;
NSString * type ;


static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   Array=[NSMutableArray new];
    dic = [NSMutableDictionary new ];
     urlAsString = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/top_rated?api_key=%@", API_KEY];
    [self MakeRequest:urlAsString];
    
   
}
-(void)MakeRequest:(NSString *) req{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [[NSURL alloc] initWithString:req];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSLog(@"%@" , request);
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"%@" , error);
        } else {
            
            NSLog(@"response");
            NSLog(@"%@" , response);
            NSLog(@"%@" ,responseObject);
            
            // retrieve the JSON object from somewhere
            //    NSData* jsonData = [NSData dataWithBytes:str.UTF8String length:str.length];
            
         //   [Array removeAllObjects];
            //  Array=[NSMutableArray new];
            Array=[responseObject objectForKey:@"results"];
            [self.collectionView reloadData];
            
            //   printf(" hello    %l" , Array[0][@"id"]);
            
            NSLog(@"%@",Array[0][@"poster_path"]);
            printf("%d" , Array.count);
            //   [networkObserverDelegate handleSuccessWithJSONData: responseObject:classServiceName];
        }
    }];
    [dataTask resume];
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
#warning Incomplete implementation, return the number of items
    return   [Array count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    UIImageView * imageView =(UIImageView *)[cell viewWithTag:1];
  //  [imageView setImage:[UIImage imageNamed:@"one.png"]];
    NSString *urlAsStringImg = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w500%@",  Array [indexPath.row][@"poster_path"]];

   [imageView sd_setImageWithURL:[NSURL URLWithString: urlAsStringImg] placeholderImage:[UIImage imageNamed:@"one.png"]];
    
    
    // Configure the cell
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSError *error;
//    Movies *movie = [[Movies alloc] initWithString:myJson error:&error];
    MyTableViewController *Details = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    [self.navigationController pushViewController:Details animated:YES];
    Movies *m =[Movies new];
    m.title =  Array[indexPath.row][@"original_title"] ;
    m.posterPath = Array[indexPath.row][@"backdrop_path"] ;
    m.releaseDate = Array[indexPath.row][@"releaseDate"];
    m.voteAverage =Array[indexPath.row][@"vote_average"];
    m.overview =Array[indexPath.row][@"overview"];
    m.identifier =Array[indexPath.row][@"id"];
   [Details setMo:m];
//    
   

  //		  [Details setMoviePic:Array.];
}

#pragma mark <UICollectionViewDelegate>



- (IBAction)RequestAPI:(id)sender {
   
    if (requestType.selectedSegmentIndex== 0) {
        
       NSString * topRated = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/top_rated?api_key=%@", API_KEY];
             [self MakeRequest:topRated];
      
    } else if(requestType.selectedSegmentIndex == 1) {
        
       NSString *popular = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/popular?api_key=%@", API_KEY];

        [self MakeRequest:popular];
       
    }

}
@end
