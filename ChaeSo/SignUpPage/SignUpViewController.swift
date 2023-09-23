import UIKit
import SnapKit
import RxCocoa
import RxSwift
import Then

class SignUpViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var signUpViewModel: SignUpViewModel
    
    lazy var signUpLabel = UILabel()
    lazy var leftButton = UIButton()
    lazy var imageView = UIImageView()
    
    lazy var emailLabel = UILabel()
    lazy var checkButton = UIButton()
    lazy var emailTextField = UITextField()
    lazy var isValidEmailFirstLabel = UILabel()
    lazy var isValidEmailSecondLabel = UILabel()
    
    lazy var pwLabel = UILabel()
    lazy var pwTextField = UITextField()
    lazy var isValidPwFirstLabel = UILabel()
    lazy var isValidPwSecondLabel = UILabel()
    
    lazy var pwConfirmLabel = UILabel()
    lazy var pwConfirmTextField = UITextField()
    lazy var isValidPwConfirmLabel = UILabel()

    lazy var nextButton = UIButton()
    
    init(signUpViewModel: SignUpViewModel) {
        self.signUpViewModel = signUpViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        bind()
        attribute()
        layout()
    }
    
    
    func bind(){
        
        leftButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        signUpViewModel.nextText
            .asDriver(onErrorDriveWith: .empty())
            .drive(nextButton.rx.title())
            .disposed(by: disposeBag)
                
        signUpViewModel.signUpText
            .asDriver(onErrorDriveWith: .empty())
            .drive(signUpLabel.rx.text)
            .disposed(by: disposeBag)
        
        signUpViewModel.emailText
            .asDriver(onErrorDriveWith: .empty())
            .drive(emailLabel.rx.text)
            .disposed(by: disposeBag)
        
        signUpViewModel.checkText
            .asDriver(onErrorDriveWith: .empty())
            .drive(checkButton.rx.title())
            .disposed(by: disposeBag)
    
        signUpViewModel.pwText
            .asDriver(onErrorDriveWith: .empty())
            .drive(pwLabel.rx.text)
            .disposed(by: disposeBag)
        
        signUpViewModel.pwConfirmText
            .asDriver(onErrorDriveWith: .empty())
            .drive(pwConfirmLabel.rx.text)
            .disposed(by: disposeBag)
        
        signUpViewModel.emailTextFieldPlaceholder
            .asDriver(onErrorDriveWith: .empty())
            .drive(emailTextField.rx.placeholder)
            .disposed(by: disposeBag)

        signUpViewModel.pwTextFieldPlaceholder
            .asDriver(onErrorDriveWith: .empty())
            .drive(pwTextField.rx.placeholder)
            .disposed(by: disposeBag)

        signUpViewModel.pwConfirmTextFieldPlaceholder
            .asDriver(onErrorDriveWith: .empty())
            .drive(pwConfirmTextField.rx.placeholder)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text.orEmpty
            .bind(to: signUpViewModel.emailInput)
            .disposed(by: disposeBag)
        
        pwTextField.rx.text.orEmpty
            .bind(to: signUpViewModel.pwInput)
            .disposed(by: disposeBag)
        
        pwConfirmTextField.rx.text.orEmpty
            .bind(to: signUpViewModel.pwConfirmInput)
            .disposed(by: disposeBag)
        
        
        
        //MARK: idLengthValid
        signUpViewModel.emailFormatValidText
            .asDriver(onErrorDriveWith: .empty())
            .drive(isValidEmailFirstLabel.rx.text)
            .disposed(by: disposeBag)
        
        signUpViewModel.emailFormatValid
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor(named: "prColor") : UIColor(hexCode: "FD4321") }
            .drive(isValidEmailFirstLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        //MARK: idCheckValidText
        signUpViewModel.emailCheckValidText
            .asDriver(onErrorDriveWith: .empty())
            .drive(isValidEmailSecondLabel.rx.text)
            .disposed(by: disposeBag)
        
        signUpViewModel.emailCheckValid
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor(named: "prColor") : UIColor(hexCode: "FD4321") }
            .drive(isValidEmailSecondLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        //MARK: idIsValid
        signUpViewModel.emailIsValid.asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor(named: "prColor")! : UIColor(hexCode: "FD4321") }
            .drive(emailTextField.rx.borderColor)
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
        
        signUpViewModel.allValid
            .asDriver(onErrorJustReturn: false)
            .drive(nextButton.rx.isEnabled)
            .disposed(by: disposeBag)

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
        
        self.view.backgroundColor = UIColor(named: "bgColor")
        
        signUpLabel.do{
            $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            $0.font = UIFont(name: "Pretendard-SemiBold", size: 20*Constants.standartFont)
            $0.textAlignment = .center
        }
        
        leftButton.setImage(UIImage(named: "left"), for: .normal)
        
        imageView = UIImageView(image: UIImage(named: "tomato"))
        
        [emailLabel,pwLabel,pwConfirmLabel].forEach{
            $0.textColor = UIColor.black
            $0.font = UIFont(name: "Pretendard-Medium", size: 16*Constants.standartFont)
            $0.textAlignment = .center
        }
        
        checkButton.do{
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16*Constants.standartFont)
            $0.tintColor = .white
            $0.backgroundColor = UIColor(named: "prColor")
            $0.layer.cornerRadius = 8*Constants.standardHeight
        }
        
        
        [emailTextField,pwTextField,pwConfirmTextField]
            .forEach{
                $0.alpha = 0.56
                $0.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
                $0.layer.cornerRadius = 8*Constants.standardHeight
                $0.layer.borderWidth = 1
                $0.layer.borderColor = UIColor.clear.cgColor
                $0.addLeftPadding()
                $0.keyboardType = .emailAddress
            }
        emailTextField.keyboardType = .emailAddress
        
        [isValidEmailFirstLabel,isValidEmailSecondLabel]
            .forEach{
                $0.font = UIFont(name: "Pretendard-Medium", size: 13*Constants.standartFont)
                $0.textColor = UIColor(named: "gray20")
            }

        
        [isValidPwFirstLabel,isValidPwSecondLabel,isValidPwConfirmLabel]
            .forEach{
                $0.font = UIFont(name: "Pretendard-Medium", size: 13*Constants.standartFont)
                $0.textColor = UIColor(named: "gray20")
            }

        
        nextButton.do{
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16*Constants.standartFont)
            $0.setTitleColor(UIColor(named: "prColor"), for: .normal)
            $0.backgroundColor = UIColor(named: "bgColor")
            $0.layer.cornerRadius = 8*Constants.standardHeight
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(named: "prColor")?.cgColor
        }

    }
    
    func layout(){
        [leftButton,signUpLabel,imageView]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        leftButton.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardHeight)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(10*Constants.standardHeight)
            make.top.equalToSuperview().offset(53*Constants.standardHeight)
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftButton.snp.trailing).offset(10*Constants.standardWidth)
            make.centerY.equalTo(leftButton)
        }
        
        
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(96.41*Constants.standardHeight)
            make.centerX.equalToSuperview().offset(0.5*Constants.standardWidth)
            make.top.equalToSuperview().offset(97*Constants.standardHeight)
        }
        
        [emailLabel,emailTextField,checkButton,isValidEmailFirstLabel,isValidEmailSecondLabel]
            .forEach {
                view.addSubview($0)
            }
        
        emailLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(223*Constants.standardHeight)
        }

        emailTextField.snp.makeConstraints { make in
            make.width.equalTo(223*Constants.standardWidth)
            make.height.equalTo(56*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(emailLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        checkButton.snp.makeConstraints { make in
            make.width.equalTo(112*Constants.standardWidth)
            make.height.equalTo(56*Constants.standardHeight)
            make.leading.equalTo(emailTextField.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalTo(emailTextField.snp.top)
        }
        
        isValidEmailFirstLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(emailTextField.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        isValidEmailSecondLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(isValidEmailFirstLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        [pwLabel,pwTextField,isValidPwFirstLabel,isValidPwSecondLabel,pwConfirmLabel,pwConfirmTextField,isValidPwConfirmLabel,nextButton]
            .forEach {
                view.addSubview($0)
            }
        
        pwLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(isValidEmailSecondLabel.snp.bottom).offset(28*Constants.standardHeight)
        }

        pwTextField.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(56*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(pwLabel.snp.bottom).offset(8*Constants.standardHeight)
        }

        isValidPwFirstLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(pwTextField.snp.bottom).offset(8*Constants.standardHeight)
        }

        isValidPwSecondLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(isValidPwFirstLabel.snp.bottom).offset(8*Constants.standardHeight)
        }

        pwConfirmLabel.snp.makeConstraints { make in
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
