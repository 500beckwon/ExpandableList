//
//  ReplyType.swift
//  ExpandableList
//
//  Created by ByungHoon Ann on 2023/01/26.
//

import Foundation

enum ReplyType: String, CodingKey {
    case storyReply
    case storyReReply
    case homeBookReply
    case homeBookReReply
    case guestBookReply
    case guestBookReReply
    case boardReply
    case boardReReply
}

extension ReplyType {
    var typeText: String {
        switch self {
        case .storyReply:
            return "WriteStoryReply"
        case .storyReReply:
            return "WriteStoryReReply"
        case .homeBookReply:
            return "WriteHomeBookReply"
        case .homeBookReReply:
            return "WriteHomeBookReReply"
        case .guestBookReply:
            return "WriteGuestBookReply"
        case .guestBookReReply:
            return "WriteGuestBookReReply"
        case .boardReply:
            return "WriteBoardReply"
        case .boardReReply:
            return "WriteBoardReReply"
        }
    }
}
