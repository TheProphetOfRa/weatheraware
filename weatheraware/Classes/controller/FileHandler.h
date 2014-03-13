//
//  FileHandler.h
//  weatheraware
//
//  Created by David Hodgkinson on 13/03/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileHandler : NSObject
+ (FileHandler*) sharedFileHandler;

- (BOOL) validateFile:(NSString*) filename;
- (NSData*) loadFromFile:(NSString*) filename;
- (BOOL) saveString:(NSString*) contents ToFile:(NSString*) file;
@end
