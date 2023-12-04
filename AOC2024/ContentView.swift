//
//  ContentView.swift
//  AOC2024
//
//  Created by Dev on 11/25/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var Day1aResult = ""
    @State private var Day1bResult = ""

    var body: some View {
        NavigationSplitView {
            List {
                HStack {
                        Button(action: day1a) {
                            Label("Day 1a", systemImage: "pencil.and.outline")
                        }
                    Text(Day1aResult)
                    
                }
                HStack {
                        Button(action: day1b) {
                            Label("Day 1b", systemImage: "pencil.and.outline")
                        }
                    Text(Day1bResult)
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: callAPI) {
                        Label("call API", systemImage: "pencil.and.outline")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    private func callAPI() {
        Task{
            do {
                let movies = try await fetchFactsFromAPI(Url:"https://adventofcode.com/2023/day/1/input")
                print(movies)
            } catch {
                print(error)
            }
        }
    }
    
    private func day1a() {
        Task{
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
                Day1aResult = String(total)
                UIPasteboard.general.string =  Day1aResult
            } catch {
                print(error)
            }
        }
    }
    private func convertStringsNumsToNum(Char:String) -> String{
        var char = Char
        
        char = char.replacingOccurrences(of: "two", with: "2"  )
        char = char.replacingOccurrences(of: "three", with: "3")
        char = char.replacingOccurrences(of: "four", with: "4" )
        char = char.replacingOccurrences(of: "five", with: "5" )
        char = char.replacingOccurrences(of: "six", with: "6"  )
        char = char.replacingOccurrences(of: "seven", with: "7")
        //reordered to properly replace data
        char = char.replacingOccurrences(of: "nine", with: "9" )
        char = char.replacingOccurrences(of: "one", with: "1"  )
        char = char.replacingOccurrences(of: "eight", with: "8")
        return char
    }
    private func day1b() {
        Task{
            do {
                let calibrationDocuments = try await fetchFactsFromAPI(Url:"https://adventofcode.com/2023/day/1/input")
                var total=0
                for calibrationDocument in calibrationDocuments {
                    
                    let document = self.convertStringsNumsToNum(Char: calibrationDocument)
                    let characters = Array(document)
                    var numbers : [String] = []
                    

                    
                    for char in characters{
                        if(["1","2","3","4","5","6","7","8","9"].contains(char))
                        {
                            numbers.append(String(char))
                        }
                    }
                    if (!characters.isEmpty){
                        total += (Int(
                                (numbers.first!)
                                +
                                (numbers.last!)
                            ) ?? 0)
                    }
                    
                }
                print(total)
                Day1bResult = String(total)
                UIPasteboard.general.string =  Day1bResult
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
