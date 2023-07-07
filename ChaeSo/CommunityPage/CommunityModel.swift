import Foundation

struct Post {
    let id: Int
    let title: String
}

class CommunityModel {
    
    // MARK: - Methods
    
    func getPosts(completionHandler: @escaping (Result<[Post], Error>) -> Void) {
        
        // Simulate a network request to get posts from a server
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            let posts = [
                Post(id: 1, title: "Hello, world!"),
                Post(id: 2, title: "This is a test post"),
                Post(id: 3, title: "RxSwift is awesome")
            ]
            
            completionHandler(.success(posts))
            
        }
        
    }
}
