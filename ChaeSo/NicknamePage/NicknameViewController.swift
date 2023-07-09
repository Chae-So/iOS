import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NicknameViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var nicknameViewModel: NicknameViewModel!
    
    private lazy var imageButton = UIButton()
    private lazy var nicknameLabel = UILabel()
    private lazy var nicknameTextField = UITextField()
    private lazy var isValidNkFirstLabel = UILabel()
    private lazy var isValidNkSecondLabel = UILabel()
    private lazy var nextButton = UIButton()
    
    init(nicknameViewModel: NicknameViewModel!) {
        super.init(nibName: nil, bundle: nil)
        self.nicknameViewModel = nicknameViewModel
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
        nicknameViewModel.NkText
            .asDriver(onErrorDriveWith: .empty())
            .drive(nicknameLabel.rx.text)
            .disposed(by: disposeBag)
        
        nicknameViewModel.NkValidFirstText
            .asDriver(onErrorDriveWith: .empty())
            .drive(isValidNkFirstLabel.rx.text)
            .disposed(by: disposeBag)
        
        nicknameViewModel.NkValidSecondText
            .asDriver(onErrorDriveWith: .empty())
            .drive(isValidNkSecondLabel.rx.text)
            .disposed(by: disposeBag)
        
        nicknameTextField.rx.text.orEmpty
            .bind(to: nicknameViewModel.NkInput)
            .disposed(by: disposeBag)
        
        imageButton.rx.tap
            .subscribe(onNext: {print(123)})
        
        nicknameViewModel.nkLengthValid
            .asDriver(onErrorDriveWith: .empty())
            .map { $0 ? UIColor(named: "prColor") : UIColor(hexCode: "FD4321") }
            .drive(isValidNkFirstLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        nicknameViewModel.allValid
            .asDriver(onErrorDriveWith: .empty())
            .map { $0 ? UIColor(named: "prColor")! : UIColor(hexCode: "FD4321") }
            .drive(nicknameTextField.rx.borderColor)
            .disposed(by: disposeBag)
        
        nicknameViewModel.allValid
            .asDriver(onErrorDriveWith: .empty())
            .drive(nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        nicknameViewModel.allValid
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor(named: "prColor") : UIColor(named: "bgColor") }
            .drive(nextButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        nicknameViewModel.allValid
            .asDriver(onErrorJustReturn: false)
            .map { $0 ? UIColor.white : UIColor(named: "prColor")! }
            .drive(nextButton.rx.titleColor(for: .normal))
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let veganViewModel = VeganViewModel(localizationManager: LocalizationManager.shared)
                let veganViewController = VeganViewController(veganViewModel: veganViewModel)
                self.navigationController?.pushViewController(veganViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        
    }
    
    func attribute(){
        //MARK: 바탕색
        self.view.backgroundColor = UIColor(named: "bgColor")
        
        //MARK: imageButton Attribute
        imageButton.setImage(UIImage(named: "userImage"), for: .normal)
        imageButton.adjustsImageWhenHighlighted = false
        
        //MARK: nicknameLabel attribute
        nicknameLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        nicknameLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        
        //MARK: nicknameTextField attribute
        nicknameTextField.alpha = 0.56
        nicknameTextField.layer.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1).cgColor
        nicknameTextField.layer.cornerRadius = 8
        nicknameTextField.layer.borderWidth = 1
        nicknameTextField.layer.borderColor = UIColor.clear.cgColor
        nicknameTextField.addLeftPadding()
        
        
        //MARK: isValidNkFirstLabel attribute
        isValidNkFirstLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        isValidNkFirstLabel.textColor = UIColor(named: "gray20")
        
        //MARK: isValidNkSecondLabel attribute
        isValidNkSecondLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        isValidNkSecondLabel.textColor = UIColor(named: "gray20")
        
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
        [imageButton,nicknameLabel,nicknameTextField,isValidNkFirstLabel,isValidNkSecondLabel,nextButton]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        imageButton.snp.makeConstraints { make in
            make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(100*Constants.standardHeight)
            make.leading.equalToSuperview().offset(138*Constants.standardWidth)
            make.top.equalToSuperview().offset(160*Constants.standardHeight)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.height.equalTo(17*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(296*Constants.standardHeight)
        }

        nicknameTextField.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(56*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        isValidNkFirstLabel.snp.makeConstraints { make in
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        isValidNkSecondLabel.snp.makeConstraints { make in
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(isValidNkFirstLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        nextButton.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(57*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(720*Constants.standardHeight)
        }
    }

}
