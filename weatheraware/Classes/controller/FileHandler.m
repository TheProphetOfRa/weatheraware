//
//  FileHandler.m
//  weatheraware
//
//  Created by David Hodgkinson on 13/03/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "FileHandler.h"

@implementation FileHandler

static FileHandler* _sharedHandler = nil;

+ (FileHandler*) sharedFileHandler
{
    if (_sharedHandler == nil)
    {
        _sharedHandler = [[FileHandler alloc] init];
    }
    return _sharedHandler;
}

- (NSData*) loadFromFile:(NSString*) filename
{
    //make sure these files exist and are writeable
    //if not the function will make them so
    [[FileHandler sharedFileHandler] validateFile:filename];
    
    //Get the documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [paths objectAtIndex:0];
    
    //define the paths to the plist files with the high scores saved
    NSString *filePath = [docDirectory stringByAppendingPathComponent:filename];
    
    //fill the arrays with the contents of the plist files
    NSData *result = [NSData dataWithContentsOfFile:filePath];
    
    return result;
}

- (BOOL) saveString:(NSString *)contents ToFile:(NSString *)file
{
    //make sure these files exist and are writeable
    //if not the function will make them so
    [[FileHandler sharedFileHandler] validateFile:file];
    
    //Get the documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [paths objectAtIndex:0];
    
    //define the paths to the plist files with the high scores saved
    NSString *filePath = [docDirectory stringByAppendingPathComponent:file];
    
    NSError *error;
    
    //fill the arrays with the contents of the plist files
    [contents writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    return error == nil ? true : false;
}

-(BOOL) validateFile:(NSString *)fileName
{
    
    BOOL success;
    NSError *error;
    
    //Obtain the file manager
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    //Obtain the directory paths
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //Obtain the documents from the directory path
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //Specify the file name we are searching for
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    //Check if that file exists
    success = [fileManager fileExistsAtPath:writableDBPath];
    
    //If it exists then finish
    if (success) return success;
    
    //If the file does not exist then find the deafault file included in the app
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    
    //Copy the default file to the documents directory so it's writeable
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    
    //finish
    return success;
}

@end
