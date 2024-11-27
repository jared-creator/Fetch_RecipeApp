//
//  Fetch_RecipeAppTests.swift
//  Fetch-RecipeAppTests
//
//  Created by JaredMurray on 11/26/24.
//

import Testing
import UIKit
@testable import Fetch_RecipeApp

class Fetch_RecipeAppTests {

    private var session: URLSession!
    private var url: URL!
    
    init() {
        url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: config)
    }
    
    deinit {
        session = nil
        url = nil
    }

    @Test func successfull_response() async throws {
        guard let path = Bundle.main.path(forResource: "MockData", ofType: "json"), let data = FileManager.default.contents(atPath: path) else {
            Issue.record()
            return
        }
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response!, data)
        }
        
        _ = try await RecipesFetcher.shared.fetchRecipes(session: session)                
    }
}
