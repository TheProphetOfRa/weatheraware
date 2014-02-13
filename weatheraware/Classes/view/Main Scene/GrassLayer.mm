//
//  GrassLayer.m
//  weatheraware
//
//  Created by David Hodgkinson on 13/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "GrassLayer.h"

#import "AssetHandler.h"
#import "LongGrass.h"

#import "CCSprite.h"

#include <map>

@implementation GrassLayer

- (id) initWithScreenSize: (CGSize) size {
    
    if (self = [super init]) {
        
        [self setContentSize:size];
        
        [self initGrassSprites];
        
    }
    return self;
}

- (void) initGrassSprites {
    
    //Used to find size of grass sprite
    CCSprite *grassSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"longgrass.png"]];
    
    //srand(354345678767);
    /*DOG*/srand(641623468973425);
    //srand(7983563024);
    //*MONKEYsrand(784);
    //*GIRAFFEEsrand(42);
    //*RANDOMsrand((int)grassSprite);
    //srand(6.28);
    
    //maps to hold data while cellular automation is processed
    std::map<std::pair<int, int>, bool> grassMap;
    std::map<std::pair<int, int>, bool> tempMap;
    
    //inital fill rate of screen
    const float fillProb = 60;
    
    //Scatter grass over the map
    for (int i = 0 ; i < [self contentSize].width / [grassSprite contentSize].width ; i++){
        for (int j = 0 ; j < [self contentSize].height / [grassSprite contentSize].height ; j++){
            (rand()%100 < fillProb) ? grassMap.insert(std::make_pair(std::make_pair(i, j), true)) : grassMap.insert(std::make_pair(std::make_pair(i, j), false));
        }
    }
    
    //First generation algorithm to block out map
    for (int k = 0 ; k < 4 ; k++){
        tempMap = grassMap;
        for (int i = 0 ; i < [self contentSize].width / [grassSprite contentSize].width ; i++){
            for (int j = 0 ; j < [self contentSize].height / [grassSprite contentSize].height ; j++){
                if ([self getAdjacentGrassTilesForTile:std::make_pair(i, j) inMap:grassMap] < 5 ||
                    [self getAdjacentGrassTilesForTile:std::make_pair(i, j) inMap:grassMap] > 7){
                    tempMap.find(std::make_pair(i, j))->second = false;
                }else{
                    tempMap.find(std::make_pair(i, j))->second = true;
                }
            }
        }
        grassMap = tempMap;
    }
    //Second generation alogrithm to refine map
    for (int k = 0 ; k < 3 ; k++){
        tempMap = grassMap;
        for (int i = 0 ; i < [self contentSize].width / [grassSprite contentSize].width ; i++){
            for (int j = 0 ; j < [self contentSize].height / [grassSprite contentSize].height ; j++){
                if ([self getAdjacentGrassTilesForTile:std::make_pair(i, j) inMap:grassMap] < 4){
                    tempMap.find(std::make_pair(i, j))->second = false;
                }else{
                    tempMap.find(std::make_pair(i, j))->second = true;
                }
            }
        }
        grassMap = tempMap;
    }
    
    LongGrass *grass;
    
    //After map is generated create the sprites and add them to the layer
    for (std::map<std::pair<int, int>, bool>::iterator it = grassMap.begin() ; it != grassMap.end() ; it++) {
        if (it->second == true) {
            CGPoint gPos;
            gPos.x = it->first.first;
            gPos.y = it->first.second;
            grass = [[LongGrass alloc] initWithGridPos:gPos];
            [self addChild:grass];
            [_grassArray addObject:grass];
        }
    }
    
}

- (int) getAdjacentGrassTilesForTile: (std::pair<int, int>) tile inMap: (std::map<std::pair<int, int>, bool>) map {
    
    const int x = tile.first;
    const int y = tile.second;
    
    int surroundingGrass = 0;
    
    if (map.find(std::make_pair(x-1, y-1)) != map.end() && map.find(std::make_pair(x-1, y-1))->second == true) {
        surroundingGrass++;
    }
    if (map.find(std::make_pair(x, y-1)) != map.end() && map.find(std::make_pair(x, y-1))->second == true) {
        surroundingGrass++;
    }
    if (map.find(std::make_pair(x+1, y-1)) != map.end() && map.find(std::make_pair(x+1, y-1))->second == true) {
        surroundingGrass++;
    }
    if (map.find(std::make_pair(x-1, y)) != map.end() && map.find(std::make_pair(x-1, y))->second == true) {
        surroundingGrass++;
    }
    if (map.find(std::make_pair(x+1, y)) != map.end() && map.find(std::make_pair(x+1, y))->second == true) {
        surroundingGrass++;
    }
    if (map.find(std::make_pair(x-1, y+1)) != map.end() && map.find(std::make_pair(x-1, y+1))->second == true) {
        surroundingGrass++;
    }
    if (map.find(std::make_pair(x, y+1)) != map.end() && map.find(std::make_pair(x, y+1))->second == true) {
        surroundingGrass++;
    }
    if (map.find(std::make_pair(x+1, y+1)) != map.end() && map.find(std::make_pair(x+1, y+1))->second == true) {
        surroundingGrass++;
    }
    return surroundingGrass;
}

@end
