import UIKit
import SnapKit
import RxCocoa
import RxSwift

class SignUpViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    var signUpViewModel: SignUpViewModel!
    
    private lazy var signUpLabel = UILabel()
    private lazy var imageView = UIImageView()
    
    private lazy var idLabel = UILabel()
    private lazy var idTextField = UITextField()
    private lazy var isValidIdFirstLabel = UILabel()
    private lazy var isValidIdSecondLabel = UILabel()
    private lazy var isValidIdThirdLabel = UILabel()
    
    private lazy var pwLabel = UILabel()
    private lazy var pwTextField = UITextField()
    private lazy var isValidPwFirstLabel = UILabel()
    private lazy var isValidPwSecondLabel = UILabel()
    
    private lazy var pwConfirmLabel = UILabel()
    private lazy var pwConfirmTextField = UITextField()
    private lazy var isValidPwConfirmLabel = UILabel()

    private let nextButton = UIButton()
    
    init(signUpViewModel: SignUpViewModel!) {
        self.signUpViewModel = signUpViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.hidesBackButton = true
        
        bind()
        attribute()
        layout()
    }
    
    
    func bind(){
                
        signUpViewModel.signUpText
            .asDriver(onErrorDriveWith: .empty())
            .drive(signUpLabel.rx.text)
            .disposed(by: disposeBag)
        
        signUpViewModel.idText
            .asDriver(onErrorDriveWith: .empty())
            .drive(idLabel.rx.text)
            .disposed(by: disposeBag)
    
        signUpViewModel.pwText
            .asDriver(onErrorDriveWith: .empty())
            .drive(pwLabel.rx.text)
            .disposed(by: disposeBag)
        
        signUpViewModel.pwConfirmText
            .asDriver(onErrorDriveWith: .empty())
            .drive(pwConfirmLabel.rx.text)
            .disposed(by: disposeBag)
        
        signUpViewModel.idTextFieldPlaceholder
            .asDriver(onErrorDriveWith: .empty())
            .drive(idTextField.rx.placeholder)
            .disposed(by: disposeBag)

        signUpViewModel.pwTextFieldPlaceholder
            .asDriver(onErrorDriveWith: .empty())
            .drive(pwTextField.rx.placeholder)
            .disposed(by: disposeBag)

        signUpViewModel.pwConfirmTextFieldPlaceholder
            .asDriver(onErrorDriveWith: .empty())
            .drive(pwConfirmTextField.rx.placeholder)
            .disposed(by: disposeBag)
        
        idTextField.rx.text.orEmpty
            .bind(to: signUpViewModel.idInput)
            .disposed(by: disposeBag)
        
        pwTextField.rx.text.orEmpty
            .bind(to: signUpViewModel.pwInput)
            .disposed(by: disposeBag)
        
        pwConfirmTextField.rx.text.orEmpty
            .bind(to: signUpViewModel.pwConfirmInput)
            .disposed(by: disposeBag)
        
        
        
        //MARK: idLengthValid
        signUpViewModel.idLengthValidText
            .asDriver(onErrorDriveWith: .empty())
            .drive(isValidIdFirstLabel.rx.text)
            .disposed(by: disposeBag)
        
        signUpViewModel.idLengthValid
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor(named: "prColor") : UIColor(hexCode: "FD4321") }
            .drive(isValidIdFirstLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        //MARK: idValid
        signUpViewModel.idValidText
            .asDriver(onErrorDriveWith: .empty())
            .drive(isValidIdSecondLabel.rx.text)
            .disposed(by: disposeBag)
        
        signUpViewModel.idValid
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor(named: "prColor") : UIColor(hexCode: "FD4321") }
            .drive(isValidIdSecondLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        //MARK: idCheckValidText
        signUpViewModel.idCheckValidText
            .asDriver(onErrorDriveWith: .empty())
            .drive(isValidIdThirdLabel.rx.text)
            .disposed(by: disposeBag)
        
        signUpViewModel.idCheckValid
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor(named: "prColor") : UIColor(hexCode: "FD4321") }
            .drive(isValidIdThirdLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        //MARK: idIsValid
        signUpViewModel.idIsValid.asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor(named: "prColor")! : UIColor(hexCode: "FD4321") }
            .drive(idTextField.rx.borderColor)
            .disposed(by: disposeBag)
        
        //MARK: pwLengthValid
        signUpViewModel.pwLengthValidText
            .asDriver(onErrorDriveWith: .empty())
            .drive(isValidPwFirstLabel.rx.text)
            .disposed(by: disposeBag)
        
        signUpViewModel.pwLengthValid
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor(named: "prColor") : UIColor(hexCode: "FD4321") }
            .drive(isValidPwFirstLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        //MARK: pwValid
        signUpViewModel.pwValidText
            .asDriver(onErrorDriveWith: .empty())
            .drive(isValidPwSecondLabel.rx.text)
            .disposed(by: disposeBag)
        
        signUpViewModel.pwValid
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor(named: "prColor") : UIColor(hexCode: "FD4321") }
            .drive(isValidPwSecondLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        //MARK: pwIsValid
        signUpViewModel.pwIsValid
            .asDriver(onErrorDriveWith: .empty())
            .map { $0 ? UIColor(named: "prColor")! : UIColor(hexCode: "FD4321") }
            .drive(pwTextField.rx.borderColor)
            .disposed(by: disposeBag)
        
        //MARK: pwConfirmValid
        signUpViewModel.pwConfirmValidText
            .asDriver(onErrorDriveWith: .empty())
            .drive(isValidPwConfirmLabel.rx.text)
            .disposed(by: disposeBag)
        
        signUpViewModel.pwConfirmValid
            .asDriver(onErrorDriveWith: .empty())
            .map { $0 ? UIColor(named: "prColor") : UIColor(hexCode: "FD4321") }
            .drive(isValidPwConfirmLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        signUpViewModel.pwConfirmValid
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor(named: "prColor")! : UIColor(hexCode: "FD4321") }
            .drive(pwConfirmTextField.rx.borderColor)
            .disposed(by: disposeBag)
        
        // Bind view model output to button state
        signUpViewModel.allValid
            .asDriver(onErrorJustReturn: false)
            .drive(nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        // Bind view model output to button background color and border color
        signUpViewModel.allValid
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor(named: "prColor") : UIColor(named: "bgColor") }
            .drive(nextButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        signUpViewModel.allValid
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor.white : UIColor(named: "prColor")! }
            .drive(nextButton.rx.titleColor(for: .normal))
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let tosViewModel = TosViewModel(localizationManager: LocalizationManager.shared)
                let tosViewController = TosViewController(tosViewModel: tosViewModel)
                self.navigationController?.pushViewController(tosViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
    }
    
    func attribute(){
        //MARK: signUpLabel Attribute
        signUpLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        signUpLabel.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        signUpLabel.textAlignment = .center
        
        //MARK: 바탕색
        self.view.backgroundColor = UIColor(named: "bgColor")
        
        //MARK: imageView attribute
        imageView = UIImageView(image: UIImage(named: "tomato"))
        
        //MARK: idlLabel attribute
        idLabel.textColor = UIColor.black
        idLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        idLabel.textAlignment = .center
        
        //MARK: idTextField attribute
        idTextField.alpha = 0.56
        idTextField.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
        idTextField.layer.cornerRadius = 8
        idTextField.layer.borderWidth = 1
        idTextField.layer.borderColor = UIColor.clear.cgColor
        idTextField.addLeftPadding()
        idTextField.keyboardType = .emailAddress
        
        //MARK: isValidIdFirstLabel attribute
        isValidIdFirstLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        isValidIdFirstLabel.textColor = UIColor(named: "gray20")
        
        //MARK: isValidIdSecondLabel attribute
        isValidIdSecondLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        isValidIdSecondLabel.textColor = UIColor(named: "gray20")
        
        //MARK: isValidIdThirdLabel attribute
        isValidIdThirdLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        isValidIdThirdLabel.textColor = UIColor(named: "gray20")
        
        
        
        //MARK: pwLabel attribute
        pwLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        pwLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        
        
        //MARK: pwTextField attribute
        pwTextField.alpha = 0.56
        pwTextField.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
        pwTextField.layer.cornerRadius = 8
        pwTextField.layer.borderWidth = 1
        pwTextField.layer.borderColor = UIColor.clear.cgColor
        pwTextField.addLeftPadding()
        
        //MARK: isValidPwFirstLabel attribute
        isValidPwFirstLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        isValidPwFirstLabel.textColor = UIColor(named: "gray20")
        
        //MARK: isValidPwSecondLabel attribute
        isValidPwSecondLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        isValidPwSecondLabel.textColor = UIColor(named: "gray20")
        
        //MARK: pwConfirmLabel attribute
        pwConfirmLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        pwConfirmLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        
        //MARK: pwConfirmTextField attribute
        pwConfirmTextField.alpha = 0.56
        pwConfirmTextField.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
        pwConfirmTextField.layer.cornerRadius = 8
        pwConfirmTextField.layer.borderWidth = 1
        pwConfirmTextField.layer.borderColor = UIColor.clear.cgColor
        pwConfirmTextField.addLeftPadding()
        
        //MARK: isValidPwConfirmLabel attribute
        isValidPwConfirmLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        isValidPwConfirmLabel.textColor = UIColor(named: "gray20")
        
        //MARK: nextButton attribute
        nextButton.titleLabel?.textAlignment = .center
        nextButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        nextButton.setTitleColor(UIColor(named: "prColor"), for: .normal)
        nextButton.setTitle("next", for: .normal)
        nextButton.backgroundColor = UIColor(named: "bgColor")
        nextButton.layer.cornerRadius = 8
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor(named: "prColor")?.cgColor

    }
    
    func layout(){
        [signUpLabel,imageView]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        signUpLabel.snp.makeConstraints { make in
            make.height.equalTo(30.55*Constants.standardHeight)
            make.leading.equalToSuperview().offset(22*Constants.standardWidth)
            make.top.equalToSuperview().offset(55*Constants.standardHeight)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(96.41*Constants.standardHeight)
            make.centerX.equalToSuperview().offset(0.5*Constants.standardWidth)
            make.top.equalToSuperview().offset(97*Constants.standardHeight)
        }
        
        [idLabel,idTextField,isValidIdFirstLabel,isValidIdSecondLabel,isValidIdThirdLabel]
            .forEach {
                view.addSubview($0)
            }
        
        
        
        idLabel.snp.makeConstraints { make in
            make.height.equalTo(19*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(223*Constants.standardHeight)
        }

        idTextField.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(56*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(idLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        isValidIdFirstLabel.snp.makeConstraints { make in
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(idTextField.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        isValidIdSecondLabel.snp.makeConstraints { make in
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(isValidIdFirstLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        isValidIdThirdLabel.snp.makeConstraints { make in
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(isValidIdSecondLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        [pwLabel,pwTextField,isValidPwFirstLabel,isValidPwSecondLabel,pwConfirmLabel,pwConfirmTextField,isValidPwConfirmLabel,nextButton]
            .forEach {
                view.addSubview($0)
            }
        
        pwLabel.snp.makeConstraints { make in
            make.height.equalTo(19*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(isValidIdThirdLabel.snp.bottom).offset(28*Constants.standardHeight)
        }

        pwTextField.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(56*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(pwLabel.snp.bottom).offset(8*Constants.standardHeight)
        }

        isValidPwFirstLabel.snp.makeConstraints { make in
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(pwTextField.snp.bottom).offset(8*Constants.standardHeight)
        }

        isValidPwSecondLabel.snp.makeConstraints { make in
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(isValidPwFirstLabel.snp.bottom).offset(8*Constants.standardHeight)
        }

        pwConfirmLabel.snp.makeConstraints { make in
            make.height.equalTo(19*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(isValidPwSecondLabel.snp.bottom).offset(28*Constants.standardHeight)
        }
        
        pwConfirmTextField.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(56*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(pwConfirmLabel.snp.bottom).offset(8*Constants.standardHeight)
        }

        isValidPwConfirmLabel.snp.makeConstraints { make in
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(pwConfirmTextField.snp.bottom).offset(8*Constants.standardHeight)
        }

        nextButton.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(57*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(720*Constants.standardHeight)
        }
        
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

//
//#if DEBUG
//import SwiftUI
//struct Preview: UIViewControllerRepresentable {
//
//    // 여기 ViewController를 변경해주세요
//    func makeUIViewController(context: Context) -> UIViewController {
//        SignUpViewController(signUpViewModel: SignUpViewModel(localizationManager: LocalizationManager.shared))
//    }
//
//    func updateUIViewController(_ uiView: UIViewController,context: Context) {
//        // leave this empty
//    }
//}
//
//struct ViewController_PreviewProvider: PreviewProvider {
//    static var previews: some View {
//        Preview()
//            .edgesIgnoringSafeArea(.all)
//            .previewDisplayName("Preview")
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
//
//        Preview()
//            .edgesIgnoringSafeArea(.all)
//            .previewDisplayName("Preview")
//            .previewDevice(PreviewDevice(rawValue: "iPhoneX"))
//
//    }
//}
//#endif
