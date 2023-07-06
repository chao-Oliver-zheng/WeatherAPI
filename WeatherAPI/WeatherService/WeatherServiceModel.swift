//
//  Test.swift
//  WeatherAPI
//
//  Created by Oliver Zheng on 7/1/23.
//

import Foundation

class WeatherServiceModel: ObservableObject {
    @Published var responses: [Response] = []
    var service = WeatherService()
    
    @MainActor func getAsycAwait(searchText: String) {
        
        
        Task{
             
            do {
                let response: Response = try await service.fetchWeather(searchText)
                self.responses = [response]
            } catch {
                if let error = error as? APIError {
                    print(error.description)
                } else {
                    print(error.localizedDescription)
                }
            }
            
        }
    }
}
