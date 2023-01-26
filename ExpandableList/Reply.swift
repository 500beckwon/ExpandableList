//
//  Reply.swift
//  ExpandableList
//
//  Created by ByungHoon Ann on 2023/01/26.
//

import Foundation

struct Reply: Codable, Hashable {
    var content: String
    var postKey: String
    var writer: String
    var replyTime: String
    var reReply: [ReReply]
}
