import RxSwift
import RxCocoa

class VSTabViewModel {
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    let infoText = BehaviorRelay<String>(value: "")
    let menuText = BehaviorRelay<String>(value: "")
    let reviewText = BehaviorRelay<String>(value: "")
    

    let tabItems = BehaviorRelay<[String]>(value: [])

    let selectedIndexPath = BehaviorRelay<IndexPath?>(value: nil)
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
        
        Observable.combineLatest(infoText, menuText,reviewText)
            .subscribe(onNext: { [weak self] info, menu, reivew in
                self?.tabItems.accept([info, menu, reivew])
            })
            .disposed(by: disposeBag)
    }
    
    private func updateLocalization() {
        infoText.accept(localizationManager.localizedString(forKey: "Info"))
        menuText.accept(localizationManager.localizedString(forKey: "Menu"))
        reviewText.accept(localizationManager.localizedString(forKey: "Review"))
    }

}
