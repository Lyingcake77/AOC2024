//
//  day7.swift
//  AOC2024
//
//  Created by Dev on 12/12/23.
//

import Foundation

//extension Array {
//    func insertionIndexOf(_ elem: Element, isOrderedBefore: (Element, Element) -> Bool) -> Int {
//        var lo = 0
//        var hi = self.count - 1
//        while lo <= hi {
//            let mid = (lo + hi)/2
//            if isOrderedBefore(self[mid], elem) {
//                lo = mid + 1
//            } else if isOrderedBefore(elem, self[mid]) {
//                hi = mid - 1
//            } else {
//                return mid // found at position mid
//            }
//        }
//        return lo // not found, would be inserted at position lo
//    }
//}



let handDict = [
        "1": 1,
        "2": 2,
        "3": 3,
        "4": 4,
        "5": 5,
        "6": 6,
        "7": 7,
        "8": 8,
        "9": 9,
        "T": 10,
        "J": 11,
        "Q": 12,
        "K": 13,
        "A": 14]


class CamelCardHand{
    var hand: String
    var handOrdered: [Int]
    var bid: Int
    
    var rank : Int
    
    init(hand: String, handOrdered: [Int], bid: Int, rank: Int) {
        self.hand = hand
        self.handOrdered = handOrdered
        self.bid = bid
        self.rank = rank
    }
    
    
}

func testShit(a:[Int],b:[Int])->Bool{
    
    return true
}
func CheckHandPower(handsRaw: [String]) -> [CamelCardHand]{
    var newCamelCardHands: [CamelCardHand]=[]
//    
//    for i in handsRaw{
//        let a = i.split(separator: " ")
//        let b = a[0].split(separator: "")
//        var handOrdered: [Int] = []
//        for c in b{
//            let newElement: Int = handDict[String(c)] ?? 0
//            let index = handOrdered.insertionIndexOf(newElement) { $0 > $1 } // Or: myArray.indexOf(c, <)
//            handOrdered.insert(newElement, at: index)
//            
//        }
//        let newCamelCard = CamelCardHand(hand: String(a[0]), handOrdered: handOrdered, bid: Int(String(a[1])) ?? 0, rank: 0)
//        let index = newCamelCardHands.insertionIndexOf(newCamelCard) { testShit(a: $0.handOrdered, b: $1.handOrdered) } // Or: myArray.indexOf(c, <)
//        newCamelCardHands.insert(newCamelCard, at: index)
        
        
//    }
    
    
    
    return newCamelCardHands
}
func day7a_func(handsRaw: [String]) throws -> Int{
    var newCamelCardHands: [CamelCardHand]=CheckHandPower(handsRaw: handsRaw)
    var total = 0
  
                  
    
    return total
}

func day7b_func(handsRaw: [String]) throws -> Int{
    var newCamelCardHands: [CamelCardHand]=CheckHandPower(handsRaw: handsRaw)
    var total = 0
  
                  
    
    return total
}
