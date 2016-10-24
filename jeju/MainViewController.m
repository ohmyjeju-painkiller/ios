//
//  MainViewController.m
//  jeju
//
//  Created by 황순호 on 2016. 10. 22..
//  Copyright © 2016년 magiceco. All rights reserved.
//

#import "MainViewController.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *currentTime = [dateFormatter stringFromDate:today];
    
    NSArray* foo = [currentTime componentsSeparatedByString: @" "];
    
    [self.timeLb1 setText:[foo objectAtIndex: 1]];
    [self.timeLb2 setText:[foo objectAtIndex: 0]];

    
    [SVProgressHUD show];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *url = @"https://ohmyjeju.herokuapp.com/weather/";
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        if([[responseObject valueForKey:@"summary"] isEqualToString:@"rain"]) {
            NSLog(@"비");
            [self.wImg setImage:[UIImage imageNamed:@"weather_rain"]];
        }else if([[responseObject valueForKey:@"summary"] isEqualToString:@"clouds"]) {
            NSLog(@"구름");
            [self.wImg setImage:[UIImage imageNamed:@"weather_rain"]];
        }else if([[responseObject valueForKey:@"summary"] isEqualToString:@"clear"]) {
            NSLog(@"쩅쩅");
            [self.wImg setImage:[UIImage imageNamed:@"weather_sun"]];
        }
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
