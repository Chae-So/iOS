import UIKit
import RxCocoa
import RxSwift

class TosViewModel{
    
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    
    //MARK: - Input
    let firstLabelText = BehaviorRelay<String>(value: "")
    let secondLabelText = BehaviorRelay<String>(value: "")
    let allSelectLabelText = BehaviorRelay<String>(value: "")
    let serviceTosLabelText = BehaviorRelay<String>(value: "")
    let infoTosLabelText = BehaviorRelay<String>(value: "")
    
    let allSelectButtonTapped = PublishRelay<Void>()
    let serviceTosButtonTapped = PublishRelay<Void>()
    let infoTosButtonTapped = PublishRelay<Void>()
    
    // MARK: - Output
    var toggleAll = PublishRelay<Bool>()
    var toggleService = PublishRelay<Bool>()
    var toggleInfo = PublishRelay<Bool>()
    
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        
        firstLabelText.accept(localizationManager.localizedString(forKey: "Nice to meet you"))
        secondLabelText.accept(localizationManager.localizedString(forKey: "Please accept the ToS for using the service"))
        
        allSelectLabelText.accept(localizationManager.localizedString(forKey: "To select all"))
        serviceTosLabelText.accept(localizationManager.localizedString(forKey: "Agree to use the service (required)"))
        infoTosLabelText.accept(localizationManager.localizedString(forKey: "Agree with privacy policy (required)"))
        
        allSelectButtonTapped
            .scan(false){ lastState, newValue in
                !lastState
            }
            .bind(to: toggleAll)
            .disposed(by: disposeBag)

        
        serviceTosButtonTapped
            .scan(false){ lastState, newValue in
                !lastState
            }
            .bind(to: toggleService)
            .disposed(by: disposeBag)

        
        infoTosButtonTapped
            .scan(false){ lastState, newValue in
                print(!lastState)
                return !lastState
            }
            .bind(to: toggleInfo)
            .disposed(by: disposeBag)

        
        toggleAll.subscribe(onNext: { [weak self] state in
            guard let self = self else { return }
            self.toggleService.accept(state)
            self.toggleInfo.accept(state)
        })
        
        
        
    }
    
    
}

