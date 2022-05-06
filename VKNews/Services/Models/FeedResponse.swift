//
//  FeedResponse.swift
//  VKNews
//
//  Created by lion on 5.05.22.
//

import Foundation

protocol ProfileRepresenable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}

struct FeedResponseWrapped: Codable {
    let response: FeedResponse
}

struct FeedResponse: Codable {
    var items: [FeedItem]
    var profiles: [Profile]
    var groups: [Group]
}

struct FeedItem: Codable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
    let attachments: [Attechment]?
}

struct CountableItem: Codable {
    let count: Int
}

struct Attechment: Codable {
    let photo: Photo?
}

struct Photo: Codable {
    let sizes: [PhotoSize]
    var height: Int {
        return getPropperSize().height
    }
    var width: Int {
        return getPropperSize().width
    }
    
    var srcBIG: String {
        return getPropperSize().url
    }
    
    private func getPropperSize() -> PhotoSize {
        if let sizeX = sizes.first(where: { $0.type == "x"}) {
            return sizeX
        } else if let fallBackSize = sizes.last {
            return fallBackSize
        } else {
            return PhotoSize(type: "wrong image", url: "wrong url", width: 0, height: 0)
        }
    }
}

struct PhotoSize: Codable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}

struct Profile: Codable, ProfileRepresenable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    var name: String { return firstName + " " + lastName }
    var photo: String { return photo100 }
    
}
struct Group: Codable, ProfileRepresenable {
    let id: Int
    let name: String
    let photo100: String
    var photo: String { return photo100 }
}
