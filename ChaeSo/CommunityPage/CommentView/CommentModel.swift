import Foundation

struct User {
    let profileImage: UIImage?
    let nickname: String
}

struct Comment {
    let user: User
    let content: String
    var replies: [Reply]
    var isExpanded: Bool = false
}

struct Reply {
    let user: User
    let content: String
}
