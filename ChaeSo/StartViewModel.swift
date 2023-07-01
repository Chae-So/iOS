//
//  ViewModel.swift
//  ChaeSo
//
//  Created by 박중선 on 2023/06/26.
//

import UIKit
import RxSwift

class StartViewModel {
    let languageSubject = BehaviorSubject<String>(value: LanguageManager.shared.currentLanguage)
    
    init() {
        // 언어 설정 변경을 감지하여 subject에 새로운 언어 코드를 전달
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: NSNotification.Name(rawValue: "LanguageDidChangeNotification"), object: nil)
    }
    
    @objc private func languageDidChange() {
        let language = LanguageManager.shared.currentLanguage
        languageSubject.onNext(language)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

