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
    @Published var data : WeatherResponse? = nil

    //Loading用
    @Published var isLoading: Bool = false
    
    
    func featchApi() async {
        isLoading = true
        do {
            data = try await fetcher.getWeatherInformation(cityCode: "130010")
        } catch {
            print("api Error")
        }
        
        isLoading = false
    }
}
