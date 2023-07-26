import RxSwift
import RxCocoa

class BookmarkViewModel {
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    let placeText = BehaviorRelay<String>(value: "")
    let chaesoLogText = BehaviorRelay<String>(value: "")

    
    // 일단은 예제를 위해 두 개의 탭 항목을 생성합니다.
    // 실제로는 여기에 서버나 데이터베이스에서 가져온 데이터를 바인딩할 수 있습니다.
    let tabItems = BehaviorRelay<[String]>(value: [])
    
    // 현재 선택된 탭을 나타내는 변수입니다. 기본값은 "장소"로 설정하겠습니다.
    let currentTab: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
        
        Observable.combineLatest(placeText, chaesoLogText)
            .subscribe(onNext: { [weak self] place, chaeso in
                self?.tabItems.accept([place, chaeso])
            })
            .disposed(by: disposeBag)
    }
    
    private func updateLocalization() {
        placeText.accept(localizationManager.localizedString(forKey: "Place"))
        chaesoLogText.accept(localizationManager.localizedString(forKey: "ChaesoLog"))
    }

}
