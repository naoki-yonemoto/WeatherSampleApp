//
//  WeatherResponse.swift
//  WeatherSampleApp
//
//  Created by 米本直樹 on 2024/10/11.
//


import Foundation

//メモ
// struct:構造体 Kotlinで言うData Classみたいなもの

// Codable: データ型に付けるプロトコル(Encodable + Decodableをあわせたもの）
// Serialazebleみたいなもの？若干違いそうだが


/**
 * Response OverView
 */
struct WeatherResponse : Codable {
    let publicTimeFormatted : String
    let title: String
    let description: WeatherDescription
    let forecasts: [WeatherForecasts]
    let location : WeatherLocation
    
}

/**
 予報概要
 */
struct WeatherDescription : Codable {
    let descriptionBodyText: String
    
    // memo:JsonのKey名とSwiftで扱う変数名を別にしたい
    // CodingKeys列挙型でJSONのキーと構造体のプロパティをマッピングする
    enum CodingKeys: String, CodingKey{
        case descriptionBodyText = "bodyText"
    }
}

/**
 予報内容
 */
struct WeatherForecasts: Codable {
    let id = UUID()
    let date : String
    let dateLabel: String
    let weatherLabel: String
    let forecastDetail: WeatherForecastDetail
    let temperature : WeatherTemperature
    let chanceOfRain: ChanceOfRain
    let iconImage: WeatherIconImage
    
    //同じものは代入は書かなくてもいいらしい
    enum CodingKeys: String, CodingKey{
        case date
        case dateLabel
        case weatherLabel = "telop"
        case forecastDetail = "detail"
        case temperature
        case chanceOfRain
        case iconImage = "image"
    }
}


/**
 予報の概要
 */
struct WeatherForecastDetail: Codable {
    let weather: String?
    let wind: String?
    let wave: String?
}

/**
 気温MAX-MIN
 */
struct WeatherTemperature : Codable {
    let min : TemperatureCelsius
    let max : TemperatureCelsius
}

/**
 気温（摂氏）
 */
struct TemperatureCelsius : Codable{
    let celsius : String?
}

/**
 降水確率
 */
struct ChanceOfRain: Codable {
    let lateNight : String
    let morning : String
    let afternoon : String
    let night : String
    
    enum CodingKeys: String, CodingKey{
        case lateNight = "T00_06"
        case morning = "T06_12"
        case afternoon = "T12_18"
        case night = "T18_24"
    }
}

/**
 天気アイコン
 */
struct WeatherIconImage: Codable {
    let title: String
    let url: String
    let width: Int
    let height: Int
}

/**
 地理情報
 */
struct WeatherLocation: Codable {
    let area: String
    let prefecture: String
    let district: String
    let city: String
}
