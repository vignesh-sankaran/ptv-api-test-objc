//
//  ViewController.m
//  ptv-api-test-objc
//
//  Created by Vignesh Sankaran on 8/02/2016.
//  Copyright © 2016 Vignesh Sankaran. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property NSInteger loadingMessageViewId;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loadingMessageViewId = 100;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onHealthCheckResponse:) name:@"HealthCheckResponded" object:nil];
    self.viewModel = [[PTVHealthCheckViewModel alloc] init];
    
    
    UILabel *mainTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 200, 100)];
    [mainTitle setFont:[UIFont systemFontOfSize:20]];
    [mainTitle setText:@"PTV API Health Check"];
    [self.view addSubview:mainTitle];
    
    UILabel *loadingMessage = [[UILabel alloc] initWithFrame:CGRectMake(75, 100, 200, 75)];
    [loadingMessage setTag:self.loadingMessageViewId];
    [loadingMessage setFont:[UIFont systemFontOfSize:16]];
    [loadingMessage setText:@"connecting..."];
    [self.view addSubview:loadingMessage];
    
    
}

-(void)onHealthCheckResponse:(NSNotification *)notification
{
    for(id view in [self.view subviews])
    {
       if ([view tag] == self.loadingMessageViewId)
       {
           [view removeFromSuperview];
           break;
       }
    }
    
    UILabel *clientClockHeading = [[UILabel alloc] initWithFrame:CGRectMake(75, 100, 200, 100)];
    UILabel *securityTokenHeading = [[UILabel alloc] initWithFrame:CGRectMake(75, 125, 200, 100)];
    UILabel *memCacheHeading = [[UILabel alloc] initWithFrame:CGRectMake(75, 150, 200, 100)];
    UILabel *databaseHeading = [[UILabel alloc] initWithFrame:CGRectMake(75, 175, 200, 100)];
    
    UILabel *clientClockResult = [[UILabel alloc] initWithFrame:CGRectMake(275, 100, 100, 100)];
    UILabel *securityTokenResult = [[UILabel alloc] initWithFrame:CGRectMake(275, 125, 100, 100)];
    UILabel *memCacheResult = [[UILabel alloc] initWithFrame:CGRectMake(275, 150, 100, 100)];
    UILabel *databaseResult = [[UILabel alloc] initWithFrame:CGRectMake(275, 175, 100, 100)];
    
    [clientClockHeading setFont:[UIFont systemFontOfSize:16]];
    [securityTokenHeading setFont:[UIFont systemFontOfSize:16]];
    [memCacheHeading setFont:[UIFont systemFontOfSize:16]];
    [databaseHeading setFont:[UIFont systemFontOfSize:16]];
    
    [clientClockResult setFont:[UIFont systemFontOfSize:16]];
    [securityTokenResult setFont:[UIFont systemFontOfSize:16]];
    [memCacheResult setFont:[UIFont systemFontOfSize:16]];
    [databaseResult setFont:[UIFont systemFontOfSize:16]];
    
    [clientClockHeading setText:@"clientClockOk"];
    [securityTokenHeading setText:@"securityTokenOk"];
    [memCacheHeading setText:@"memCacheOk"];
    [databaseHeading setText:@"databaseOk"];
    
    [clientClockResult setText:self.viewModel.clientClockStatus];
    [securityTokenResult setText:self.viewModel.securityTokenStatus];
    [memCacheResult setText:self.viewModel.memCacheStatus];
    [databaseResult setText:self.viewModel.databaseStatus];
    
    [self.view addSubview:clientClockHeading];
    [self.view addSubview:securityTokenHeading];
    [self.view addSubview:memCacheHeading];
    [self.view addSubview:databaseHeading];
    
    [self.view addSubview:clientClockResult];
    [self.view addSubview:securityTokenResult];
    [self.view addSubview:memCacheResult];
    [self.view addSubview:databaseResult];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
