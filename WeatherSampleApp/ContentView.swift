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


struct ContentView: View {
        
    let items = ["今日の天気", "明日の天気", "明後日の天気"]
    
    var body: some View {
        
        ScrollView(content: {
            //AndroidのLinerLayoutのようなもの(ComposeならColumn）
            VStack(content: {
                //TextView(自動改行つき）
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                //Compose modifierみたいに設定する
                    .padding(.top, 8)
                    .font(.system(size: 24))
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                           alignment: .leading)
                
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .padding(.top, 8)
                    .font(.system(size: 16))
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                           alignment: .leading)
                
                Text("Hello, World!")
                    .padding(.top, 8)
                    .font(.system(size: 16))
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                           alignment: .leading)
                
                
                ForEach(items, id: \.self){ item in
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

    }
}

//メソッドを分ける
func createListItems(for item : String) -> some View {
    VStack(content: {
        let minTemp = String(format: "最低気温%s℃", item)
        let maxTemp = String(format: "最高気温%s℃", item)
        
        //ボーダーView
        Rectangle()
            .frame(height: 1)
            .foregroundColor(.black)
            .padding(.top, 4)
        
        Text(item)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                   alignment: .leading)
            .font(.system(size: 16, weight: .bold, design: .default)) //サイズとスタイルを指定
            .padding(.top, 8)
        
        Text("晴れのち曇り")
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
        
        createChanceOfRainView()
        
        
    })
    
}

func createChanceOfRainView() -> some View {
    
    VStack(content: {
        //TODO ForListでうまいことやりたい

        HStack(content: {
            VStack(content: {
                Text("深夜〜朝(0時〜6時)")
                Text("--%")
            })
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                   alignment: .center)
            
            VStack(content: {
                Text("朝〜昼(6時〜12時)")
                Text("--%")
            })
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                   alignment: .center)
            
        })
        
        HStack(content: {
            VStack(content: {
                Text("昼〜夕方(12時〜18時)")
                Text("--%")
            })
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                   alignment: .center)
            
            VStack(content: {
                Text("夕方〜夜(18時〜24時)")
                Text("--%")
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
    ContentView()
}
