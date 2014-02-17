//
//  JsonLoader.m
//  weatheraware
//
//  Created by David Hodgkinson on 17/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "JsonLoader.h"

#import "CCFileUtils.h"

@implementation JsonLoader

static JsonLoader* _sharedLoader = nil;

+ (NSDictionary*) loadJsonFromFile:(NSString *)filename
{
    
    NSDictionary *jsonData;
    NSData *data;
    NSError *error;
    
    NSString *path = [[CCFileUtils sharedFileUtils] fullPathForFilename:filename];
    
    data = [NSData dataWithContentsOfFile:path];
    
    jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    return jsonData;
    
}

@end
