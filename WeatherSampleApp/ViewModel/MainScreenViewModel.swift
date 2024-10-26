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
    
    func initFeatchApi(){
        guard response == nil else {
            return
        }
        featchApi(cityCode: "130010") //東京
    }
    
    func featchApi(cityCode: String) {
        isLoading = true
        Task {
//            sleep(2) ローディングView確認用
            do {
                let result = try await fetcher.getWeatherInformation(cityCode: cityCode)
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
