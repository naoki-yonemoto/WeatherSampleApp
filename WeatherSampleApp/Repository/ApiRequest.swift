//
//  ApiRequest.swift
//  WeatherSampleApp
//
//  Created by 米本直樹 on 2024/10/11.
//

import Foundation

class ApiRequest {
    
    private let baseURL = "https://weather.tsukumijima.net/api/forecast"
    
    
    func getWeatherInformation(cityCode : String) async throws -> WeatherResponse {
        
        guard let url = URL(string: baseURL) else {
            throw NSError(domain: "URL error", code: -1)
        }
        
        //GETのQueryを付与する
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name:"city", value: cityCode)
        ]
        
        guard let requestUrl = components?.url else {
            throw NSError(domain: "URL error", code: -1)
        }
        
        //GETでコールする
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        guard let (data, result) =  try? await URLSession.shared.data(for: request) else {
            throw NSError(domain: "URLSession error", code: -1)

        }
        
        // ResponseをHTTPURLResponseにしてHTTPレスポンスヘッダを得る
        guard let httpStatus = result as? HTTPURLResponse else {
            throw NSError(domain: "HTTPURLResponse error", code: -1)
        }
        
        // BodyをStringに、失敗したらレスポンスコードを返す
        guard let response = String(data: data, encoding: .utf8) else {
            throw NSError(domain: "\(httpStatus.statusCode)", code: -1)
        }
        
        
        guard let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data) else {
            throw NSError(domain: response, code: -1)
        }
        
        
        return weatherResponse
    }
    

}
