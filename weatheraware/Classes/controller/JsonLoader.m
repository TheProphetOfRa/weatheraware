//
//  JsonLoader.m
//  weatheraware
//
//  Created by David Hodgkinson on 17/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "JsonLoader.h"

#import "FileHandler.h"

@implementation JsonLoader

+ (NSDictionary*) loadJsonFromFile:(NSString *)filename
{
    
    NSDictionary *jsonData;
    NSData *data;
    NSError *error;
    
    data = [[FileHandler sharedFileHandler] loadFromFile:filename];
    
    jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    return jsonData;
    
}

+ (BOOL) saveJson:(NSDictionary*) json ToFile:(NSString*)filename
{
    NSData *data;
    NSError *error = nil;
    NSString *jsonString;
    
    data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error];
    
    if (error != nil)
    {
        printf("failed");
        return false;
    }
    
    jsonString = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];

    [[FileHandler sharedFileHandler] saveString:jsonString ToFile:filename];
    
    return true;
}

@end
