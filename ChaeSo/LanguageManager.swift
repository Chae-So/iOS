
import Foundation

class LanguageManager {
    static let shared = LanguageManager()
    
    private let languageKey = "AppLanguage"
    
    var currentLanguage: String {
        return UserDefaults.standard.string(forKey: languageKey) ?? ""
    }
    
    func setLanguage(_ languageCode: String) {
        UserDefaults.standard.set(languageCode, forKey: languageKey)
        UserDefaults.standard.synchronize()
    }
}
