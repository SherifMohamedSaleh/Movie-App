//
//  MyTableViewController.m
//  MovieApp
//
//  Created by Sherif Saleh on 4/10/19.
//  Copyright © 2019 Sherif Saleh. All rights reserved.
//

#import "MyTableViewController.h"
#import "HCSStarRatingView.h"
#import <AFNetworking.h>
#import <Realm.h>
#import "Movies.h"

@interface MyTableViewController ()

@end

@implementation MyTableViewController
NSString *urlAsStringImg ;
NSString *urlAsStringReviews ;
NSString *urlAsStringVideos ;
NSMutableArray *ArrayReviews  ;
NSMutableArray *ArrayVideos  ;
 bool Fav  ;
-(void)viewWillAppear:(BOOL)animated{
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    Fav = false ;
    ArrayVideos =[NSMutableArray  new];
    ArrayReviews = [NSMutableArray new];
    [self isFav: _mo.identifier ] ;
 
    
    urlAsStringReviews = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@/reviews?api_key=42e82cf8cc14e69e50b2f1369c96c8f4", _mo.identifier  ];
     [self MakeRequest:urlAsStringReviews];

    urlAsStringVideos = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@/videos?api_key=42e82cf8cc14e69e50b2f1369c96c8f4", _mo.identifier  ];
    [self MakeRequestVideo:urlAsStringVideos];
    
    urlAsStringImg = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w500%@", _mo.posterPath ];
   
    

  

 
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(10, 700, 355 , 50)];
    starRatingView.maximumValue = 10;
    starRatingView.minimumValue = 0;
//    starRatingView.interactions= fal
  // CGFloat rateF = _rate  ;
    starRatingView.value = [_mo.voteAverage floatValue ] ;
    starRatingView.enabled=false;
   
    
    starRatingView.accessibilityAttributedValue =false ;
    starRatingView.tintColor = [UIColor blueColor];
   
    [self.view addSubview:starRatingView];
    
}


-(void)MakeRequestVideo:(NSString *) req{
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
           
            ArrayVideos=[responseObject objectForKey:@"results"];
           [self.tableView reloadData];
            
            
            //NSLog(@"%@",ArrayVideos[0][@"author"]);
                    }
    }];
    [dataTask resume];
    
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
            ArrayReviews=[responseObject objectForKey:@"results"];
            [self.tableView reloadData];
            
            //   printf(" hello    %l" , Array[0][@"id"]);
            
         //   NSLog(@"%@",ArrayReviews[0][@"author"]);
          //  printf("%d" , Array.count);
            //   [networkObserverDelegate handleSuccessWithJSONData: responseObject:classServiceName];
        }
    }];
    [dataTask resume];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    int num ;
//    if(ArrayReviews.count == 0){
//        if( ArrayVideos.count == 0){
//            num = 1 ;
//        }
//        num = 2 ;
//    }
//
//    else if( ArrayVideos.count == 0){
//        num = 2;
//    }
//    else
//    {
//    num = 3;
//}
//return num ;
    return 3;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{


    NSString *nameOfSection = @"";

    switch (section) {
        case 0:
            nameOfSection = @"Details";
            break;
        case 1:
            nameOfSection = @"reviews";
            break;
        case 2:
            nameOfSection = @"Videos";
            break;

        default:
            break;
    }


    return nameOfSection;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    NSInteger numberOfRows = 0;

    switch (section) {
        case 0:
            numberOfRows = 4 ;
            
          //  numberOfRows = males.count;
            break;
        case 1:
       //     if(ArrayReviews.count != 0){  numberOfRows = ArrayReviews.count ;} else{numberOfRows = 0; }
           
         //   numberOfRows = females.count;
            numberOfRows = ArrayReviews.count ;
            break;
        case 2:
        //    if(ArrayVideos.count  > 0){  numberOfRows = ArrayVideos.count ;}else{numberOfRows = 0; }
//            // videos
            numberOfRows = ArrayVideos.count ;
            break;
        default:
            break;
    }

    
    return numberOfRows;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger height = 0 ;
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                
                 height = 100 ;
            }else if (indexPath.row == 1){
                
                height = 300 ;
            }else if (indexPath.row == 2){
                
                height = 200 ;
            }
            else if (indexPath.row == 3){
                
               height = 200 ;
                
            }
