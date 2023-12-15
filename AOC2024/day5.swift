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
        

         let firstMap = self.sourceMaps.filter{
                x in (forwardDirection ? x.sourceName == sourceMap.destinationName : x.destinationName == sourceMap.sourceName)
            }.first
        
        let ruleCount = sourceMap.sourceConversionRules.count
        var i = 0
        //loop through all the mappings
        while i < ruleCount{
            
            let currentRule = sourceMap.sourceConversionRules[i]
            //if end of range, then we dont bother checking the next item.
            let endOfRange = i+1 >= ruleCount

            if forwardDirection{
                if currentRule.sourceRangeStart <= source && (endOfRange ? endOfRange : source < sourceMap.sourceConversionRules[i+1].sourceRangeStart){
                    if currentRule.sourceRangeStart <= source && source < currentRule.sourceRangeStart + currentRule.rangeLength{
                        //double check this math, the one spot i didnt flush out, we want the conversion.
                        //TODO: handle going backwards
                        let diff = source - currentRule.sourceRangeStart
                        let mappedSource = currentRule.destinationRangeStart + diff
                        return sourceToDestination(sourceName: sourceMap.destinationName, source: mappedSource, sourceMap: firstMap ?? sourceMap, finalDestinationName: finalDestinationName, forwardDirection: forwardDirection)
                    }
                    return sourceToDestination(sourceName: sourceMap.destinationName, source: source, sourceMap: firstMap ?? sourceMap, finalDestinationName: finalDestinationName, forwardDirection: forwardDirection)
                }
            }
            else{
                if currentRule.destinationRangeStart <= source && (endOfRange ? endOfRange : source < sourceMap.sourceConversionRules[i+1].destinationRangeStart){
                    if currentRule.destinationRangeStart <= source && source < currentRule.destinationRangeStart + currentRule.rangeLength{
                        //double check this math, the one spot i didnt flush out, we want the conversion.
                        //TODO: handle going backwards
                        let diff = source - currentRule.destinationRangeStart
                        let mappedSource = currentRule.sourceRangeStart + diff
                        return sourceToDestination(sourceName: sourceMap.sourceName, source: mappedSource, sourceMap: firstMap ?? sourceMap, finalDestinationName: finalDestinationName, forwardDirection: forwardDirection)
                    }
                    return sourceToDestination(sourceName: sourceMap.sourceName, source: source, sourceMap: firstMap ?? sourceMap, finalDestinationName: finalDestinationName, forwardDirection: forwardDirection)
                }
            }
            
            
            i+=1
        }
        return sourceToDestination(sourceName: sourceMap.destinationName, source: source, sourceMap: firstMap ?? sourceMap, finalDestinationName: finalDestinationName, forwardDirection: forwardDirection)
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
func convertAlmanac(almanacRaw: [String], forward:Bool = true) -> ([Int], [sourceMap]){
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
            
            
            
            let names = String(almanacLineRaw.split(separator: " ")[0]).split(separator: "-to-")
            
            let sourceName: String = String(names[0])
            let destinationName: String = String(names[1])
            var rouceRules:[sourceConversionRule]=[]
            //increment by 1 to start getting the rules
            //we assume that there will be a new line if we just got a new map name
            i+=1
            while !almanacRaw[i].isEmpty{
                
                let rules = almanacRaw[i].split(separator: " ")
                
                rouceRules.append(sourceConversionRule(sourceRangeStart: Int(rules[1]) ?? 0, destinationRangeStart: Int(rules[0]) ?? 0, rangeLength: Int(rules[2]) ?? 0))
                
                i+=1
                
            }
            //order the rules...
            rouceRules = rouceRules.sorted { forward ? $0.sourceRangeStart < $1.sourceRangeStart : $0.destinationRangeStart < $1.destinationRangeStart }
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
    let (seeds, sourceMaps) = convertAlmanac(almanacRaw: almanacRaw, forward:false)
    
    let newAlmanac = almanac(sourceMaps: sourceMaps)
    
    var allSeedRanges: [ClosedRange<Int>] = []
    
    var j = 1
    
    var temp = 0
    for i in seeds{
        if j%2 == 0{
            let f = (temp...(temp+i))
            allSeedRanges.append(f)
        }
        else{
            temp = i
        }
        j+=1
    }
    
    var total = 0
    
    let id = "1234"
    let dispatchGroup = DispatchGroup()


    var returnedItems:[Int] = []
    
    func bruteForceLocationFinder(rangeStart:Int, RangeEnd:Int, al:almanac, allSeedRange:[ClosedRange<Int>]) {
        for location in rangeStart...RangeEnd{
            let seed = al.convertSourceToDestination(source: location, StartingMap: "location", EndingMap: "seed", forwardDirection: false)
            var asd = 1
            for i in allSeedRange{
                if i.lowerBound <= seed && seed <= i.upperBound{
                    returnedItems.append(location)
                    print("+1")
                    dispatchGroup.leave()
                }
            }
        }
        returnedItems.append(-1)
        print("-1")
        dispatchGroup.leave()
    }

    
    for i in 0...6{
        dispatchGroup.enter()
        bruteForceLocationFinder(rangeStart: i*10000000, RangeEnd: (i+1)*10000000, al: newAlmanac, allSeedRange: allSeedRanges)

    }
    
        dispatchGroup.enter()
        bruteForceLocationFinder(rangeStart: 70000000, RangeEnd: 70000010, al: newAlmanac, allSeedRange: allSeedRanges)
    
    // this will get called when all the tasks gets completed
    dispatchGroup.notify(queue: .main) {
        
        var q = returnedItems.sorted {$0 < $1}
        for f in q{
            print(f)
        }
        total = q[0]
        print("Execution completed")
    }
    
    return total
//
//    for location in 0...1000000000{
//        let seed = newAlmanac.convertSourceToDestination(source: location, StartingMap: "location", EndingMap: "seed", forwardDirection: false)
//        var asd = 1
//        for i in allSeedRanges{
//            if i.lowerBound <= seed && seed <= i.upperBound{
//                return location
//            }
//        }
//    }
    //pain
}

