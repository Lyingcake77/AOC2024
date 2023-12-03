//
//  Common.swift
//  AOC2024
//
//  Created by Dev on 11/25/23.
//

import Foundation
struct FactResponse: Decodable {
    let results: [Fact]
}
struct Fact:Decodable {
    let _id: String
//    let _v: Int
    let user: String
    let text: String
//    let updatedAt: Date
//    let sendDate: Date
    let deleted: Bool
    let source: String
    let type: String
    let status: Status
}
struct Status: Decodable {
    let verified: Bool
//    let feedback: String
    let sentCount: Int
}
func fetchFactsFromAPI() async throws -> [Fact] {
  // Setup the variable lotsOfFilms
  // Call the API with some code
    let apikey = ""
    let url = URL(string: "https://cat-fact.herokuapp.com/facts")!
    print(url)
    let (data, _) = try await URLSession.shared.data(from: url)
    print(data)
  // Using data from the API, assign a value to lotsOfFilms
    let decoded = try JSONDecoder().decode([Fact].self, from:data)
  // Give the completion handler the variable, lotsOfFilms
    return decoded
}
//Task {
//    do {
//        let movies = try await fetchFactsFromAPI()
//
//        print(movies)
//    } catch {
//        print(error)
//    }
//}
