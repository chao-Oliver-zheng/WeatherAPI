//
//  WeatherService.swift
//  WeatherAPI
//
//  Created by Oliver Zheng on 6/25/23.
//

import Foundation
import Combine
enum APIError: Error {
    case invalidUrl
    case invalidResponse
    case emptyData
    case serviceUnavailable
    case decodingError
    
    var description: String {
        switch self {
        case .invalidUrl:
            return "Invalid Url"
        case .invalidResponse:
            return "Invalid Response:"
        case .emptyData:
            return "Empty Data"
        case .serviceUnavailable:
            return "Service Unavailable"
        case .decodingError:
            return "Decoding Error"
        }
    }
}
class WeatherService {
    
    //var cancellables = Set<AnyCancellable>()
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
    let geoUrl = "https://api.openweathermap.org/geo/1.0/direct"
    let APIkey = "aa8286d642c6599544bb263397d8de9c"
    
    func fetchGeoUsingAsyncAwait(_ search: String) async throws -> [Location] {
        let encodedSearch = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let finalUrl = "\(geoUrl)?q=\(encodedSearch)&limit=1&appid=\(APIkey)"
        guard let url = URL(string: finalUrl) else {throw APIError.invalidUrl}
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let resp = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= resp else {
            throw APIError.invalidResponse
        }
       return  try JSONDecoder().decode([Location].self, from: data)
    }
    
    func fetchWeatherCoordUsingAsyncAwait(_ lat: Double, _ lon: Double) async throws -> Response {
        let finalUrl = "\(baseUrl)?lat=\(lat)&lon=\(lon)&appid=\(APIkey)"
        guard let url = URL(string: finalUrl) else {throw APIError.invalidUrl}
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let resp = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= resp else {
            throw APIError.invalidResponse
        }
       return  try JSONDecoder().decode(Response.self, from: data)
    }
    
    func fetchWeather(_ search: String) async throws -> Response {
        do{
            let respData: [Location] = try await self.fetchGeoUsingAsyncAwait(search)
            let weatherResponse: Response = try await self.fetchWeatherCoordUsingAsyncAwait(respData[0].lat, respData[0].lon)
            return weatherResponse
        } catch {
            
            throw APIError.serviceUnavailable
            }
    }

}
