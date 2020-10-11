//
//  ImageModel.swift
//  ImageViewer
//
//  Created by Veera on 11/10/20.
//

import Foundation

// MARK: ImageModel
struct ImageModel: Codable {
    let title: String
    let rows: [Row]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try (container.decodeIfPresent(String.self, forKey: .title) ?? "")
        self.rows = try container.decode([Row].self, forKey: .rows).filter{$0.title != nil || $0.rowDescription != nil || $0.imageHref != nil}
    }
}

// MARK: Row
struct Row: Codable {
    let title, rowDescription: String?
    let imageHref: String?

    enum CodingKeys: String, CodingKey {
        case title
        case rowDescription = "description"
        case imageHref
    }
}
