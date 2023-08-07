import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import DropDown

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}


extension UIColor {
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

extension UserDefaults {
    private static let appleUserIDKey = "appleUserIDKey"

    static func saveAppleUserID(_ userID: String) {
        standard.set(userID, forKey: appleUserIDKey)
    }

    static func getAppleUserID() -> String? {
        return standard.string(forKey: appleUserIDKey)
    }
}

extension Reactive where Base: UIButton {
    var borderColor: Binder<CGColor?> {
        return Binder(self.base) { button, color in
            button.layer.borderColor = color
        }
    }
}

extension Reactive where Base: DropDown {
    var itemSelected: ControlEvent<(Int, String)> {
        let source = Observable<(Int, String)>.create { [weak base] observer in
            guard let base = base else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            base.selectionAction = { index, item in
                observer.onNext((index, item))
            }
            
            return Disposables.create {
                // Optional: Dispose 처리를 위해 Dropdown에서 selectionAction을 해제
                base.selectionAction = nil
            }
        }
        
        return ControlEvent(events: source)
    }
}

extension Reactive where Base: UIButton {
    func titleColor(for state: UIControl.State) -> Binder<UIColor> {
        return Binder(self.base) { button, color in
            button.setTitleColor(color, for: state)
        }
    }
}

extension Reactive where Base: UITextField {
    var borderColor: Binder<UIColor> {
        return Binder(self.base) { textField, color in
            textField.layer.borderColor = color.cgColor
        }
    }
}

extension Reactive where Base: UIButton {
    var imageViewContentMode: Binder<UIView.ContentMode> {
        return Binder(self.base) { button, contentMode in
            button.imageView?.contentMode = contentMode
        }
    }
}

extension Reactive where Base: UITextField {
    public var placeholder: Binder<String?> {
        return Binder(self.base) { textField, placeholder in
            textField.placeholder = placeholder
        }
    }
}

