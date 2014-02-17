//
//  JsonLoader.h
//  weatheraware
//
//  Created by David Hodgkinson on 17/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonLoader : NSObject

+ (NSDictionary*) loadJsonFromFile: (NSString*) filename;

@end
