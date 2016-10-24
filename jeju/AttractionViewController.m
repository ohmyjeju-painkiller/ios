//
//  AttractionViewController.m
//  jeju
//
//  Created by 황순호 on 2016. 10. 22..
//  Copyright © 2016년 magiceco. All rights reserved.
//

#import "AttractionViewController.h"
#import "ListTableViewCell.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>
#import "DetailType1ViewController.h"

@interface AttractionViewController ()

@end

@implementation AttractionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"ListTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"listTableViewCell"];
    
    dic = [[NSMutableArray alloc]init];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestWhenInUseAuthorization];
    
    [locationManager startUpdatingLocation];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dic count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"listTableViewCell";
    
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.lb.text = [dic valueForKey:@"name"][indexPath.row];
    [cell.img setImageWithURL:[dic valueForKey:@"images"][indexPath.row][0]];
    
    cell.sponlb.layer.borderColor = cell.sponlb.textColor.CGColor;
    cell.sponlb.layer.borderWidth = 2;
    cell.sponlb.layer.cornerRadius = cell.sponlb.layer.frame.size.height/2;
    
    if(indexPath.row==0) {
        cell.sponlb.hidden = NO;
    }else{
        cell.sponlb.hidden = YES;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    
    DetailType1ViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailType1ViewController"];
    vc.dataDic = [dic objectAtIndex:indexPath.row];
    vc.lat = lat;
    vc.longi = longi;
    [self.navigationController pushViewController:vc animated:true];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [SVProgressHUD show];

    NSLog(@"didUpdateToLocation: %@", newLocation);
    
    if(firstLoc == NO){
        firstLoc = YES;
        [self locUpdate];
    }
}

- (void)locUpdate {
    CLLocation *currentLocation = locationManager.location;
    
    if (currentLocation != nil) {
        [locationManager stopUpdatingLocation];
        longi = currentLocation.coordinate.longitude;
        lat = currentLocation.coordinate.latitude;
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        NSString *url = @"https://ohmyjeju.herokuapp.com/places/attraction";
        NSDictionary *params = @{@"longitude": @(longi),@"latitude": @(lat),@"user_id": @"15"};
        
        [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            dic = responseObject;
            NSLog(@"%@",dic);
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            [SVProgressHUD dismiss];
        }];
    }else{
        //[self showAlert:@"알림" msg:@"위치 정보를 받아올수 없습니다."];
    }
}

@end
