//
//  DeviceInformation.h
//  weatheraware
//
//  Created by David Hodgkinson on 17/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceInformation : NSObject
{
    DeviceInformation *_sharedInfo;
}

+ (DeviceInformation*) sharedDeviceInformation;
- (NSString*) getDeviceType;
- (NSString*) getDeviceModel;

@end