//            else if (indexPath == 5){
//                height = 200 ;
//            }
//
            //  numberOfRows = males.count;
            break;
        case 1:
            height = 100 ;
            //   numberOfRows = females.count;
            break;
        case 2:
            height =100 ;
            //            // videos
            break;
        default:
            break;
    }
    
    return height;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 //   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
      NSString *cellIdentifier = @"";
    
    switch (indexPath.section) {
        case 0:
 
            if (indexPath.row == 0) {
                
                cellIdentifier = @"cellName";
            }else if (indexPath.row == 1){
                
                cellIdentifier = @"cellImage";
            }else if (indexPath.row == 2){
                
                cellIdentifier = @"cellOverView";
            }
            else if (indexPath.row == 3){
                
                cellIdentifier = @"cellDate";
            }

            break;
//
        case 1:  // Females
//          //  cell.textLabel.text = females[indexPath.row];
            cellIdentifier =@"cellReview";
            break;
        case 2:
            cellIdentifier =@"cellReview";
//            // asdasdf
            break ;
    
        default:
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
     UIImageView *moviePic;
     UITextView *movieOverview;
     UILabel *movieName;
     UILabel *movieDate;
    HCSStarRatingView *rateView ;
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                
                movieName = (UILabel*)[cell viewWithTag:1];
                movieName.text = _mo.title ;
                
            }else if (indexPath.row == 1){
                moviePic = (UIImageView*)[cell viewWithTag:2];
                //_moviePic.image =[]
                [moviePic sd_setImageWithURL:[NSURL URLWithString: urlAsStringImg] placeholderImage:[UIImage imageNamed:@"one.png"]];
            }else if(indexPath.row == 2){
                movieOverview =(UITextView *)[cell viewWithTag:3];
                movieOverview.text = _mo.overview ;}
            else if (indexPath.row == 3){
                movieDate =(UILabel *)[cell viewWithTag:4];
                movieDate.text = _mo.releaseDate ;
            } else if (indexPath.row  == 4){
                rateView =(HCSStarRatingView *) [cell viewWithTag:8];
                
                rateView.maximumValue = 10;
                rateView.minimumValue = 0;
                rateView.accessibilityAttributedValue =false ;
                rateView.tintColor = [UIColor blueColor];
                rateView.tintColor = [UIColor redColor];
              //  CGFloat rateF = _rate  ;
         //       rateView.value = _rate  ;
                [self.view addSubview:rateView];
                
                
                
            }
            
            break;
        case 1:
            if(ArrayReviews.count != 0){
            cell.textLabel.text =ArrayReviews[indexPath.row][@"author"];
            cell.detailTextLabel.text =ArrayReviews[indexPath.row][@"content"];
            }
           break ;
        case 2:
            if(ArrayVideos.count != 0){
            cell.textLabel.text =ArrayVideos[indexPath.row][@"name"];
            cell.detailTextLabel.text =@" ";
    }
    break ;
        default:
            
            break;
    }
   
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if(indexPath.section == 2){
        
    NSString *stringURL =[NSString stringWithFormat:@"http://www.youtube.com/watch?v=%@" , ArrayVideos[indexPath.row][@"key"]];
        NSURL *url = [NSURL URLWithString:stringURL];
        [[UIApplication sharedApplication] openURL:url];
        
      
   }

}


-(void)isFav:(NSNumber*)movId{
    RLMResults<Movies *> *myFav ;

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"identifier = %@",
                         movId];
    myFav = [Movies objectsWithPredicate:pred];
    if(myFav.count!=0){
        Fav=true;
    }
}
-(void)deleteMov:(NSNumber*)movId{
    RLMResults<Movies *> *myFav ;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"identifier=%@",
                         movId];
    myFav = [Movies objectsWithPredicate:pred];
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    if(myFav.count!=0){
        [realm beginWriteTransaction];
        [realm deleteObject:[myFav firstObject]];
        [realm commitWriteTransaction];
        NSLog(@"removed movie-----");
    }
}

- (IBAction)favoriteBtn:(id)sender {
  
    if (!Fav){
         [_button setTitle:@"remove from favorite" forState:UIControlStateNormal];
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addObject:_mo];
        [realm commitWriteTransaction];
        Fav = true ;
    }
    else{
          [_button setTitle:@"add to favorite" forState:UIControlStateNormal];
//        UIButton *btn = (UIButton *)sender;
//        [btn setImage:[UIImage imageNamed:@"red.png"] forState:UIControlStateNormal];
          [self deleteMov:_mo.identifier];
    }
}
@end

