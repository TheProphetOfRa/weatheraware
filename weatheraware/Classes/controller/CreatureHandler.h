//
//  CreatureHandler.h
//  weatheraware
//
//  Created by David Hodgkinson on 16/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import <Foundation/Foundation.h>

enum CreatureType {
    eDragon,
    eGolum,
    eRat
};

@interface CreatureHandler : NSObject {
    
    CreatureHandler *_sharedHandler;
    
}

+ (CreatureHandler*) sharedCreatureHandler;

@end
