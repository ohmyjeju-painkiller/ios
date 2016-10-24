//
//  ViewController.m
//  jeju
//
//  Created by 황순호 on 2016. 10. 22..
//  Copyright © 2016년 magiceco. All rights reserved.
//

#import "ViewController.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.btn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.btn.layer.borderWidth = 2;
    self.btn.layer.cornerRadius = self.btn.layer.frame.size.height/2;
    self.btn.alpha = 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth/4) / pageWidth) + 1;
    self.pageControl.currentPage = page;
    
    if(page == 3) {
        if(self.btn.alpha < 1) {
            self.btn.alpha = self.btn.alpha + 0.03;
        }
    }else {
        if(self.btn.alpha > 0) {
            self.btn.alpha = self.btn.alpha - 0.05;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = (int)self.pageControl.currentPage;
    
    if(page == 3) {
        self.btn.alpha = 1;
    }else {
        self.btn.alpha = 0;
    }}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goAction:(id)sender {
    [SVProgressHUD show];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *url = @"https://ohmyjeju.herokuapp.com/users/";
    NSDictionary *params = @{ @"gender": @"female"};
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [SVProgressHUD dismiss];
        UINavigationController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewNaviController"];
        [self presentViewController:vc animated:YES completion:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
    

}

@end
