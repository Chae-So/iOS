import UIKit
import RxCocoa
import RxSwift

class SearchingViewModel{
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    // Input
    let searchingText = BehaviorRelay<String>(value: "")
    
    // Output
    let titleText = BehaviorRelay<String>(value: "")
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()

        
    }
    
    private func updateLocalization() {
        searchingText.accept(localizationManager.localizedString(forKey: "Looking for a good restaurant near you"))
    }
}

