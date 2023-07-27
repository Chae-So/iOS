import Foundation
import RxSwift
import RxCocoa

class CommunityViewModel {
    
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    let chaesoLogText = BehaviorRelay<String>(value: "")
    let recommendText = BehaviorRelay<String>(value: "")
    let latestText = BehaviorRelay<String>(value: "")

    let tabItems = BehaviorRelay<[String]>(value: [])
    
    // 현재 선택된 탭을 나타내는 변수입니다. 기본값은 "장소"로 설정하겠습니다.
    let currentTab: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
        
        Observable.combineLatest(recommendText,latestText)
            .subscribe(onNext: { [weak self] reco, latest in
                self?.tabItems.accept([reco, latest])
            })
            .disposed(by: disposeBag)
    }
    
    private func updateLocalization() {
        chaesoLogText.accept(localizationManager.localizedString(forKey: "Chaeso Log"))
        recommendText.accept(localizationManager.localizedString(forKey: "Recommend"))
        latestText.accept(localizationManager.localizedString(forKey: "Latest"))
    }
    
    
    
}
