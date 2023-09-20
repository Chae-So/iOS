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
    
    lazy var idLabel = UILabel()
    lazy var checkButton = UIButton()
    let idTextField = UITextField()
    lazy var isValidIdFirstLabel = UILabel()
    lazy var isValidIdSecondLabel = UILabel()
    lazy var isValidIdThirdLabel = UILabel()
    
    lazy var pwLabel = UILabel()
    let pwTextField = UITextField()
    lazy var isValidPwFirstLabel = UILabel()
    lazy var isValidPwSecondLabel = UILabel()
    
    lazy var pwConfirmLabel = UILabel()
    let pwConfirmTextField = UITextField()
    lazy var isValidPwConfirmLabel = UILabel()

    lazy var nextButton = UIButton()
    
    init(signUpViewModel: SignUpViewModel!) {
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
        
        signUpViewModel.idText
            .asDriver(onErrorDriveWith: .empty())
            .drive(idLabel.rx.text)
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
        
        [idLabel,pwLabel,pwConfirmLabel].forEach{
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
        
        
        [idTextField,pwTextField,pwConfirmTextField]
            .forEach{
                $0.alpha = 0.56
                $0.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
                $0.layer.cornerRadius = 8*Constants.standardHeight
                $0.layer.borderWidth = 1
                $0.layer.borderColor = UIColor.clear.cgColor
                $0.addLeftPadding()
                $0.keyboardType = .emailAddress
            }
        idTextField.keyboardType = .emailAddress
        
        [isValidIdFirstLabel,isValidIdSecondLabel,isValidIdThirdLabel]
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
        
        [idLabel,idTextField,checkButton,isValidIdFirstLabel,isValidIdSecondLabel,isValidIdThirdLabel]
            .forEach {
                view.addSubview($0)
            }
        
        idLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(223*Constants.standardHeight)
        }

        idTextField.snp.makeConstraints { make in
            make.width.equalTo(223*Constants.standardWidth)
            make.height.equalTo(56*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(idLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        checkButton.snp.makeConstraints { make in
            make.width.equalTo(112*Constants.standardWidth)
            make.height.equalTo(56*Constants.standardHeight)
            make.leading.equalTo(idTextField.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalTo(idTextField.snp.top)
        }
        
        isValidIdFirstLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(idTextField.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        isValidIdSecondLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(isValidIdFirstLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        isValidIdThirdLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(isValidIdSecondLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        [pwLabel,pwTextField,isValidPwFirstLabel,isValidPwSecondLabel,pwConfirmLabel,pwConfirmTextField,isValidPwConfirmLabel,nextButton]
            .forEach {
                view.addSubview($0)
            }
        
        pwLabel.snp.makeConstraints { make in
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
