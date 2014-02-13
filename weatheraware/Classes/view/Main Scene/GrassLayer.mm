//
//  GrassLayer.m
//  weatheraware
//
//  Created by David Hodgkinson on 13/02/2014.
//  Copyright (c) 2014 David Hodgkinson. All rights reserved.
//

#import "GrassLayer.h"

#import "AssetHandler.h"

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
    
    CCSprite *grassSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"longgrass.png"]];
    
    //srand(354345678767);
    //DOGsrand(641623468973425);
    //srand(7983563024);
    /*MONKEY*/srand(784);
    //GIRAFFEEsrand(42);
    //RANDOMsrand((int)grassSprite);
    //srand(6.28);
    
    
    std::map<std::pair<int, int>, bool> grassMap;
    std::map<std::pair<int, int>, bool> tempMap;
    
    const float fillProb = 60;
    
    for (int i = 0 ; i < [self contentSize].width / [grassSprite contentSize].width ; i++){
        for (int j = 0 ; j < [self contentSize].height / [grassSprite contentSize].height ; j++){
            (rand()%100 < fillProb) ? grassMap.insert(std::make_pair(std::make_pair(i, j), true)) : grassMap.insert(std::make_pair(std::make_pair(i, j), false));
        }
    }
    
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
    
    for (std::map<std::pair<int, int>, bool>::iterator it = grassMap.begin() ; it != grassMap.end() ; it++) {
        if (it->second == true) {
            grassSprite = [[CCSprite alloc] initWithSpriteFrame:[[AssetHandler sharedAssetHandler] getTextureWithName:@"longgrass.png"]];
            [grassSprite setPosition:ccp([grassSprite contentSize].width/2 + ([grassSprite contentSize].width * it->first.first), [grassSprite contentSize].height/2 + ([grassSprite contentSize].height * it->first.second))];
            [self addChild:grassSprite];
            [_grassArray addObject:grassSprite];
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
