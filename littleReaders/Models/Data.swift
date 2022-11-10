//
//  Data.swift
//  littleReaders
//
//  Created by mymac on 02/11/22.
//

import Foundation

var appData: AppData?

// MARK: - AppData
struct AppData: Codable {
    var levels: [Level]?
}

// MARK: - Level
struct Level: Codable {
    var flippable: Bool?
    var number: Int?
    var title, subtitle, color, colorPressed: String?
    var descriptions: [String]?
    var playButtonDrawable, playButtonPressedDrawable, flipButtonDrawable, flipButtonPressedDrawable: String?
    var cards: [Card]?

    enum CodingKeys: String, CodingKey {
        case flippable, number, title, subtitle, color
        case colorPressed = "color_pressed"
        case descriptions
        case playButtonDrawable = "play_button_drawable"
        case playButtonPressedDrawable = "play_button_pressed_drawable"
        case flipButtonDrawable = "flip_button_drawable"
        case flipButtonPressedDrawable = "flip_button_pressed_drawable"
        case cards
    }
}

extension Level{
    func detailDescription() -> String{
        return self.descriptions?.map{"\($0)\n"}.joined() ?? ""
    }
}


// MARK: - Card
struct Card: Codable {
    var frontDrawable: String?
    var backDrawable: String?
    var frontSound: String?
    var backSound: String?
    var name: String?
    var index: Int?
    
    enum CodingKeys: String, CodingKey {
        case frontDrawable = "front_drawable"
        case backDrawable = "back_drawable"
        case frontSound = "front_sound"
        case backSound = "back_sound"
        case name, index
    }
}
