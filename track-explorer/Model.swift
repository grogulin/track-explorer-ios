//
//  Model.swift
//  track-explorer
//
//  Created by Ярослав Грогуль on 03.12.2022.
//

import Foundation


struct Tracks: Decodable {
    let circuitId: Int
    let name: String
    let location: String
    let country: String
//    let lat: String?
//    let lng: String?
    let alt: String?
    let url: String
    let circuitRef: String
}
//
//struct Tracks: Decodable {
//    let userId: Int
//    let id: Int
//    let title: String
//    let completed: Bool
//}
