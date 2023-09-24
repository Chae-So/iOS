import Foundation
import RxSwift
import RxCocoa

class TabBarViewModel {
    let disposeBag = DisposeBag()
    var localizationManager: LocalizationManager
    
    var chaesoLogText = BehaviorRelay(value: "")
    var mapText  = BehaviorRelay(value: "")
    var myPageText  = BehaviorRelay(value: "")
    
    let selectedIndex = BehaviorRelay<Int>(value: 0)
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
        
        LocalizationManager.shared.rxLanguage
            .subscribe(onNext: { [weak self] language in

                let a = self?.localizationManager.localizedString(forKey: "CheasoLog")
                let b = self?.localizationManager.localizedString(forKey: "Map")
                let c = self?.localizationManager.localizedString(forKey: "My Page")
                
                self?.chaesoLogText.accept(a!)
                self?.mapText.accept(b!)
                self?.myPageText.accept(c!)

            })
            .disposed(by: disposeBag)
        
    }
    
    
}
