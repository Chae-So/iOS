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
    
    init(model: TabBarModel, communityViewModel: CommunityViewModel, mapViewModel: MapViewModel, myPageViewModel: MyPageViewModel) {
        self.model = model
        self.communityViewModel = communityViewModel
        self.mapViewModel = mapViewModel
        self.myPageViewModel = myPageViewModel
    }
    
    
}
