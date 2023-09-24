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

extension UIButton {
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(attributedString, for: .normal)
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

extension Reactive where Base: UITabBarItem {
    var title: Binder<String?> {
        return Binder(self.base) { item, title in
            item.title = title
        }
    }
}

extension Reactive where Base: UIAlertController {
    func action(of alertAction: UIAlertAction) -> Observable<Void> {
        return Observable.create { [weak base] observer in
            let action = UIAlertAction(title: alertAction.title, style: alertAction.style) { _ in
                observer.onNext(())
                observer.onCompleted()
            }
            
            base?.addAction(action)
            return Disposables.create()
        }
    }
}

extension Reactive where Base: UICollectionView {
    var updateSelectedCellBorderColor: Binder<IndexPath?> {
        return Binder(self.base) { collectionView, indexPath in
            for visibleCell in collectionView.visibleCells {
                if let cellIndexPath = collectionView.indexPath(for: visibleCell) {
                    visibleCell.layer.cornerRadius = visibleCell.frame.size.height / 2
                    visibleCell.layer.borderWidth = (cellIndexPath == indexPath) ? 1.0 : 0.0
                    visibleCell.layer.borderColor = (cellIndexPath == indexPath) ? UIColor(named: "prColor")?.cgColor : UIColor.clear.cgColor
                }
            }
        }
    }
    
    
    var updateSelectedCellTextColor: Binder<IndexPath?> {
        return Binder(self.base) { collectionView, indexPath in
            for visibleCell in collectionView.visibleCells {
                if let cell = visibleCell as? VSTabCell, let cellIndexPath = collectionView.indexPath(for: visibleCell) {
                    cell.titleLabel.textColor = (cellIndexPath == indexPath) ? .black : .gray
                }
            }
        }
    }
    
}

