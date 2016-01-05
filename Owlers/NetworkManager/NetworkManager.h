//
//  NetworkManager.h
//  Owlers
//
//  Created by Abhishek on 05/01/16.
//  Copyright © 2016 JNT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompletionHandler)(id result, NSError *err);

@interface NetworkManager : NSObject

+ (void)loadAcutionsForCity:(NSString *)cityID withComplitionHandler:(CompletionHandler)completionBlock;
+ (void)loadLocationWithComplitionHandler:(CompletionHandler)completionBlock;

@end
