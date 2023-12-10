//
//  day1.swift
//  AOC2024
//
//  Created by Dev on 12/3/23.
//

import Foundation

func day1a_func() async throws -> Int{
    do {
        let calibrationDocuments = try await fetchFactsFromAPI(Url:"https://adventofcode.com/2023/day/1/input")
        var total=0
        for calibrationDocument in calibrationDocuments {
            let characters = Array(calibrationDocument)
            var numbers : [String] = []
            for char in characters{
                if (["1","2","3","4","5","6","7","8","9"].contains(char))
                {
                    numbers.append(String(char))
                }
            }
            total += Int(
                    (numbers.first ?? "" )
                    +
                    (numbers.last ?? "")
                ) ?? 0
        }
        
        print(total)
        return total
    } catch {
        print(error)
        return 0
    }
    
}

func day1b_func() async throws -> Int{
    do {
        let calibrationDocuments = try await fetchFactsFromAPI(Url:"https://adventofcode.com/2023/day/1/input")
        
        var total = 0
        let r = "1|2|3|4|5|6|7|8|9|one|two|three|four|five|six|seven|eight|nine"
        let simpleDigits = try Regex(r)
        let simpleDigitsR = try Regex(String(r.reversed()))
        let numberConversion = ["one": "1",
                                "two": "2",
                                "three": "3",
                                "four": "4",
                                "five": "5",
                                "six": "6",
                                "seven": "7",
                                "eight": "8",
                                "nine": "9",
                                "1": "1",
                                "2": "2",
                                "3": "3",
                                "4": "4",
                                "5": "5",
                                "6": "6",
                                "7": "7",
                                "8": "8",
                                "9": "9"]
        
        for calibrationDocument in calibrationDocuments {
            
            //get the first regex match
            var firstRaw = ""
            let firstMatch = calibrationDocument.firstMatch(of: simpleDigits)
            if(firstMatch != nil){
                firstRaw = String(firstMatch?.output[0].substring ?? "")
            }
                
            //we reverse the regex and reverse the string and get the first match
            var lastRaw = ""
            let lastMatch = String(calibrationDocument.reversed()).firstMatch(of: simpleDigitsR)
            if(lastMatch != nil){
                
                lastRaw = String((lastMatch?.output[0].substring ?? "").reversed())
            }
        
            if(firstRaw != "" && lastRaw != ""){
                //use the dictionary to conver the numbers words into numbers
                total = total + (Int(numberConversion[firstRaw]!+numberConversion[lastRaw]!) ?? 0)
            }
        }
        return total
    } catch {
        print(error)
        return 0
    }
}

