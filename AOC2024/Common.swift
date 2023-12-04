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
func fetchFactsFromAPI(Url: String) async throws -> [String] {
  // Setup the variable lotsOfFilms
  // Call the API with some code
//    let cookieHeader = " _ga=GA1.2.1058083798.1700925828; _ga_MHSNPJKWC7=GS1.2.1701636936.2.1.1701637925.0.0.0; _gid=GA1.2.1884966396.1701636936; session=53616c7465645f5fecf73e209469bcfea09b9b3a1c1cd756f631eff4b7c1b5e9fa7210d52a260dcdd6323b553d21a42ac363f63e7f60d8e80882f0f0e95eb51f"
    let cookieHeader = ProcessInfo.processInfo.environment["adventCookieHeader"]
    
    
    let url = URL(string: Url)!
    var urlrequest = URLRequest(url:url)
    urlrequest.addValue(cookieHeader ?? "", forHTTPHeaderField: "Cookie")
    urlrequest.httpMethod = "GET"
    urlrequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

    print(url)
    let (data, _a) = try await URLSession.shared.data( for: urlrequest)
    let dataParsed =  String(data: data, encoding: .utf8)?.lowercased()
    let splitData = dataParsed?.components(separatedBy: "\n") ?? []
    return splitData
}
