import Foundation
import RxSwift
import RxCocoa

class TabBarViewModel {
    var localizationManager: LocalizationManager
    
    var chaesoLogText: String{
        return localizationManager.localizedString(forKey: "CheasoLog")
    }
    var mapText: String{
        return localizationManager.localizedString(forKey: "map")
    }
    var myPageText: String{
        return localizationManager.localizedString(forKey: "myPage")
    }
    
    let selectedIndex = BehaviorRelay<Int>(value: 0)
    
    init(localizationManager: LocalizationManager) {
        self.localizationManager = localizationManager
    }
}
