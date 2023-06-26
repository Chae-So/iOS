import UIKit
import SnapKit
import RxCocoa
import RxSwift

class AccountInfoViewController: UIViewController {
    
    private lazy var imageView = UIImageView()
    private lazy var whiteView = UIView()
    private let emailLabel = UILabel()
    private lazy var emailTextField = UITextField()
    private let passwordLabel = UILabel()
    private lazy var passwordTextField = UITextField()
    private lazy var rePasswordTextField = UITextField()
    
    private let orLabel = UILabel()
    private let appleLoginButton = UIButton()
    private let cacaoLoginButton = UIButton()
    
    private let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: AccountInfoViewModel){
        
    }
    
    func attribute(){
        //MARK: 바탕색
        self.view.backgroundColor = UIColor(named: "bgColor")
        
        //MARK: imageView attribute
        imageView = UIImageView(image: UIImage(named: "tomato"))
        
        //MARK: whiteView attribute
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 16
        
        //MARK: emailLabel attribute
        emailLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        emailLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        emailLabel.textAlignment = .center
        emailLabel.text = "E-mail"
        
        
        //MARK: emailTextField attribute
        emailTextField.alpha = 0.56
        emailTextField.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
        emailTextField.layer.cornerRadius = 8
        emailTextField.addLeftPadding()
        emailTextField.placeholder = "이메일을 입력해 주세요."
        
        //MARK: passwordLabel attribute
        passwordLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        passwordLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        passwordLabel.text = "password"
        
        
        //MARK: passwordTextField attribute
        passwordTextField.alpha = 0.56
        passwordTextField.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.addLeftPadding()
        passwordTextField.placeholder = "비밀번호를 입력해 주세요."
        
        //MARK: rePasswordTextField attribute
        passwordTextField.alpha = 0.56
        passwordTextField.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.addLeftPadding()
        passwordTextField.placeholder = "비밀번호를 다시 입력해 주세요."
        
        //MARK: orLabel attribute
        orLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        orLabel.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        orLabel.text = "or"
        
        //MARK: nextButton attribute
        nextButton.titleLabel?.textAlignment = .center
        nextButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        nextButton.setTitleColor(UIColor.white, for: .normal)
        nextButton.setTitle("next", for: .normal)
        nextButton.backgroundColor = UIColor(named: "prColor")
        nextButton.layer.cornerRadius = 8
    }
    
    func layout(){
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(96.41)
            make.centerX.equalToSuperview().offset(0.5)
            make.top.equalToSuperview().offset(97)
        }
        
        [whiteView,emailLabel,emailTextField,passwordLabel,passwordTextField,rePasswordTextField,orLabel,appleLoginButton,cacaoLoginButton,nextButton]
            .forEach {
                view.addSubview($0)
            }
        
        whiteView.snp.makeConstraints { make in
            make.width.equalTo(375)
            make.height.equalTo(565)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints { make in
            make.width.equalTo(46)
            make.height.equalTo(19)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(271)
        }

        emailTextField.snp.makeConstraints { make in
            make.width.equalTo(343)
            make.height.equalTo(56)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(306)
        }
        passwordLabel.snp.makeConstraints { make in
            make.width.equalTo(72)
            make.height.equalTo(19)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(386)
        }
        
    }
}

#if DEBUG
import SwiftUI
struct Preview: UIViewControllerRepresentable {

    // 여기 ViewController를 변경해주세요
    func makeUIViewController(context: Context) -> UIViewController {
        StartViewController()
    }

    func updateUIViewController(_ uiView: UIViewController,context: Context) {
        // leave this empty
    }
}

struct ViewController_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Preview()
            .edgesIgnoringSafeArea(.all)
            .previewDisplayName("Preview")
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))

        Preview()
            .edgesIgnoringSafeArea(.all)
            .previewDisplayName("Preview")
            .previewDevice(PreviewDevice(rawValue: "iPhoneX"))

    }
}
#endif
