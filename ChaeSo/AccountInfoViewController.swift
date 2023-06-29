import UIKit
import SnapKit
import RxCocoa
import RxSwift

class AccountInfoViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    var viewModel: AccountInfoViewModel!
    
    private lazy var imageView = UIImageView()
    private lazy var whiteView = UIView()
    private let idLabel = UILabel()
    private lazy var idTextField = UITextField()
    private lazy var isValidIdLabel = UILabel()
    private let pwLabel = UILabel()
    private lazy var pwTextField = UITextField()
    private lazy var isValidPwLabel = UILabel()
    private lazy var pwConfirmTextField = UITextField()
    private lazy var isValidPwConfirmLabel = UILabel()
    
    private let orLabel = UILabel()
    private let appleLoginButton = UIButton()
    private let cacaoLoginButton = UIButton()
    
    private let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        bind()
        attribute()
        layout()
    }
    
    
    func bind(){
        
        idTextField.rx.text.orEmpty
            .bind(to: viewModel.idInput)
            .disposed(by: disposeBag)
        
        pwTextField.rx.text.orEmpty
            .bind(to: viewModel.pwInput)
            .disposed(by: disposeBag)
        
        pwConfirmTextField.rx.text.orEmpty
            .bind(to: viewModel.pwConfirmInput)
            .disposed(by: disposeBag)
        
        viewModel.idValid.asDriver(onErrorJustReturn: false)
            .map { $0 ? "" : "조건에 맞지 않는 형식입니다." }
            .drive(isValidIdLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.idValid.asDriver(onErrorJustReturn: false)
            .map { $0 ? .black : .red }
            .drive(isValidIdLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        viewModel.pwValid.asDriver(onErrorJustReturn: false)
            .map { $0 ? "" : "조건에 맞지 않는 형식입니다." }
            .drive(isValidPwLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.pwValid.asDriver(onErrorJustReturn: false)
            .map { $0 ? .black : .red }
            .drive(isValidPwLabel.rx.textColor)
            .disposed(by: disposeBag)
        viewModel.pwConfirmValid.asDriver(onErrorJustReturn: false)
            .map { $0 ? "" : "비밀번호가 다릅니다." }
            .drive(isValidPwConfirmLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.pwConfirmValid.asDriver(onErrorJustReturn: false)
            .map { $0 ? .black : .red }
            .drive(isValidPwConfirmLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        // Bind view model output to button state
        viewModel.allValid.asDriver(onErrorJustReturn: false)
            .drive(nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        // Bind view model output to button background color and border color
        viewModel.allValid.asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor.green : UIColor.clear }
            .drive(nextButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        viewModel.allValid.asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor.green.cgColor : UIColor.green.cgColor }
            .drive(nextButton.rx.layerBorderColor)
            .disposed(by: disposeBag)
        
        
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
        idLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        idLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        idLabel.textAlignment = .center
        idLabel.text = "E-mail"
        
        
        //MARK: emailTextField attribute
        idTextField.alpha = 0.56
        idTextField.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
        idTextField.layer.cornerRadius = 8
        idTextField.addLeftPadding()
        idTextField.placeholder = "이메일을 입력해 주세요."
        idTextField.keyboardType = .emailAddress
        
        //MARK: passwordLabel attribute
        pwLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        pwLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        pwLabel.text = "password"
        
        
        //MARK: passwordTextField attribute
        pwTextField.alpha = 0.56
        pwTextField.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
        pwTextField.layer.cornerRadius = 8
        pwTextField.addLeftPadding()
        pwTextField.placeholder = "비밀번호를 입력해 주세요."
        
        //MARK: rePasswordTextField attribute
        pwTextField.alpha = 0.56
        pwTextField.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
        pwTextField.layer.cornerRadius = 8
        pwTextField.addLeftPadding()
        pwTextField.placeholder = "비밀번호를 다시 입력해 주세요."
        
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
        
        [whiteView,idLabel,idTextField,pwLabel,pwTextField,pwConfirmTextField,orLabel,appleLoginButton,cacaoLoginButton,nextButton]
            .forEach {
                view.addSubview($0)
            }
        
        whiteView.snp.makeConstraints { make in
            make.width.equalTo(375)
            make.height.equalTo(565)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        idLabel.snp.makeConstraints { make in
            make.width.equalTo(46)
            make.height.equalTo(19)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(271)
        }

        idTextField.snp.makeConstraints { make in
            make.width.equalTo(343)
            make.height.equalTo(56)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(306)
        }
        pwLabel.snp.makeConstraints { make in
            make.width.equalTo(72)
            make.height.equalTo(19)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(386)
        }
        
    }
}

extension Reactive where Base: UIButton {
    // Bindable sink for layer border color
    var layerBorderColor: Binder<CGColor> {
        return Binder(self.base) { button, color in
            button.layer.borderColor = color
        }
    }
}
