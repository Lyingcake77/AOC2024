//
//  day3.swift
//  AOC2024
//
//  Created by Dev on 12/10/23.
//

import Foundation

class partNumberLocation{
    var number: Int = 0
    var coordinate: [(Int,Int)]
    var used: Bool = false
    init(number: Int, coordinate: [(Int, Int)], used: Bool) {
        self.number = number
        self.coordinate = coordinate
        self.used = used
    }
    
}
class symbolLocation{
    var sybol: String = ""
    var coordinate: (Int, Int)
    init(sybol: String, coordinate: (Int, Int)) {
        self.sybol = sybol
        self.coordinate = coordinate
    }
    
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
                symbolLocations.append(symbolLocation(sybol: String(engineSchematicChar), coordinate: (idx, idy)))
            }
            if engineSchematicChar.isNumber{
                var newNumber = ""
                var loop = true
                let newPartNumberLocation = partNumberLocation(number: 0, coordinate: [], used: false)
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
                            newPartNumberLocation.coordinate.append((idx, idy))
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
    
    var total = 0
    for sym in symbolLocations{
        let row = sym.coordinate.0
        let col = sym.coordinate.1
        
        let possibleNumbers = partNumberLocations.filter {
            x in x.used == false && x.coordinate.filter{
                //row column check
                y in
                (y.0 == row &&
                 (y.1 == col || y.1 == col+1 || y.1 == col-1)
                ) ||
                (y.0 == row-1  &&
                 (y.1 == col || y.1 == col+1 || y.1 == col-1)) ||
                (y.0 == row+1  &&
                 (y.1 == col || y.1 == col+1 || y.1 == col-1))
                
            }.count > 0
        }
        
        for partNumber in possibleNumbers{
            total += partNumber.number
            partNumber.used = true
        }
        
    }
    
    return total
}
func day3b_func(engineSchematic: [String]) throws -> Int{
    
    
    return 0
}
