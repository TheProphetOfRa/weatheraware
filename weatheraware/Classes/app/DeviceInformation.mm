//
//  DeviceInformation.m
//  weatheraware
//
//  Created by David Hodgkinson on 17/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "DeviceInformation.h"

#include <sys/types.h>
#include <sys/sysctl.h>

@implementation DeviceInformation

static DeviceInformation *_sharedInfo = nil;

+ (NSString*) convertToSaneOutput:(NSString*) model
{
    if ([model isEqualToString:@"iPhone1,1"])
    {
        return @"iPhone";
    }
    else if ([model isEqualToString:@"iPhone1,2"])
    {
        return @"iPhone3G";
    }
    else if ([model isEqualToString:@"iPhone2,1"])
    {
        return @"iPhone3GS";
    }
    else if ([model isEqualToString:@"iPhone3,1"] || [model isEqualToString:@"iPhone3,3"])
    {
        return @"iPhone4";
    }
    else if ([model isEqualToString:@"iPhone4,1"])
    {
        return @"iPhone4S";
    }
    else if ([model isEqualToString:@"iPhone5,1"] || [model isEqualToString:@"iPhone5,2"])
    {
        return @"iPhone5";
    }
    else if ([model isEqualToString:@"iPhone5,3"] || [model isEqualToString:@"iPhone5,4"])
    {
        return @"iPhone5C";
    }
    else if ([model isEqualToString:@"iPhone6,1"] || [model isEqualToString:@"iPhone6,2"])
    {
        return @"iPhone5S";
    }
    else if ([model isEqualToString:@"iPad1,1"])
    {
        return @"iPad";
    }
    else if ([model isEqualToString:@"iPad2,1"] ||
             [model isEqualToString:@"iPad2,2"] ||
             [model isEqualToString:@"iPad2,3"] ||
             [model isEqualToString:@"iPad2,4"])
    {
        return @"iPad2";
    }
    else if ([model isEqualToString:@"iPad3,1"] ||
             [model isEqualToString:@"iPad3,2"] ||
             [model isEqualToString:@"iPad3,3"])
    {
        return @"iPad3";
    }
    else if ([model isEqualToString:@"iPad3,4"] ||
             [model isEqualToString:@"iPad3,5"] ||
             [model isEqualToString:@"iPad3,6"])
    {
        return @"iPad4";
    }
    else if ([model isEqualToString:@"iPad2,5"] ||
             [model isEqualToString:@"iPad2,6"] ||
             [model isEqualToString:@"iPad2,7"])
    {
        return @"iPad mini";
    }
    else if ([model isEqualToString:@"iPod1,1"])
    {
        return @"iPod Touch";
    }
    else if ([model isEqualToString:@"iPod2,1"])
    {
        return @"iPod Touch 2G";
    }
    else if ([model isEqualToString:@"iPod3,1"])
    {
        return @"iPod Touch 3G";
    }
    else if ([model isEqualToString:@"iPod4,1"])
    {
        return @"iPod Touch 4G";
    }
    else if ([model isEqualToString:@"iPod5,1"])
    {
        return @"iPod Touch 5G";
    }
    return model;
}

+ (NSString*) getDeviceModel
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return [self convertToSaneOutput:platform];
}

+ (NSString*) getDeviceType
{
    return [[UIDevice currentDevice] model];
}

@end
