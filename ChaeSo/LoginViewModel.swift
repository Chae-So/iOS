//
//  LoginViewModel.swift
//  ChaeSo
//
//  Created by 박중선 on 2023/06/26.
//

import Foundation

struct LoginViewModel{
    
}


//import Foundation
//
//extension Bundle {
//    private static var currentLanguage: String?
//    
//    static func setLanguage(_ languageCode: String) {
//        currentLanguage = languageCode
//        swizzleMainBundle()
//    }
//    
//    private static func swizzleMainBundle() {
//        guard let originalMethod = class_getInstanceMethod(self, #selector(getter: main)) else { return }
//        guard let swizzledMethod = class_getInstanceMethod(self, #selector(swizzledMain)) else { return }
//        
//        method_exchangeImplementations(originalMethod, swizzledMethod)
//    }
//    
//    @objc private func swizzledMain() -> Bundle {
//        if let languageCode = Bundle.currentLanguage, let path = Bundle.main.path(forResource: languageCode, ofType: "lproj") {
//            return Bundle(path: path) ?? self
//        }
//        
//        return swizzledMain()
//    }
//}
//import Foundation
//
//class LanguageManager {
//    static let shared = LanguageManager()
//    
//    private let languageKey = "AppLanguage"
//    
//    var currentLanguage: String {
//        return UserDefaults.standard.string(forKey: languageKey) ?? ""
//    }
//    
//    func setLanguage(_ languageCode: String) {
//        UserDefaults.standard.set(languageCode, forKey: languageKey)
//        UserDefaults.standard.synchronize()
//    }
//}
//import Foundation
//import RxSwift
//
//class ViewModel {
//    let languageSubject = BehaviorSubject<String>(value: LanguageManager.shared.currentLanguage)
//    
//    init() {
//        // 언어 설정 변경을 감지하여 subject에 새로운 언어 코드를 전달
//        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: NSNotification.Name(rawValue: "LanguageDidChangeNotification"), object: nil)
//    }
//    
//    @objc private func languageDidChange() {
//        let language = LanguageManager.shared.currentLanguage
//        languageSubject.onNext(language)
//    }
//    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//}
//import UIKit
//import RxSwift
//import RxCocoa
//
//class FirstViewController: UIViewController {
//    @IBOutlet weak var koreanButton: UIButton!
//    @IBOutlet weak var englishButton: UIButton!
//    @IBOutlet weak var label1: UILabel!
//    @IBOutlet weak var label2: UILabel!
//    @IBOutlet weak var label3: UILabel!
//    
//    let disposeBag = DisposeBag()
//    let viewModel = ViewModel()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        bindViewModel()
//        setupButtons()
//        updateLocalizedTexts()
//    }
//    
//    private func bindViewModel() {
//        // 언어 설정 변경을 감지하여 라벨 텍스트 업데이트
//        viewModel.languageSubject
//            .subscribe(onNext: { [weak self] _ in
//                self?.updateLocalizedTexts()
//            })
//            .disposed(by: disposeBag)
//    }
//    
//    private func setupButtons() {
//        koreanButton.rx.tap
//            .subscribe(onNext: { [weak self] in
//                self?.changeLanguage(to: "ko")
//            })
//            .disposed(by: disposeBag)
//        
//        englishButton.rx.tap
//            .subscribe(onNext: { [weak self] in
//                self?.changeLanguage(to: "en")
//            })
//            .disposed(by: disposeBag)
//    }
//    
//    private func changeLanguage(to languageCode: String) {
//        LanguageManager.shared.setLanguage(languageCode)
//        Bundle.setLanguage(languageCode) // 추가
//        
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LanguageDidChangeNotification"), object: nil)
//    }
//
//    
//    private func updateLocalizedTexts() {
//        label1.text = NSLocalizedString("label1", comment: "")
//        label2.text = NSLocalizedString("label2", comment: "")
//        label3.text = NSLocalizedString("label3", comment: "")
//    }
//}
//
//import UIKit
//
//class SecondViewController: UIViewController {
//    @IBOutlet weak var label: UILabel!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        updateLocalizedTexts()
//    }
//    
//    private func updateLocalizedTexts() {
//        label.text = NSLocalizedString("label", comment: "")
//    }
//}
//
//class ThirdViewController: UIViewController {
//    @IBOutlet weak var label: UILabel!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        updateLocalizedTexts()
//    }
//    
//    private func updateLocalizedTexts() {
//        label.text = NSLocalizedString("label", comment: "")
//    }
//}
