//
//  ContentView.swift
//  WeatherSampleApp
//
//  Created by 米本直樹 on 2024/10/11.
//

import SwiftUI

//
//  MainScreen.swift
//  ExampleWeatherApp
//
//  Created by 米本直樹 on 2024/10/08.
//

import SwiftUI


struct MainScreen: View {
    @StateObject private var vm = MainScreenViewModel()
    
    var body: some View {
        @State var loading = !vm.isLoading

        if loading {
            ScrollView(content: {
                //AndroidのLinerLayoutのようなもの(ComposeならColumn）
                VStack(content: {
                    //TextView(自動改行つき）
                    Text(vm.response?.publicTimeFormatted ?? "予報発表日時")
                    //Compose modifierみたいに設定する
                        .padding(.top, 8)
                        .font(.system(size: 24))
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                               alignment: .leading)
                    
                    Text(vm.response?.title ?? "予報地点の場所")
                        .padding(.top, 8)
                        .font(.system(size: 16))
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                               alignment: .leading)
                    
                    Text(vm.response?.description.descriptionBodyText ?? "予報概要")
                        .padding(.top, 8)
                        .font(.system(size: 16))
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                               alignment: .leading)
                    
                    
                    let items = vm.response?.forecasts ?? []
                    //ForEachはSwiftUIで使うforEach(普通にSwiftのものとは違う専用のもの）
                    //Identifiableに準拠させてidとなるものを付与しないといけないらしい（idはレイアウトの個別判定に利用される）
                    ForEach(items, id: \.self.id){ item in
                        createListItems(for: item)
                    }
                })
                .padding(.horizontal, 16)
                
                
            })
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .top
            )
            .background(Color.white)
            .onAppear{
                vm.featchApi()
            }

        } else {
            ZStack {
                ProgressView("Loading...")
                    .progressViewStyle(.circular)
                    .scaleEffect(1.5) // サイズを拡大（オプション）
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity)
            }
        }
        
    }
}

//メソッドを分ける
func createListItems(for item : WeatherForecasts) -> some View {
    VStack(content: {
        //気温
        let minTemp = String(format: "最低気温%@℃", item.temperature.min.celsius ?? "--")
        let maxTemp = String(format: "最高気温%@℃", item.temperature.max.celsius ?? "--")
        
        //ボーダーView
        Rectangle()
            .frame(height: 1)
            .foregroundColor(.black)
            .padding(.top, 4)
        
        //TODO ここに画像を置く（SVG
        //今日・明日・明後日
        let dateLabel = String(format: "%@の天気", item.dateLabel)
        Text(dateLabel)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                   alignment: .leading)
            .font(.system(size: 16, weight: .bold, design: .default)) //サイズとスタイルを指定
            .padding(.top, 8)
            .padding(.bottom, 8)
        
        Text(item.weatherLabel)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                   alignment: .leading)
            .font(.system(size: 20, weight: .bold, design: .default))
            .foregroundColor(.orange)
        
        HStack(content: {
            Text(minTemp)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                       alignment: .leading)
                .foregroundColor(.blue)
            Text(maxTemp)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                       alignment: .leading)
                .foregroundColor(.red)
            
        })
        
        createChanceOfRainView(chanceOfRain : item.chanceOfRain)
        
        
    })
    
}

func createChanceOfRainView(chanceOfRain : ChanceOfRain) -> some View {
    
    VStack(content: {
        //TODO ForListでうまいことやりたい
        HStack(content: {
            VStack(content: {
                Text("深夜〜朝(0時〜6時)")
                Text(chanceOfRain.lateNight)
            })
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                   alignment: .center)
            
            VStack(content: {
                Text("朝〜昼(6時〜12時)")
                Text(chanceOfRain.morning)
            })
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                   alignment: .center)
            
        })
        
        HStack(content: {
            VStack(content: {
                Text("昼〜夕方(12時〜18時)")
                Text(chanceOfRain.afternoon)
            })
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                   alignment: .center)
            
            VStack(content: {
                Text("夕方〜夜(18時〜24時)")
                Text(chanceOfRain.night)
            })
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                   alignment: .center)
        })
        
    })
    
    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
           alignment: .center)
    .padding(.top, 8)
}




#Preview {
    MainScreen()
}
