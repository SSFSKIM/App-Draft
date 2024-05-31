//
//  File.swift
//  App outline
//
//  Created by Steve on 5/6/24.
//

//
//  data.swift
//  SSFS trivia project
//
//  Created by Steve on 5/1/24.
//

import Foundation

struct Hitter: Codable {
    let playerName: String
    let teamName: String
    let season: Int
    let age: Int
    let AVG: Double
    let BBPercent: Double
    let KPercent: Double
    let OBP: Double
    let OPS: Double
    let SLG: Double
    let wRCPlus: Int
    let wOBA: Double
    let WAR: Double
    let Defense: Double
    let maxEV: Double
    let HardHitPercent: Double
    let BarrelPercent: Double
    let EV: Double
}

struct Pitcher: Codable {
    let season: Int
    let age: Int
    let playerName: String
    let teamName: String
    let W: Int
    let L: Int
    let ERA: Double
    let QS: Int
    let IP: Double
    let H: Int
    let R: Int
    let ER: Int
    let HR: Int
    let BB: Int
    let HBP: Int
    let SO: Int
    let K9: Double
    let BB9: Double
    let KBB: Double
    let H9: Double
    let AVG: Double
    let WHIP: Double
    let FIP: Double
    let WAR: Double
    let wFB: Double
    let wSL: Double
    let wCT: Double?
    let wCB: Double
    let wCH: Double
    let wSF: Double?
    let wKN: Double?
    let wFBC: Double
    let wSLC: Double
    let wCTC: Double?
    let wCBC: Double
    let wCHC: Double
    let wSFC: Double?
    let wKNC: Double?
    let Barrel: Double
    let HardHit: Double
    let EV: Double
    let pfxvFA: Double
}
