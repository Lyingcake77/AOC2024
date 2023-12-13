//
//  day5.swift
//  AOC2024
//
//  Created by Dev on 12/12/23.
//

import Foundation

class almanac{
    var sourceMaps: [sourceMap] = []
    
    init(sourceMaps: [sourceMap]) {
        self.sourceMaps = sourceMaps
    }
    
    func getAllMaps() -> [String]{
        //TODO: revisit, no internet existed in the making of this code
        let a = sourceMaps.map{$0.sourceName}
        let b = sourceMaps.map{$0.destinationName}
        let c = b.difference(from: a)
        let cc = b.applying(c) ?? []
        
        return b+cc
    }
    
    func convertSourceToDestination(source:Int, StartingMap:String, EndingMap:String, forwardDirection:Bool = true) -> Int{
        
        let firstMap = self.sourceMaps.filter{
            x in (forwardDirection ? x.sourceName == StartingMap : x.destinationName == StartingMap)
        }.first!
        
        return self.sourceToDestination(sourceName: StartingMap, source: source, sourceMap: firstMap, finalDestinationName: EndingMap, forwardDirection:forwardDirection)
    }
    
    private func sourceToDestination(sourceName:String, source: Int, sourceMap:sourceMap, finalDestinationName:String, forwardDirection:Bool) -> Int{
        //if source is destination, then we end the journey
        if sourceName == finalDestinationName{
            return source
        }
        //there should always be a next SA because we checked if we reached the destination
        let firstMap = self.sourceMaps.filter{
            x in (forwardDirection ? x.sourceName == sourceMap.destinationName : x.destinationName == sourceMap.sourceName)
        }.first!
        
        
        let ruleCount = sourceMap.sourceConversionRules.count
        var i = 0
        //loop through all the mappings
        while i < ruleCount{
            
            let currentRule = sourceMap.sourceConversionRules[i]
            //if end of range, then we dont bother checking the next item.
            let endOfRange = i+1 < ruleCount

            if currentRule.sourceRangeStart <= source && (endOfRange ? endOfRange : source < sourceMap.sourceConversionRules[i+1].sourceRangeStart){
                if currentRule.sourceRangeStart <= source && source < currentRule.sourceRangeStart + currentRule.rangeLength{
                    //double check this math, the one spot i didnt flush out, we want the conversion.
                    //TODO: handle going backwards
                    let diff = currentRule.rangeLength - source
                    let mappedSource = currentRule.destinationRangeStart + diff
                    return sourceToDestination(sourceName: sourceMap.destinationName, source: mappedSource, sourceMap: firstMap, finalDestinationName: finalDestinationName, forwardDirection: forwardDirection)
                }
                return source
            }
            return source
        }
    }
}
struct sourceMap{
    
    var sourceName:String
    var destinationName:String
    var sourceConversionRules:[sourceConversionRule]
    init(sourceName: String, destinationName: String, sourceConversionRules: [sourceConversionRule]) {
        self.sourceName = sourceName
        self.destinationName = destinationName
        self.sourceConversionRules = sourceConversionRules
    }

}
struct sourceConversionRule{
    var sourceRangeStart:Int
    var destinationRangeStart:Int
    var rangeLength :Int
    init(sourceRangeStart: Int, destinationRangeStart: Int, rangeLength: Int) {
        self.sourceRangeStart = sourceRangeStart
        self.destinationRangeStart = destinationRangeStart
        self.rangeLength = rangeLength
    }
}
//i feel this should be an extention in some way, its its own thing, but also related.
func convertAlmanac(seedAlmanacRaw: [String]) -> ([Int], [sourceMap]){
    var newSeedAlmanacs: [sourceMap]=[]
    var seeds:[Int]=[]

    
    return (seeds, newSeedAlmanacs)
}
func day5a_func(seedAlmanacRaw: [String]) throws -> Int{
    
    var (seeds, sourceMaps) = convertAlmanac(seedAlmanacRaw: seedAlmanacRaw)
    
    var newAlmanac = almanac(sourceMaps: sourceMaps)
    var total = 0
    //idk if swift has a begin, loop, finally kind of statement
    var firstCheck = true
    for seed in seeds{
        
        let location = newAlmanac.convertSourceToDestination(source: seed, StartingMap: "seed", EndingMap: "location")
        if firstCheck{
            firstCheck = false
            total = location
        }
        else{
            if location < total{
                total = location
            }
        }
    }

    return total
}

func day5b_func(seedAlmanacRaw: [String]) throws -> Int{
    var (seeds, sourceMaps) = convertAlmanac(seedAlmanacRaw: seedAlmanacRaw)
    var total = 0
  
                  
    
    return total
}
