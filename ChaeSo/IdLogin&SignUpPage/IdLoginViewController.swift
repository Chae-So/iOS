import UIKit
import SnapKit
import RxCocoa
import RxSwift
import Then

class IdLoginViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var signUpViewModel: SignUpViewModel!
    
    lazy var loginLabel = UILabel()
    var imageView = UIImageView()
    lazy var idLabel = UILabel()
    let idTextField = UITextField()
    lazy var pwLabel = UILabel()
    let pwTextField = UITextField()

    lazy var loginButton = UIButton()
    
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
                //ToDo: 메인 페이지 연결 및 아이디 비번 맞는지 확인
                guard let self = self else { return }
                let tabBarViewController = TabBarController(tabBarViewModel: TabBarViewModel(localizationManager: LocalizationManager.shared))
                self.navigationController?.pushViewController(tabBarViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
    }
    
    func attribute(){
        
        self.view.backgroundColor = UIColor(named: "bgColor")
        
        loginLabel.do{
            $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            $0.font = UIFont(name: "Pretendard-SemiBold", size: 20*Constants.standartFont)
            $0.textAlignment = .center
        }
        
        imageView = UIImageView(image: UIImage(named: "tomato"))
        
        [idLabel,pwLabel]
            .forEach{
                $0.textColor = UIColor.black
                $0.font = UIFont(name: "Pretendard-Medium", size: 16*Constants.standartFont)
                $0.textAlignment = .center
            }
        
        [idTextField,pwTextField]
            .forEach{
                $0.alpha = 0.56
                $0.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
                $0.layer.cornerRadius = 8*Constants.standardHeight
                $0.layer.borderWidth = 1
                $0.layer.borderColor = UIColor.clear.cgColor
                $0.addLeftPadding()
                
            }
        
        idTextField.keyboardType = .emailAddress
       
        loginButton.do{
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16*Constants.standartFont)
            $0.setTitleColor(UIColor(named: "prColor"), for: .normal)
            $0.setTitle("next", for: .normal)
            $0.backgroundColor = UIColor(named: "bgColor")
            $0.layer.cornerRadius = 8*Constants.standardHeight
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(named: "prColor")?.cgColor
        }

    }
    
    func layout(){
        [loginLabel,imageView,idLabel,idTextField,pwLabel,pwTextField,loginButton]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        loginLabel.snp.makeConstraints { make in
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
