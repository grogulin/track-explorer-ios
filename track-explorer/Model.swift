//
//  Model.swift
//  track-explorer
//
//  Created by Ярослав Грогуль on 03.12.2022.
//

import Foundation


struct Tracks: Decodable {
    var circuitId: Int? = nil
    var name: String? = nil
    var location: String? = nil
    var country: String? = nil
//    let lat: String?
//    let lng: String?
    var alt: String? = nil
    var url: String? = nil
    var circuitRef: String? = nil
}

//
//struct WikiGetImageLinkAPI: Decodable {
//    var batchcomplete: String? = nil
//    var normalized: [Normalized]
//    var redirects: [Redirects]
//
//        "pages": {
//            "10945": {
//                "pageid": 10945,
//                "ns": 0,
//                "title": "Albert Park Circuit",
//                "thumbnail": {
//                    "source": "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Albert_Park_Circuit_2021.svg/500px-Albert_Park_Circuit_2021.svg.png",
//                    "width": 500,
//                    "height": 345
//                },
//                "pageimage": "Albert_Park_Circuit_2021.svg"
//            }
//        }
//    }
//}
//
//struct Normalized: Decodable {
//    var from: String? = nil
//    var to: String? = nil
//}
//
//struct Redirects: Decodable {
//    var from: String? = nil
//    var to: String? = nil
//}
