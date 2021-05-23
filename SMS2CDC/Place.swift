//
//  Place.swift
//  SMS2CDC
//
//  Created by Andy.Lin on 2021/5/22.
//

import Foundation

struct PlaceInfo: Codable {
    var title: String
    var message: String
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static func saveToFile(place: [PlaceInfo]) {
        let propEncoder = PropertyListEncoder()
        if let data = try? propEncoder.encode(place) {
            let url = PlaceInfo.documentsDirectory.appendingPathComponent("MyPlaceInfo")
            try? data.write(to: url)
        }
    }
    
    static func readFromFile() -> [PlaceInfo]? {
        let propeDecoder = PropertyListDecoder()
        let url = PlaceInfo.documentsDirectory.appendingPathComponent("MyPlaceInfo")
        if let data = try? Data(contentsOf: url), let placeInfo = try?
            propeDecoder.decode([PlaceInfo].self, from: data) {
            return placeInfo
        } else {
            return nil
        }
    }
}
