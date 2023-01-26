//
//  ReReply.swift
//  ExpandableList
//
//  Created by ByungHoon Ann on 2023/01/26.
//

import Foundation

struct ReReply: Codable, Hashable {
    var replyKey: String
    var content: String
    var writer: String
    var reReplyTime: String
    var postKey: String
}
