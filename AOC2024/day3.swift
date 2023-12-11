//
//  day3.swift
//  AOC2024
//
//  Created by Dev on 12/10/23.
//

import Foundation

struct partNumberLocation{
    var number: Int
    var coordinate: [[Int:Int]]
    var used: Bool
    
}
struct symbolLocation{
    var sybol: String
    var coordinate: [Int:Int]
    
}

func day3a_func(engineSchematic: [String]) throws -> Int{
   
    var partNumberLocations: [partNumberLocation] = []
    var symbolLocations: [symbolLocation] = []
    
    for (idx,engineSchematicLine) in engineSchematic.enumerated(){
        var idy = 0
        while idy < engineSchematicLine.count {
            let tempIndex = engineSchematicLine.index(engineSchematicLine.startIndex, offsetBy: idy)
            let engineSchematicChar = engineSchematicLine[tempIndex]
            if !engineSchematicChar.isNumber && engineSchematicChar != "."{
                symbolLocations.append(symbolLocation(sybol: String(engineSchematicChar), coordinate: [idx : idy]))
            }
            if engineSchematicChar.isNumber{
                var newNumber = ""
                var loop = true
                var newPartNumberLocation = partNumberLocation(number: 0, coordinate: [], used: false)
                while loop == true{
                    if(idy >= engineSchematicLine.count ){
                        loop = false
                        newPartNumberLocation.number = Int(newNumber) ?? 0
                        partNumberLocations.append(newPartNumberLocation)
                    }
                    else{
                        let tempIndex = engineSchematicLine.index(engineSchematicLine.startIndex, offsetBy: idy)
                        let test = engineSchematicLine[tempIndex]
                        if test.isNumber
                        {
                            newNumber += String(test)
                            newPartNumberLocation.coordinate.append([idx : idy])
                            idy+=1
                        }
                        else{
                            //undo our lookahead, stop loop
                            loop = false
                            idy -= 1
                            newPartNumberLocation.number = Int(newNumber) ?? 0
                            partNumberLocations.append(newPartNumberLocation)
                        }
                    }
                        
                    
                    
                }
            }
            idy += 1
        }
    }
    
    return 0
}
func day3b_func(engineSchematic: [String]) throws -> Int{
    
    
    return 0
}
