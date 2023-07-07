import Foundation

struct User {
    let id: Int
    let name: String
    let email: String
    let profileImageName: String
}

class MyPageModel {
    
    // MARK: - Methods
    
    func getCurrentUser() -> User? {
        
        // Simulate getting the current user from a local storage or a server
        
        return User(id: 1, name: "김철수", email: "chulsoo@gmail.com", profileImageName: "chulsoo")
        
    }
}
