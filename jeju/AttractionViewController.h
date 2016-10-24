//
//  AttractionViewController.h
//  jeju
//
//  Created by 황순호 on 2016. 10. 22..
//  Copyright © 2016년 magiceco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface AttractionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocationDegrees lat;
    CLLocationDegrees longi;
    BOOL firstLoc;
    NSMutableArray *dic;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
