import UIKit
import RxSwift
import RxCocoa

class StartViewModel {
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager

    let languageSelected = PublishSubject<String>()
    let startButtonEnable = BehaviorRelay<Bool>(value: false)
    
    let selectLanguageText = BehaviorRelay<String>(value: "")
    let startText = BehaviorRelay<String>(value: "")

    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        self.updateLocalization()
        languageSelected
            .subscribe(onNext: { [weak self] language in
                if(language == "한국어"){
                    self?.localizationManager.language = "ko"
                }
                else{
                    self?.localizationManager.language = "en"
                }
                self?.startButtonEnable.accept(true)
                self?.updateLocalization()
            })
            .disposed(by: disposeBag)
    }
    private func updateLocalization() {
        selectLanguageText.accept(localizationManager.localizedString(forKey: "Select Language"))
        startText.accept(localizationManager.localizedString(forKey: "Start"))
    }
}
