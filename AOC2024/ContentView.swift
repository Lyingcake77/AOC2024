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
    @State private var Day2aResult = ""
    @State private var Day2bResult = ""
    @State private var Day3aResult = ""
    @State private var Day3bResult = ""
    @State private var Day4aResult = ""
    @State private var Day4bResult = ""
    private let cache = dataLoader()

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
                HStack {
                        Button(action: day2a) {
                            Label("Day 2a", systemImage: "pencil.and.outline")
                        }
                    Text(Day2aResult)
                    
                }
                HStack {
                        Button(action: day2b) {
                            Label("Day 2b", systemImage: "pencil.and.outline")
                        }
                    Text(Day2bResult)
                    
                }
                HStack {
                        Button(action: day3a) {
                            Label("Day 3a", systemImage: "pencil.and.outline")
                        }
                    Text(Day3aResult)
                    
                }
                HStack {
                        Button(action: day3b) {
                            Label("Day 3b", systemImage: "pencil.and.outline")
                        }
                    Text(Day3bResult)
                    
                }
                HStack {
                        Button(action: day4a) {
                            Label("Day 4a", systemImage: "pencil.and.outline")
                        }
                    Text(Day4aResult)
                    
                }
                HStack {
                        Button(action: day4b) {
                            Label("Day 4b", systemImage: "pencil.and.outline")
                        }
                    Text(Day4bResult)
                    
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
                let d = try await cache.loadData(Url: "https://adventofcode.com/2023/day/1/input")
                print(d)
            } catch {
                print(error)
            }
        }
    }
    
    private func day1a() {
        Task{
            do {
                let total = try day1a_func(calibrationDocuments: try await cache.loadData(Url: "https://adventofcode.com/2023/day/1/input"))
                Day1aResult = String(total)
                UIPasteboard.general.string =  Day1aResult
            } catch {
                print(error)
            }
        }
    }
    
    private func day1b() {
        Task{
            do {
                let total = try day1b_func(calibrationDocuments: try await cache.loadData(Url: "https://adventofcode.com/2023/day/1/input"))
                Day1bResult = String(total)
                UIPasteboard.general.string =  Day1bResult
            } catch {
                print(error)
            }
        }
    }
    private func day2a() {
        Task{
            do {
                let total = try day2a_func(elfGames: try await cache.loadData(Url: "https://adventofcode.com/2023/day/2/input"))
                Day2aResult = String(total)
                UIPasteboard.general.string =  Day2aResult
            } catch {
                print(error)
            }
        }
    }
    
    private func day2b() {
        Task{
            do {
                let total = try day2b_func(elfGames: try await cache.loadData(Url: "https://adventofcode.com/2023/day/2/input"))
                Day2bResult = String(total)
                UIPasteboard.general.string =  Day2bResult
            } catch {
                print(error)
            }
        }
    }
    private func day3a() {
        Task{
            do {
                let total = try day3a_func(engineSchematic: try await cache.loadData(Url: "https://adventofcode.com/2023/day/3/input"))
                Day3aResult = String(total)
                UIPasteboard.general.string =  Day3aResult
            } catch {
                print(error)
            }
        }
    }
    
    private func day3b() {
        Task{
            do {
                let total = try day3b_func(engineSchematic: try await cache.loadData(Url: "https://adventofcode.com/2023/day/3/input"))
                Day3bResult = String(total)
                UIPasteboard.general.string =  Day3bResult
            } catch {
                print(error)
            }
        }
    }
    private func day4a() {
        Task{
            do {
                let total = try day4a_func(scratchCardsRaw: try await cache.loadData(Url: "https://adventofcode.com/2023/day/4/input"))
                Day4aResult = String(total)
                UIPasteboard.general.string =  Day4aResult
            } catch {
                print(error)
            }
        }
    }
    
    private func day4b() {
        Task{
            do {
                let total = try day4b_func(scratchCardsRaw: try await cache.loadData(Url: "https://adventofcode.com/2023/day/4/input"))
                Day4bResult = String(total)
                UIPasteboard.general.string =  Day4bResult
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
