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
        let allSources = sourceMaps.map{$0.sourceName}
        let allDestinations = sourceMaps.map{$0.destinationName}
        let missingDestinationOnlyDidderence = allDestinations.difference(from: allSources)
        let missingDestination = allDestinations.applying(missingDestinationOnlyDidderence) ?? []
        //or all destinations and misssing stuff
        return allSources+missingDestination
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

            if forwardDirection{
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
            }
            else{
                //this works just like forwards, but backwards
                if currentRule.destinationRangeStart <= source && (endOfRange ? endOfRange : source < sourceMap.sourceConversionRules[i+1].destinationRangeStart){
                    if currentRule.destinationRangeStart <= source && source < currentRule.destinationRangeStart + currentRule.rangeLength{
                        //double check this math, the one spot i didnt flush out, we want the conversion.
                        //TODO: handle going backwards
                        let diff = currentRule.rangeLength - source
                        let mappedSource = currentRule.sourceRangeStart + diff
                        
                        return sourceToDestination(sourceName: sourceMap.sourceName, source: mappedSource, sourceMap: firstMap, finalDestinationName: finalDestinationName, forwardDirection: forwardDirection)
                    }
                    return source
                }
            }

            
            
            i+=1
        }
        return source
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
func convertAlmanac(almanacRaw: [String]) -> ([Int], [sourceMap]){
    var newSourceMaps: [sourceMap]=[]
    var seeds:[Int]=[]

    
    //pain in using the while loop all the time
    var i = 0
    let almanacRawCount = almanacRaw.count
    while i < almanacRawCount{
        let almanacLineRaw = almanacRaw[i]
        //begining is the seed data, there might be a better way to do this? but i dont want to use regex or a contains.
        if i == 0{
            seeds = almanacLineRaw.split(separator: ":")[1].split(separator: " ").map{Int($0) ?? 0}
        }
        else if almanacLineRaw.isEmpty{
            //do nothing
        }
        else if almanacLineRaw.first!.isLetter{
            let sourceName = ""
            let destinationName = ""
            var rouceRules:[sourceConversionRule]=[]
            //increment by 1 to start getting the rules
            //we assume that there will be a new line if we just got a new map name
            i+=1
            while !almanacRaw[i].isEmpty{
                
                let rules = almanacRaw[i].split(separator: " ")
                
                rouceRules.append(sourceConversionRule(sourceRangeStart: Int(rules[1]) ?? 0, destinationRangeStart: Int(rules[0]) ?? 0, rangeLength: Int(rules[2]) ?? 0))
                
                i+=1
                
            }
            
            //create a map
            //loop through all numbers
            //exit loop
            newSourceMaps.append(sourceMap(sourceName: sourceName, destinationName: destinationName, sourceConversionRules: rouceRules))
        }
        i+=1
    }

    
    return (seeds, newSourceMaps)
}
func day5a_func(almanacRaw: [String]) throws -> Int{
    
    let (seeds, sourceMaps) = convertAlmanac(almanacRaw: almanacRaw)
    
    let newAlmanac = almanac(sourceMaps: sourceMaps)
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

func day5b_func(almanacRaw: [String]) throws -> Int{
    let (seeds, sourceMaps) = convertAlmanac(almanacRaw: almanacRaw)
    let total = 0
  
                  
    
    return total
}
