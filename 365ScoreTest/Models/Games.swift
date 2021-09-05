//
//  Championship.swift
//  365ScoreTest
//
//  Created by Nikita Koniukh on 03/09/2021.
//

import Foundation

enum GameListEnum {
    case Competition(Competition)
    case Game(Game)
}

struct Games: Codable {
    var games: [Game]
    var competitions: [Competition]
    
    enum CodingKeys: String, CodingKey {
        case games = "Games"
        case competitions = "Competitions"
    }
}

struct Game: Codable, Equatable {
    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.competitionId == rhs.competitionId
    }
    
    var id: Int
    var gameStatus: Int
    var dateTime: String
    var competitionId: Int
    var isActive: Bool
    var liveGameMinute: Int
    var competitorsArray: [Competitor]
    var gameScoreArray: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case gameStatus = "STID"
        case dateTime = "STime"
        case competitionId = "Comp"
        case isActive = "Active"
        case liveGameMinute = "GT"
        case competitorsArray = "Comps"
        case gameScoreArray = "Scrs"
    }
}

struct Competitor: Codable {
    var id: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
    }
}

struct Competition: Codable {
    var id: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
    }
}
