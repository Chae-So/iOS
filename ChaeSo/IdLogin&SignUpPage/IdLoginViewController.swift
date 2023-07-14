import UIKit
import SnapKit
import RxCocoa
import RxSwift

class IdLoginViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    var signUpViewModel: SignUpViewModel!
    
    private lazy var loginLabel = UILabel()
    private lazy var imageView = UIImageView()
    
    private lazy var idLabel = UILabel()
    private lazy var idTextField = UITextField()

    private lazy var pwLabel = UILabel()
    private lazy var pwTextField = UITextField()

    private let loginButton = UIButton()
    
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
                
        signUpViewModel.loginText
            .asDriver(onErrorDriveWith: .empty())
            .drive(loginLabel.rx.text)
            .disposed(by: disposeBag)
        
        signUpViewModel.idText
            .asDriver(onErrorDriveWith: .empty())
            .drive(idLabel.rx.text)
            .disposed(by: disposeBag)
        
        signUpViewModel.pwText
            .asDriver(onErrorDriveWith: .empty())
            .drive(pwLabel.rx.text)
            .disposed(by: disposeBag)
        
        signUpViewModel.idTextFieldPlaceholder
            .asDriver(onErrorDriveWith: .empty())
            .drive(idTextField.rx.placeholder)
            .disposed(by: disposeBag)

        signUpViewModel.pwTextFieldPlaceholder
            .asDriver(onErrorDriveWith: .empty())
            .drive(pwTextField.rx.placeholder)
            .disposed(by: disposeBag)

        idTextField.rx.text.orEmpty
            .bind(to: signUpViewModel.loginIdInput)
            .disposed(by: disposeBag)
        
        pwTextField.rx.text.orEmpty
            .bind(to: signUpViewModel.loginPwInput)
            .disposed(by: disposeBag)
        
        
        signUpViewModel.loginValid
            .asDriver(onErrorJustReturn: false)
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)

        signUpViewModel.loginValid
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor(named: "prColor") : UIColor(named: "bgColor") }
            .drive(loginButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        signUpViewModel.loginValid
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor.white : UIColor(named: "prColor")! }
            .drive(loginButton.rx.titleColor(for: .normal))
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                //Todo: 메인 페이지 연결 및 아이디 비번 맞는지 확인
                guard let self = self else { return }
                let tosViewModel = TosViewModel(localizationManager: LocalizationManager.shared)
                let tosViewController = TosViewController(tosViewModel: tosViewModel)
                self.navigationController?.pushViewController(tosViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
    }
    
    func attribute(){
        //MARK: signUpLabel Attribute
        loginLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        loginLabel.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        loginLabel.textAlignment = .center
        
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
        
        
        //MARK: loginButton attribute
        loginButton.titleLabel?.textAlignment = .center
        loginButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        loginButton.setTitleColor(UIColor(named: "prColor"), for: .normal)
        loginButton.setTitle("next", for: .normal)
        loginButton.backgroundColor = UIColor(named: "bgColor")
        loginButton.layer.cornerRadius = 8
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor(named: "prColor")?.cgColor

    }
    
    func layout(){
        [loginLabel,imageView,idLabel,idTextField,pwLabel,pwTextField,loginButton]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        loginLabel.snp.makeConstraints { make in
            make.height.equalTo(30.55*Constants.standardHeight)
            make.leading.equalToSuperview().offset(22*Constants.standardWidth)
            make.top.equalToSuperview().offset(55*Constants.standardHeight)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(96.41*Constants.standardHeight)
            make.centerX.equalToSuperview().offset(0.5*Constants.standardWidth)
            make.top.equalToSuperview().offset(160*Constants.standardHeight)
        }
        
        idLabel.snp.makeConstraints { make in
            make.height.equalTo(19*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(337*Constants.standardHeight)
        }

        idTextField.snp.makeConstraints { make in
            make.width.equalTo(223*Constants.standardWidth)
            make.height.equalTo(56*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(idLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        pwLabel.snp.makeConstraints { make in
            make.height.equalTo(19*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(460*Constants.standardHeight)
        }

        pwTextField.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(56*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(pwLabel.snp.bottom).offset(8*Constants.standardHeight)
        }

        loginButton.snp.makeConstraints { make in
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
