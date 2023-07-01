//
//  File.swift
//  ChaeSo
//
//  Created by 박중선 on 2023/06/26.
//

import Foundation
import UIKit

extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}

extension Bundle {
    private static var currentLanguage: String?
    
    static func setLanguage(_ languageCode: String) {
        currentLanguage = languageCode
        swizzleMainBundle()
    }
    
    private static func swizzleMainBundle() {
        guard let originalMethod = class_getInstanceMethod(self, #selector(getter: main)) else { return }
        guard let swizzledMethod = class_getInstanceMethod(self, #selector(swizzledMain)) else { return }
        
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    
    @objc private func swizzledMain() -> Bundle {
        if let languageCode = Bundle.currentLanguage, let path = Bundle.main.path(forResource: languageCode, ofType: "lproj") {
            return Bundle(path: path) ?? self
        }
        
        return swizzledMain()
    }
}
