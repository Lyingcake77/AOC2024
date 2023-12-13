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
    var copies: Int = 1
    
    init(cardNumber: Int, winningNumbers: [Int], givenNumbers: [Int], winningCount:Int) {
        self.cardNumber = cardNumber
        self.winningNumbers = winningNumbers
        self.givenNumbers = givenNumbers
        self.winningCount = winningCount
    }
}
//copied somewhere from stack overflow
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
    let scratchCards: [scratchCard]=convertScratchCards(scratchCardsRaw: scratchCardsRaw)
    var total = 0
    for scratchCard in scratchCards{
        total += (scratchCard.winningCount == 0 ? 0:(2 ^^ (scratchCard.winningCount-1)))
    }
                  
    
    return total
}
//TODO: see if we can do an extention on the original method and apply this effect
func day4b_func(scratchCardsRaw: [String]) throws -> Int{
    let scratchCards: [scratchCard]=convertScratchCards(scratchCardsRaw: scratchCardsRaw)
    var total = 0
    //convoluded rules:
    //for first scartch card; there will always be 1 copy ever.
    //If a card has winning numbers, increase the copy count of the next X amount of cards
        //this effect applies for every copy of the card
    //no effect can hapen after the end of the list.
    
    let scratchCardsCount = scratchCards.count
    var i=0
    while i < scratchCardsCount{
        let winner = scratchCards[i].winningCount
        let copies = scratchCards[i].copies
        
        //once we get here, its safe that no more copies will be made so we add it to the count
        total += copies
        
        var currentCopy = 1
        //loop through ever time this effect is applied
        while currentCopy <= copies{
            
            //now we add 1 for the next {X} cards based on winning numbers
            var j = 1
            while j <= winner{
                //check to make sure we arent going past the available records
                if i+j < scratchCardsCount{
                    //increment the amount of copies
                    scratchCards[i+j].copies = scratchCards[i+j].copies + 1
                }
                j+=1
            }
            currentCopy+=1
        }
        i+=1
    }

    return total
}
