//
//  HeaderItem.swift
//  ExpandableList
//
//  Created by ByungHoon Ann on 2023/01/26.
//

import UIKit

struct HeaderItem: Hashable {
    let title: String
    let symbols: [SFSymbolItem]
}

// Symbol cell data type
struct SFSymbolItem: Hashable {
    let name: String
    let image: UIImage
    
    init(name: String) {
        self.name = name
        self.image = UIImage(systemName: name)!
    }
}

// Item identifier type
enum ListItem: Hashable {
    case header(HeaderItem)
    case symbol(SFSymbolItem)
}

// The model objects to show
let modelObjects = [
    
    HeaderItem(title: "Communication", symbols: [
        SFSymbolItem(name: "mic"),
        SFSymbolItem(name: "mic.fill"),
        SFSymbolItem(name: "message"),
        SFSymbolItem(name: "message.fill"),
    ]),
    
    HeaderItem(title: "Weather", symbols: [
        SFSymbolItem(name: "sun.min"),
        SFSymbolItem(name: "sun.min.fill"),
        SFSymbolItem(name: "sunset"),
        SFSymbolItem(name: "sunset.fill"),
    ]),
    
    HeaderItem(title: "Objects & Tools", symbols: [
        SFSymbolItem(name: "pencil"),
        SFSymbolItem(name: "pencil.circle"),
        SFSymbolItem(name: "highlighter"),
        SFSymbolItem(name: "pencil.and.outline"),
    ]),
    
]

let dataItems = [
    SFSymbolItem(name: "mic"),
    SFSymbolItem(name: "mic.fill"),
    SFSymbolItem(name: "message"),
    SFSymbolItem(name: "message.fill"),
    SFSymbolItem(name: "sun.min"),
    SFSymbolItem(name: "sun.min.fill"),
    SFSymbolItem(name: "sunset"),
    SFSymbolItem(name: "sunset.fill"),
    SFSymbolItem(name: "pencil"),
    SFSymbolItem(name: "pencil.circle"),
    SFSymbolItem(name: "highlighter"),
    SFSymbolItem(name: "pencil.and.outline"),
    SFSymbolItem(name: "personalhotspot"),
    SFSymbolItem(name: "network"),
    SFSymbolItem(name: "icloud"),
    SFSymbolItem(name: "icloud.fill"),
    SFSymbolItem(name: "car"),
    SFSymbolItem(name: "car.fill"),
    SFSymbolItem(name: "bus"),
    SFSymbolItem(name: "bus.fill"),
    SFSymbolItem(name: "flame"),
    SFSymbolItem(name: "flame.fill"),
    SFSymbolItem(name: "bolt"),
    SFSymbolItem(name: "bolt.fill")
]
