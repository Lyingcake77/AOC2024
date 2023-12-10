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
                let total = try await day1a_func(calibrationDocuments: try await cache.loadData(Url: "https://adventofcode.com/2023/day/1/input"))
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
                let total = try await day1b_func(calibrationDocuments: try await cache.loadData(Url: "https://adventofcode.com/2023/day/1/input"))
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
                let total = try await day2a_func(elfGames: try await cache.loadData(Url: "https://adventofcode.com/2023/day/2/input"))
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
                let total = try await day2b_func(elfGames: try await cache.loadData(Url: "https://adventofcode.com/2023/day/2/input"))
                Day2bResult = String(total)
                UIPasteboard.general.string =  Day2bResult
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
