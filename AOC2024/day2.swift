//
//  day2.swift
//  AOC2024
//
//  Created by Dev on 12/10/23.
//

import Foundation

struct ElfGames {
    var Games: [ElfGame]
}
struct ElfGame {
    var Game: Int
    var reveals: [reveal]
}

struct reveal{
    var cubes:[cube]
}
struct cube {
    var color:String
    var Count: Int

}

func day2a_func(elfGames: [String]) throws -> Int{
    var newElfGames =  ElfGames(Games: [])
    for elfGame in elfGames {

        if !elfGame.isEmpty {
            let games = String(elfGame).split(separator: ":")
            let game = games[0]
            var newElfGame = ElfGame(Game: Int(game.split(separator: " ")[1]) ?? 0, reveals: [])
            
                
            let reveals = games[1].split(separator: ";")
            for rev in reveals{
                var newReveals = reveal(cubes: [])
                var cubes = rev.split(separator: ",")
                for cub in cubes{
                    var c = cub.split(separator: " ")
                    var newCube = cube(color: String(c[1]), Count: Int(c[0]) ?? 0)
                    newReveals.cubes.append(newCube)
                }
                newElfGame.reveals.append(newReveals)
            }
            newElfGames.Games.append(newElfGame)
        }
    }
    let rule1 = cube(color: "red", Count: 12)
    let rule2 = cube(color: "green", Count: 13)
    let rule3 = cube(color: "blue", Count: 14)
    
    let a = newElfGames.Games.lazy
        .filter { c in c.Game < 10 }
    let b = newElfGames.Games.lazy
        .filter {
            x in x.reveals.filter{
                y in y.cubes.filter{
                    z in !((z.color==rule1.color && z.Count > rule1.Count) ||
                        (z.color==rule2.color && z.Count > rule2.Count) ||
                        (z.color==rule3.color && z.Count > rule3.Count))
                }.count == y.cubes.count
            }.count == x.reveals.count
        }
    var total = 0
    for x in b{
        total += x.Game
    }
    return total
}
func day2b_func(elfGames: [String]) throws -> Int{
    return 0
}
