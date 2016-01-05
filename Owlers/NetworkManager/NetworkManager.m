//
//  NetworkManager.m
//  Owlers
//
//  Created by Abhishek on 05/01/16.
//  Copyright © 2016 JNT. All rights reserved.
//

#import "NetworkManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "SVProgressHUD.h"
#import "SharedPreferences.h"
#import "Header.h"

NSString *BaseURLLive   =   @"http://www.owlers.com/services";
NSString *BaseURLDemo   =   @"http://www.owlers.com/services";

@implementation NetworkManager

#pragma mark Get Base URL 

+ (NSString *)getBaseUrl{
    
    return BaseURLLive;
    
}

#pragma mark LoadAuction

+ (void)loadAcutionsForCity:(NSString *)cityID withComplitionHandler:(CompletionHandler)completionBlock{

    if ([SharedPreferences isNetworkAvailable])
    {
        [SVProgressHUD showWithStatus:@"Loading.." maskType:SVProgressHUDMaskTypeGradient];
        
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager GET:[NSString stringWithFormat:@"%@/auctions.php",BaseUrl] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [SVProgressHUD dismiss];
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            completionBlock(dataDict, nil);

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD dismiss];
            completionBlock(nil, error);
        }];
        
    }else{
        // Please connect to ineternet
    }
    
}

+ (void)loadLocationWithComplitionHandler:(CompletionHandler)completionBlock{

    if ([SharedPreferences isNetworkAvailable])
    {
        [SVProgressHUD showWithStatus:@"Loading.." maskType:SVProgressHUDMaskTypeGradient];
        
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager GET:[NSString stringWithFormat:@"%@/get_locations.php",BaseUrl] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            [SVProgressHUD dismiss];
            completionBlock(dataDict, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD dismiss];
            completionBlock(nil, error);
        }];
        
    }else{
        // Please connect to ineternet
    }
    
}

@end
