//
//  DetailType2ViewController.h
//  jeju
//
//  Created by 황순호 on 2016. 10. 23..
//  Copyright © 2016년 magiceco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DaumMap/MTMapView.h>
#import <CoreLocation/CoreLocation.h>


@interface DetailType2ViewController : UIViewController <MTMapViewDelegate>
- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet MTMapView *mapView;
@property (strong, nonatomic) NSDictionary *dataDic;
@property (weak, nonatomic) IBOutlet UILabel *titlelb;
@property (weak, nonatomic) IBOutlet UIImageView *mainImg;
@property (weak, nonatomic) IBOutlet UILabel *infolb;
@property (weak, nonatomic) IBOutlet UIButton *wayBtn;
@property CLLocationDegrees lat;
@property CLLocationDegrees longi;
@property (weak, nonatomic) IBOutlet UILabel *won1lb;

@end
