import RxSwift
import RxCocoa

class VSTabViewModel {
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    let infoText = BehaviorRelay<String>(value: "")
    let menuText = BehaviorRelay<String>(value: "")
    let reviewText = BehaviorRelay<String>(value: "")
    
    // 일단은 예제를 위해 두 개의 탭 항목을 생성합니다.
    // 실제로는 여기에 서버나 데이터베이스에서 가져온 데이터를 바인딩할 수 있습니다.
    let tabItems = BehaviorRelay<[String]>(value: [])
    
    // 현재 선택된 탭을 나타내는 변수입니다. 기본값은 "장소"로 설정하겠습니다.
    let currentTab: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    
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
