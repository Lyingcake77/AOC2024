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
    var newRaceStats: [raceStat]=convertSomething2(raceRecordsRaw: raceRecordsRaw)
    var total = 0
  
                  
    
    return total
}

func day6b_func(raceRecordsRaw: [String]) throws -> Int{
    var newRaceStats: [raceStat]=convertSomething2(raceRecordsRaw: raceRecordsRaw)
    var total = 0
  
    
    return total
}
