import Foundation
import RxSwift
import RxCocoa

class TabBarViewModel {
    
    // MARK: - Properties
    
    let model: TabBarModel
    
    // MARK: - Inputs
    
    let selectedIndex = BehaviorRelay<Int>(value: 0)
    
    // MARK: - Outputs
    
    let communityViewModel: CommunityViewModel
    let mapViewModel: MapViewModel
    let myPageViewModel: MyPageViewModel
    
    // MARK: - Initializers
    
    init(model: TabBarModel) {
        self.model = model
        
        // Create the view models for each tab
        communityViewModel = CommunityViewModel(model: model.communityModel)
        mapViewModel = MapViewModel(model: model.mapModel)
        myPageViewModel = MyPageViewModel(model: model.myPageModel)
    }
}
