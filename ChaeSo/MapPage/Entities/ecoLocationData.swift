import Foundation

struct Response: Decodable {
    let response: Body
}

struct Body: Decodable {
    let body: Items
}

struct Items: Decodable {
    let items: ItemList
}

struct ItemList: Decodable {
    let item: [Place]
}

struct Place: Decodable {
    let addr: String
    let mainimage: String
    let summary: String
    let tel: String
    let title: String
    let content: String
    let toilet: Bool
    let parking: Bool

    enum CodingKeys: String, CodingKey {
        case addr, mainimage, summary, tel, title
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        addr = try values.decode(String.self, forKey: .addr)
        mainimage = try values.decode(String.self, forKey: .mainimage)
        summary = try values.decode(String.self, forKey: .summary)
        tel = try values.decode(String.self, forKey: .tel)
        title = try values.decode(String.self, forKey: .title)

        content = String(summary.prefix { $0 != "*" })
            .replacingOccurrences(of: "<br /><br />", with: "")
            .replacingOccurrences(of: "\n\n\n", with: "")
            .replacingOccurrences(of: "\n\n", with: "")
            .replacingOccurrences(of: "<br />", with: "")
            .replacingOccurrences(of: "<br>", with: "")
        toilet = summary.contains("화장실 : 있음") ? true : false
        parking = summary.contains("주차시설 : 있음") ? true : false
    }
}

class PlaceInfo {
    static let shared = PlaceInfo()
    private init() {}

    var selectedPlace: Place?
}
