//
//  InfoModel.swift
//  ChaeSo
//
//  Created by 박중선 on 2023/08/18.
//

import RxDataSources

enum TableViewSection: SectionModelType {
    case sectionA(items: [ItemA])
    case sectionB(items: [ItemB])
    case sectionC(header: HeaderItem, items: [ItemC])

    var identity: Int {
        switch self {
        case .sectionA: return 0
        case .sectionB: return 1
        case .sectionC: return 2
        }
    }

    var items: [Any] {
        switch self {
        case .sectionA(let items): return items
        case .sectionB(let items): return items
        case .sectionC(_, let items): return items
        }
    }

    init(original: TableViewSection, items: [Any]) {
        switch original {
        case .sectionA: self = .sectionA(items: items as! [ItemA])
        case .sectionB: self = .sectionB(items: items as! [ItemB])
        case .sectionC(let header, _): self = .sectionC(header: header, items: items as! [ItemC])
        }
    }
}

struct ItemA {
    var first: Bool
    var second: Bool
    var third: Bool
}

struct ItemB {
    var image: UIImage
    var text: String
}

struct HeaderItem {
    var day: String
    var time: String
    var isExpanded: Bool
}

struct ItemC {
    var monTime: String
    var tueTime: String
    var wedTime: String
    var thuTime: String
    var friTime: String
    var satTime: String
    var sunTime: String
}
