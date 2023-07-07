import UIKit
import RxSwift
import RxCocoa

class StartViewModel {
    let disposeBag = DisposeBag()
    
    
    var localizationManager: LocalizationManager
    
    // Input
    let languageSelected = PublishSubject<String>()
    
    // Output
    let titleText = BehaviorRelay<String>(value: "")
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        languageSelected
            .subscribe(onNext: { [weak self] language in
                if(language == "한국어"){
                    self?.localizationManager.language = "ko"
                }
                else{
                    self?.localizationManager.language = "en"
                }
                self?.updateLocalization()
            })
            .disposed(by: disposeBag)
    }
    private func updateLocalization() {
        titleText.accept(localizationManager.localizedString(forKey: "Sign_Up"))
    }
}
