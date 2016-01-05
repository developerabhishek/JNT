//
//  SharedPreferences.m
//  Owlers
//
//  Created by Abhishek on 05/01/16.
//  Copyright © 2016 JNT. All rights reserved.
//

#import "SharedPreferences.h"
#import "Connectionmanager.h"


@implementation SharedPreferences

static SharedPreferences *sharedInstance;

+ (SharedPreferences*) sharedInstance
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[SharedPreferences alloc] init];
    });
    
    return sharedInstance;
}

+ (BOOL)isNetworkAvailable{
   return [[ConnectionManager getSharedInstance] isConnectionAvailable];
}


@end
