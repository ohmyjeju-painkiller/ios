//
//  DetailType2ViewController.m
//  jeju
//
//  Created by 황순호 on 2016. 10. 23..
//  Copyright © 2016년 magiceco. All rights reserved.
//

#import "DetailType2ViewController.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>

@interface DetailType2ViewController ()

@end

@implementation DetailType2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_mapView setDaumMapApiKey:@"88be0cc74cbb408bb1922d5edbb451e9"];
    _mapView.delegate = self;
    _mapView.baseMapType = MTMapTypeStandard;
    
    self.won1lb.layer.borderColor = self.won1lb.textColor.CGColor;
    self.won1lb.layer.borderWidth = 2;
    self.won1lb.layer.cornerRadius = self.won1lb.layer.frame.size.height/2;
    self.won1lb.layer.masksToBounds = YES;
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.wayBtn.layer.borderColor = [self.wayBtn titleColorForState:UIControlStateNormal].CGColor;
    self.wayBtn.layer.borderWidth = 2;
    self.wayBtn.layer.cornerRadius = self.wayBtn.layer.frame.size.height/2;
    
    NSLog(@"%@",_dataDic);
    
    [self.titlelb setText:[_dataDic valueForKey:@"name"]];
    [self.infolb setText:[_dataDic valueForKey:@"information"]];
    [self.mainImg setImageWithURL:[_dataDic valueForKey:@"images"][0]];
    //[_mapView setMapCenterPoint:[MTMapPoint mapPointWithGeoCoord:MTMapPointGeoMake([[_dataDic valueForKey:@"latitude"] floatValue], [[_dataDic valueForKey:@"longitude"] floatValue])] zoomLevel:9 animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    MTMapPOIItem* poiItem1 = [MTMapPOIItem poiItem];
    poiItem1.itemName = [_dataDic valueForKey:@"name"];
    poiItem1.mapPoint = [MTMapPoint mapPointWithGeoCoord:MTMapPointGeoMake([[_dataDic valueForKey:@"latitude"] floatValue],[[_dataDic valueForKey:@"longitude"] floatValue])];
    poiItem1.markerType = MTMapPOIItemMarkerTypeBluePin;
    poiItem1.showAnimationType = MTMapPOIItemShowAnimationTypeDropFromHeaven;
    poiItem1.draggable = YES;
    poiItem1.tag = 153;
    
    MTMapPOIItem* poiItem2 = [MTMapPOIItem poiItem];
    poiItem2.itemName = @"My Location";
    poiItem2.mapPoint = [MTMapPoint mapPointWithGeoCoord:MTMapPointGeoMake(_lat,_longi)];
    poiItem2.markerType = MTMapPOIItemMarkerTypeBluePin;
    poiItem2.showAnimationType = MTMapPOIItemShowAnimationTypeDropFromHeaven;
    poiItem2.draggable = YES;
    poiItem2.tag = 154;
    
    [_mapView addPOIItems:[NSArray arrayWithObjects:poiItem1,poiItem2, nil]];
    [_mapView fitMapViewAreaToShowAllPOIItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)goBtn:(id)sender {
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:[NSString stringWithFormat:@"daummaps://route?sp=%f,%f&ep=%f,%f&by=PUBLICTRANSIT",_lat,_longi,[[_dataDic valueForKey:@"latitude"] floatValue],[[_dataDic valueForKey:@"longitude"] floatValue]]]];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
