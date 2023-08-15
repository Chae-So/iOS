import RxSwift
import RxCocoa

class ReviewViewModel {
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    let photoReviewTableViewModel = PhotoReviewTableViewModel()
//    let sortTableViewModel = SortTableViewModel(localizationManager: LocalizationManager.shared)
    
    let writeReviewText = BehaviorRelay<String>(value: "")
    let viewPhotoReviewsText = BehaviorRelay<String>(value: "")
    let followText = BehaviorRelay<String>(value: "")
    
    let cellData = Driver<[[Any]]>.just([
        ["a"],
        [[UIImage(named: "tomato"),UIImage(named: "tomato"),UIImage(named: "tomato"),UIImage(named: "tomato"),UIImage(named: "tomato"),UIImage(named: "tomato")]],
        ["b"]
    ])
    
    
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
 
        //photoReviewTableViewModel.images.accept([UIImage(named: "tomato")!, UIImage(named: "tomato")!,UIImage(named: "tomato")!,UIImage(named: "tomato")!,UIImage(named: "tomato")!,UIImage(named: "tomato")!])
        
    }
    
    private func updateLocalization() {
        writeReviewText.accept(localizationManager.localizedString(forKey: "Write review"))
        viewPhotoReviewsText.accept(localizationManager.localizedString(forKey: "View photo reviews"))
        followText.accept(localizationManager.localizedString(forKey: "Follow"))
    }

}

