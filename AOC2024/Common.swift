//
//  Common.swift
//  AOC2024
//
//  Created by Dev on 11/25/23.
//

import Foundation

class dataLoader {
    typealias Handler = (Result<String, Error>) -> Void

    private let cache = Cache<String, [String]>()
    
    func loadData(Url: String) async throws ->[String]{
        let cachedData = cache.value(forKey: Url)
        if (cachedData == nil){
            cache.insert(try await self.fetchFactsFromAPI(Url:Url), forKey: Url)
            
//            try cache.saveToDisk(withName: "AOC24")
            return cache.value(forKey: Url) ?? []
        }
        return cachedData ?? []
        
    }
    func fetchFactsFromAPI(Url: String) async throws -> [String] {
        
        
        
      // Setup the variable lotsOfFilms
      // Call the API with some code
        let cookieHeader = ProcessInfo.processInfo.environment["adventCookieHeader"]
        
        let url = URL(string: Url)!
        var urlrequest = URLRequest(url:url)
        urlrequest.addValue(cookieHeader ?? "", forHTTPHeaderField: "Cookie")
        urlrequest.httpMethod = "GET"
        urlrequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        print(url)
        let (data, _) = try await URLSession.shared.data( for: urlrequest)
        let dataParsed =  String(data: data, encoding: .utf8)?.lowercased()
        let splitData = dataParsed?.components(separatedBy: "\n") ?? []
        
        
        return splitData
    }


}

