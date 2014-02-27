//
//  MetricManager.m
//  weatheraware
//
//  Created by David Hodgkinson on 27/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "MetricManager.h"

@implementation MetricManager

- (void) sendData
{
    NSString* post = [self formatData];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString* postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"davidh.us-lot.org/cgi-bin/savejson.cgi?"]]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"text/plain" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPBody:postData];
    
    NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (conn)
    {
        printf("Success");
    }
}

- (NSString*) formatData
{
    NSString* data;
    NSString*filename = [NSString stringWithFormat:@"%@.json", [[[UIDevice currentDevice] identifierForVendor] UUIDString]];

    
    data = [NSString stringWithFormat:@"filename=%@&jsonstring={\"UUID\":%@, \"metrics\":\"%@\"}",filename ,[[[UIDevice currentDevice] identifierForVendor] UUIDString], _metrics];
    
    return data;
}

- (void) pullData
{
    NSData* data;
    NSError* error;
    
    data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@""]];
    
    _metrics = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
}

- (void) updateValue:(id)value forKey:(NSString *)key
{
    
}

- (id) getCurrentValueForKey:(NSString*) key
{
    return [_metrics valueForKey:key];
}

@end
