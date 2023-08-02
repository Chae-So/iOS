import RxSwift
import RxCocoa

class ReviewViewModel {
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    let writeReviewText = BehaviorRelay<String>(value: "")
    let viewPhotoReviewsText = BehaviorRelay<String>(value: "")
    let followText = BehaviorRelay<String>(value: "")
    
    
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
 
    }
    
    private func updateLocalization() {
        writeReviewText.accept(localizationManager.localizedString(forKey: "Write review"))
        viewPhotoReviewsText.accept(localizationManager.localizedString(forKey: "View photo reviews"))
        followText.accept(localizationManager.localizedString(forKey: "Follow"))
    }

}

