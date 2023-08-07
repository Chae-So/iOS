import Foundation

class LocalizationManager {
    static let shared = LocalizationManager()
    var language: String = ""
    private init() {
        // Private initialization to ensure just one instance is created.
        // Read the device language from Info.plist and set it to language property
        if let appLanguage = Bundle.main.preferredLocalizations.first {
            language = appLanguage
        }
    }
    
    func localizedString(forKey key: String, arguments: CVarArg...) -> String {
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        let format = bundle?.localizedString(forKey: key, value: nil, table: nil) ?? ""
        return String(format: format, arguments: arguments)
    }

}
