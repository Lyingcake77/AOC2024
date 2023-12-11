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

func parseStringIntoModel(elfGames: [String]) -> ElfGames{
    var newElfGames =  ElfGames(Games: [])
    for elfGame in elfGames {

        if !elfGame.isEmpty {
            let games = String(elfGame).split(separator: ":")
            let game = games[0]
            var newElfGame = ElfGame(Game: Int(game.split(separator: " ")[1]) ?? 0, reveals: [])
            
                
            let reveals = games[1].split(separator: ";")
            for rev in reveals{
                var newReveals = reveal(cubes: [])
                let cubes = rev.split(separator: ",")
                for cub in cubes{
                    let cubeRaw = cub.split(separator: " ")
                    let newCube = cube(color: String(cubeRaw[1]), Count: Int(cubeRaw[0]) ?? 0)
                    newReveals.cubes.append(newCube)
                }
                newElfGame.reveals.append(newReveals)
            }
            newElfGames.Games.append(newElfGame)
        }
    }
    return newElfGames
}
func day2a_func(elfGames: [String]) throws -> Int{
    let newElfGames =  parseStringIntoModel(elfGames: elfGames)
    
    let rule1 = cube(color: "red", Count: 12)
    let rule2 = cube(color: "green", Count: 13)
    let rule3 = cube(color: "blue", Count: 14)
    
    //https://stackoverflow.com/questions/29655304/is-something-in-swift-like-linq-in-c-sharp
    let gamesThatMatchRules = newElfGames.Games.lazy
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
    for game in gamesThatMatchRules{
        total += game.Game
    }
    return total
}
func day2b_func(elfGames: [String]) throws -> Int{
    
    let newElfGames =  parseStringIntoModel(elfGames: elfGames)
    
    var total = 0
    for newElfGame in newElfGames.Games{
        
        var colors: [String:Int] = [:]
        for newReveals in newElfGame.reveals{
            
            for cub in newReveals.cubes{
                let dicColor = colors[cub.color]
                if dicColor == nil{
                    colors[cub.color] = cub.Count
                }
                else{
                    if dicColor! < cub.Count{
                        colors[cub.color] = cub.Count
                    }
                }
            }
            
        }
        if colors.count > 0{
            var power = 1
            for color in colors{
                power *= color.value
            }
            total += power
        }
    }
    
    return total
}
