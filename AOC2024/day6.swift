//
//  day6.swift
//  AOC2024
//
//  Created by Dev on 12/12/23.
//

import Foundation

struct raceStat{
    var time:Int
    var distance:Int
}

func convertSomething2(raceRecordsRaw: [String]) -> [raceStat]{
    
    let times = raceRecordsRaw[0].split(separator: " ")
    let distances = raceRecordsRaw[1].split(separator: " ")
    let newRaceStats: [raceStat]=[
        raceStat(time: Int(times[1])!, distance: Int(distances[1])!),
        raceStat(time: Int(times[2])!, distance: Int(distances[2])!),
        raceStat(time: Int(times[3])!, distance: Int(distances[3])!),
        raceStat(time: Int(times[4])!, distance: Int(distances[4])!),
    ]
    return newRaceStats
}
func day6a_func(raceRecordsRaw: [String]) throws -> Int{
    let newRaceStats: [raceStat] = convertSomething2(raceRecordsRaw: raceRecordsRaw)
    
    var total = 1
    //theres a math answer here
    for race in newRaceStats{
        var possibleOptions = 0
        
        var raceDistance = race.distance
        var raceTime = race.time
        var raceTimeHalfWayPoihnt = raceTime/2
        
        for timeHeld in 0...raceTime{
            var maxDistance = timeHeld * (raceTime - timeHeld)
            if (maxDistance > raceDistance){
                possibleOptions+=1
//                if raceTime > raceTimeHalfWayPoihnt{
//                    possibleOptions = raceTime - timeHeld
//                }
//                else{
//                    possibleOptions = (raceTime - timeHeld) * 2
//                    
//                }
//                break
            }
        }
        print(possibleOptions)
        total *= possibleOptions
    }
    
    return total
}

func day6b_func(raceRecordsRaw: [String]) throws -> Int{
    var newRaceStats: [raceStat]=convertSomething2(raceRecordsRaw: raceRecordsRaw)
    var total = 0
  
    let newRaceStats: [raceStat] = convertSomething2(raceRecordsRaw: raceRecordsRaw)
    //formula: (15-x)*x>40
    
    
    var raceDistance = Int(String(newRaceStats[0].distance)+String(newRaceStats[1].distance)+String(newRaceStats[2].distance)+String(newRaceStats[3].distance))
    var raceTime = Int(String(newRaceStats[0].time)+String(newRaceStats[1].time)+String(newRaceStats[2].time)+String(newRaceStats[3].time))
    
    let b = raceTime
    let a = 1
    let c = -1*raceDistance
    var lowerX = ceil(((-1*b)-sqrt((b**2-4*a*c))) / 2*a) //int upper
    var upperX = floor(((-1*b)+sqrt((b**2-4*a*c))) / 2*a) //int lower
    
    total = upperX - lowerX
    
    
    
    return total
    
    
}
