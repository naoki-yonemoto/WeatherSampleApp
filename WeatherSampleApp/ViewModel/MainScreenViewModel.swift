//
//  ContentViewViewModel.swift
//  WeatherSampleApp
//
//  Created by 米本直樹 on 2024/10/15.
//

import SwiftUI


class MainScreenViewModel : ObservableObject {
    
    //APIフェッチするためのクラス
    private let fetcher = ApiRequest()
    
    //KotlinでいうFlow的なやつ @Publishedで監視対象にする（Observableパターン）
    //TODO Nullableにするの嫌な感じ
    @Published var response : WeatherResponse? = nil
    
    //Loading用
    @Published var isLoading: Bool = false
    
    
    
    func featchApi() {
        guard response == nil else {
            return
        }
        
        isLoading = true
        Task {
            do {
                let result = try await fetcher.getWeatherInformation(cityCode: "130010")
                DispatchQueue.main.async {
                    self.response = result
                    self.isLoading = false
                }
            } catch {
                print("api Error")
            }
        }
    }
}
