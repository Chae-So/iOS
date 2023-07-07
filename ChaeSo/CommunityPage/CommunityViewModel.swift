import Foundation
import RxSwift
import RxCocoa

class CommunityViewModel {
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    let model: CommunityModel
    
    // MARK: - Inputs
    
    let selectedPost = BehaviorRelay<Post?>(value: nil)
    
    // MARK: - Outputs
    
    let posts = BehaviorRelay<[Post]>(value: [])
    
    // MARK: - Initializers
    
    init(model: CommunityModel) {
        self.model = model
        
        // Reset the selected post when posts change
        posts.asObservable()
            .map { _ in nil }
            .bind(to: selectedPost)
            .disposed(by: disposeBag)
        
        // Fetch the posts from the model when initialized
        fetchPosts()
    }
    
    // MARK: - Methods
    
    func fetchPosts() {
        model.getPosts { [weak self] result in
            switch result {
            case .success(let posts):
                self?.posts.accept(posts)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
