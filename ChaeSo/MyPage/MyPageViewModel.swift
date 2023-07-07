import Foundation
import RxSwift
import RxCocoa

class MyPageViewModel {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    let model: MyPageModel
    
    // MARK: - Inputs
    
    let logoutTapped = PublishRelay<Void>()
    
    // MARK: - Outputs
    
    let user = BehaviorRelay<User?>(value: nil)
    
    // MARK: - Initializers
    
    init(model: MyPageModel) {
        self.model = model
        
        // Get the current user from the model when initialized
        user.accept(model.getCurrentUser())
    }
}
