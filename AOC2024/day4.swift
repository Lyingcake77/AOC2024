//
//  day4.swift
//  AOC2024
//
//  Created by Dev on 12/11/23.
//

import Foundation
class scratchCard{
    var cardNumber: Int = 0
    //Numberorder
    var winningNumbers: [Int]
    //Number; Order
    var givenNumbers: [Int]
    var winningCount: Int = 0
    
    init(cardNumber: Int, winningNumbers: [Int], givenNumbers: [Int], winningCount:Int) {
        self.cardNumber = cardNumber
        self.winningNumbers = winningNumbers
        self.givenNumbers = givenNumbers
        self.winningCount = winningCount
    }
}
precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^^ : PowerPrecedence
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

func convertScratchCards(scratchCardsRaw: [String]) -> [scratchCard]{
    var scratchCards: [scratchCard]=[]
    for scratchCardRaw  in scratchCardsRaw{
        if !scratchCardRaw.isEmpty{
         
            let split1 = String(scratchCardRaw).split(separator: ":")
            let split2 = split1[1].split(separator: "|")
            
            let firstNumberRegex = Regex(/\d+/)
            
            let gameNumReg = split1[0].firstMatch(of: firstNumberRegex)
            var gameNum:Int = 0
            if(gameNumReg != nil){
                gameNum = Int(String(gameNumReg?.output[0].substring ?? "")) ?? 0
            }
            
            let winningNums = (split2[0].split(separator: " ")).map { Int($0) ?? 0 }
            
            let givenNums = (split2[1].split(separator: " ")).map { Int($0) ?? 0 }
            let countOfData = givenNums.filter{x in winningNums.contains(x)}.count
            
            let scratchCard = scratchCard(cardNumber: gameNum, winningNumbers: winningNums, givenNumbers: givenNums, winningCount: countOfData)
            scratchCards.append(scratchCard)
        }
    }
    return scratchCards
}
func day4a_func(scratchCardsRaw: [String]) throws -> Int{
    var scratchCards: [scratchCard]=convertScratchCards(scratchCardsRaw: scratchCardsRaw)
    var total = 0
    for scratchCard in scratchCards{
        total += (scratchCard.winningCount == 0 ? 0:(2 ^^ (scratchCard.winningCount-1)))
    }
                  
    
    return total
}
func day4b_func(scratchCardsRaw: [String]) throws -> Int{
  
    var total = 0
   
    return total
}
