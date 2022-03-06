//
//  WeatherData.swift
//  Clima
//
//  Created by João Alexandre on 08/11/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

// encode: model -> json
// decode: json -> model

// struct -> value type
// class -> reference type: faz referencia a um unico endereço de memoria

import Foundation

protocol WeatherProtocol {
    var name: String { get set }
    var main: Main { get set }
    var weather: [Weather] { get set }
}

struct WeatherData: Encodable, Decodable, WeatherProtocol {
    var name: String
    var main: Main
    var weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case name, main, weather
    }
    
//    MARK: - Construtores
    init(name: String, main: Main, weather: [Weather]) {
        self.weather = weather
        self.name = name
        self.main = main
    }
    
//    MARK: - Protocol Codable: Encode e decode do objeto
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        main = try container.decode(Main.self, forKey: .main)
        weather = try container.decode([Weather].self, forKey: .weather)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(main, forKey: .main)
        try container.encode(weather, forKey: .weather)

        print(container)
    }
}

struct Main: Codable {
    let temp: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
    }
}

struct Weather: Codable {
    let description: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case description, id
    }
}
