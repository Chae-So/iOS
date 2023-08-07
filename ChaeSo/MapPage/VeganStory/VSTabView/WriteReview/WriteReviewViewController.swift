import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class WriteReviewViewController: UIViewController {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    var writeReviewViewModel: WriteReviewViewModel
    
    // MARK: - UI Elements
    private lazy var writeReviewLabel = UILabel()
    private lazy var backButton = UIButton()
    private let scrollView = UIScrollView()
    private lazy var firstStarButton = UIButton()
    private lazy var secondStarButton = UIButton()
    private lazy var thirdStarButton = UIButton()
    private lazy var fourthStarButton = UIButton()
    private lazy var fifthStarButton = UIButton()
    private lazy var quesFirstLabel = UILabel()
    private lazy var quesSecondLabel = UILabel()
    private lazy var quesThirdLabel = UILabel()
    private lazy var quesFourthLabel = UILabel()
    private lazy var separateFirstView = UIView()
    private lazy var separateSecondView = UIView()
    private lazy var textView = UITextView()
    private let photoAddCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
        $0.itemSize = CGSize(width: 100 * Constants.standardHeight, height: 100 * Constants.standardHeight)
        $0.minimumInteritemSpacing = 8 // 아이템 간의 최소 간격
    })
    private lazy var aloneButton = UIButton()
    private lazy var friendButton = UIButton()
    private lazy var familyButton = UIButton()
    private lazy var veganButton = UIButton()
    private lazy var lactoButton = UIButton()
    private lazy var ovoButton = UIButton()
    private lazy var polloButton = UIButton()
    private lazy var pescoButton = UIButton()
    private lazy var flexitarianButton = UIButton()
    private lazy var noneVeganButton = UIButton()
    private lazy var yesButton = UIButton()
    private lazy var noButton = UIButton()
    private lazy var viewOne = UIView()
    private lazy var viewTwo = UIView()
    private lazy var viewThree = UIView()
    private lazy var registerButton = UIButton()
    
    // MARK: - Initializers
    
    init(writeReviewViewModel: WriteReviewViewModel) {
        self.writeReviewViewModel = writeReviewViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        attribute()
        layout()
    }
    
    
    func bind(){
        
        writeReviewViewModel.titleText
            .asDriver(onErrorDriveWith: .empty())
            .drive(writeReviewLabel.rx.text)
            .disposed(by: disposeBag)
        
        writeReviewViewModel.firstText
            .asDriver(onErrorDriveWith: .empty())
            .drive(quesFirstLabel.rx.text)
            .disposed(by: disposeBag)
        
        writeReviewViewModel.secondText
            .asDriver(onErrorDriveWith: .empty())
            .drive(quesSecondLabel.rx.text)
            .disposed(by: disposeBag)
        
        writeReviewViewModel.thirdText
            .asDriver(onErrorDriveWith: .empty())
            .drive(quesThirdLabel.rx.text)
            .disposed(by: disposeBag)
        
        writeReviewViewModel.fourthText
            .asDriver(onErrorDriveWith: .empty())
            .drive(quesFourthLabel.rx.text)
            .disposed(by: disposeBag)
        
        writeReviewViewModel.placeholderText
            .asDriver(onErrorDriveWith: .empty())
            .drive(textView.rx.text)
            .disposed(by: disposeBag)
        
        textView.rx.didBeginEditing
            .subscribe(onNext: { [self] in
                textView.text = nil
                textView.textColor = .black
               })
            .disposed(by: disposeBag)
        
//        textView.rx.didEndEditing
//            .subscribe(onNext: { [self] in
//                if(textView.text == nil || textView.text == ""){
//                    textView.text = """
//                                탈퇴 사유를 남겨주세요.
//                                향후 서비스 개선을 위해 노력하겠습니다.
//                                """
//                    textView.textColor = .gray3        //다시 placeholder 글자색으로(연한색)
//
//                }}).disposed(by: disposeBag)
        
        writeReviewViewModel.aloneText
            .asDriver(onErrorDriveWith: .empty())
            .drive(aloneButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        writeReviewViewModel.friendText
            .asDriver(onErrorDriveWith: .empty())
            .drive(friendButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        writeReviewViewModel.familyText
            .asDriver(onErrorDriveWith: .empty())
            .drive(familyButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        writeReviewViewModel.veganText
            .asDriver(onErrorDriveWith: .empty())
            .drive(veganButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        writeReviewViewModel.lactoText
            .asDriver(onErrorDriveWith: .empty())
            .drive(lactoButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        writeReviewViewModel.ovoText
            .asDriver(onErrorDriveWith: .empty())
            .drive(ovoButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        writeReviewViewModel.polloText
            .asDriver(onErrorDriveWith: .empty())
            .drive(polloButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        writeReviewViewModel.pescoText
            .asDriver(onErrorDriveWith: .empty())
            .drive(pescoButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        writeReviewViewModel.flexitarian
            .asDriver(onErrorDriveWith: .empty())
            .drive(flexitarianButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        writeReviewViewModel.nonVeganText
            .asDriver(onErrorDriveWith: .empty())
            .drive(noneVeganButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        writeReviewViewModel.yesText
            .asDriver(onErrorDriveWith: .empty())
            .drive(yesButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        writeReviewViewModel.noText
            .asDriver(onErrorDriveWith: .empty())
            .drive(noButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        writeReviewViewModel.registerText
            .asDriver(onErrorDriveWith: .empty())
            .drive(registerButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        


        writeReviewViewModel.selectedPhotosRelay
            .map { [UIImage(named: "tomato")!] + $0 }
            .bind(to: photoAddCollectionView.rx.items) { (collectionView, index, image) -> UICollectionViewCell in
                if index == 0 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoAddFirstCollectionViewCell", for: IndexPath(row: index, section: 0)) as! PhotoAddFirstCollectionViewCell
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoAddCollectionViewCell", for: IndexPath(row: index, section: 0)) as! PhotoAddCollectionViewCell
                    cell.photoImage.image = image
                    return cell
                }
            }
            .disposed(by: disposeBag)
            
        photoAddCollectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                switch indexPath.row{
                case 0:
                    let mainPTCollectionViewModel = MainPTCollectionViewModel(writeReviewViewModel: self.writeReviewViewModel)
                    let mainPTCollectionViewController = MainPTCollectionViewController(mainPTCollectionViewModel: mainPTCollectionViewModel)
                    mainPTCollectionViewController.modalPresentationStyle = .fullScreen
                    self.present(mainPTCollectionViewController, animated: true)
                default:
                    break

                }
            })
            .disposed(by: disposeBag)


        aloneButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let mainPTCollectionViewModel = MainPTCollectionViewModel(writeReviewViewModel: self.writeReviewViewModel)
                let mainPTCollectionViewController = MainPTCollectionViewController(mainPTCollectionViewModel: mainPTCollectionViewModel)
                mainPTCollectionViewController.modalPresentationStyle = .fullScreen
                self.present(mainPTCollectionViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        
    }

   
    
    func attribute(){
        view.backgroundColor = UIColor(hexCode: "F5F5F5")
        
        backButton.do {
            $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        }
        
        writeReviewLabel.do{
            $0.textAlignment = .center
            $0.font = UIFont(name: "Pretendard-Medium", size: 16)
        }
        
        separateFirstView.do{
            $0.backgroundColor = UIColor(hexCode: "D9D9D9")
        }
        
        separateSecondView.do{
            $0.backgroundColor = UIColor(hexCode: "D9D9D9")
        }
        
        
        quesFirstLabel.do{
            $0.textAlignment = .center
            $0.font = UIFont(name: "Pretendard-Medium", size: 16)
        }
        
        quesSecondLabel.do{
            $0.textAlignment = .center
            $0.font = UIFont(name: "Pretendard-Medium", size: 16)
        }
        
        quesThirdLabel.do{
            $0.textAlignment = .center
            $0.font = UIFont(name: "Pretendard-Medium", size: 16)
        }
        
        quesFourthLabel.do{
            $0.textAlignment = .center
            $0.font = UIFont(name: "Pretendard-Medium", size: 16)
        }
        
        firstStarButton.do{
            $0.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        secondStarButton.do{
            $0.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        thirdStarButton.do{
            $0.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        fourthStarButton.do{
            $0.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        fifthStarButton.do{
            $0.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        aloneButton.do{
            $0.adjustsImageWhenHighlighted = false
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.backgroundColor = UIColor.white
            $0.contentEdgeInsets = .init(top: 8*Constants.standardHeight, left: 16*Constants.standardWidth, bottom: 8*Constants.standardHeight, right: 16*Constants.standardWidth)
        }
        
        friendButton.do{
            $0.adjustsImageWhenHighlighted = false
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.backgroundColor = UIColor.white
            $0.contentEdgeInsets = .init(top: 8*Constants.standardHeight, left: 16*Constants.standardWidth, bottom: 8*Constants.standardHeight, right: 16*Constants.standardWidth)
        }
        
        familyButton.do{
            $0.adjustsImageWhenHighlighted = false
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.backgroundColor = UIColor.white
            $0.contentEdgeInsets = .init(top: 8*Constants.standardHeight, left: 16*Constants.standardWidth, bottom: 8*Constants.standardHeight, right: 16*Constants.standardWidth)
        }
        
        veganButton.do{
            $0.adjustsImageWhenHighlighted = false
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.backgroundColor = UIColor.white
        }
        
        lactoButton.do{
            $0.adjustsImageWhenHighlighted = false
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.backgroundColor = UIColor.white
        }
        
        ovoButton.do{
            $0.adjustsImageWhenHighlighted = false
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.backgroundColor = UIColor.white
        }
        
        polloButton.do{
            $0.adjustsImageWhenHighlighted = false
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.backgroundColor = UIColor.white
        }
        
        pescoButton.do{
            $0.adjustsImageWhenHighlighted = false
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.backgroundColor = UIColor.white
        }
        
        flexitarianButton.do{
            $0.adjustsImageWhenHighlighted = false
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.backgroundColor = UIColor.white
        }
        
        noneVeganButton.do{
            $0.adjustsImageWhenHighlighted = false
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.backgroundColor = UIColor.white
        }
        
        yesButton.do{
            $0.adjustsImageWhenHighlighted = false
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.backgroundColor = UIColor.white
        }
        
        noButton.do{
            $0.adjustsImageWhenHighlighted = false
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.setTitleColor(UIColor.black, for: .normal)
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.clear.cgColor
            $0.backgroundColor = UIColor.white
        }
        
        registerButton.do{
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
            $0.setTitleColor(UIColor(named: "prColor"), for: .normal)
            $0.setTitle("next", for: .normal)
            $0.backgroundColor = UIColor(named: "bgColor")
            $0.layer.cornerRadius = 8
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(named: "prColor")?.cgColor
        }
        
        photoAddCollectionView.do{
            $0.isPagingEnabled = false
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = UIColor(hexCode: "F5F5F5")
            $0.register(PhotoAddFirstCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoAddFirstCollectionViewCell")
            $0.register(PhotoAddFirstCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoAddFirstCollectionViewCell")
            $0.register(PhotoAddCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoAddCollectionViewCell")

        }
        
        textView.do{
            $0.backgroundColor = UIColor(hexCode: "F5F5F5")
            $0.layer.cornerRadius = 8
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(named: "gray10")?.cgColor
            $0.textColor = UIColor(named: "gray20")
            $0.font = UIFont(name: "Pretendard-Medium", size: 16)
            
        }
        
        
        
        
    }
    
    func layout(){
        [backButton,writeReviewLabel,separateFirstView,scrollView]
            .forEach { UIView in
                view.addSubview(UIView)
            }

        backButton.snp.makeConstraints { make in
            make.width.equalTo(44*Constants.standardWidth)
            make.height.equalTo(44*Constants.standardHeight)
            make.leading.equalToSuperview().offset(4*Constants.standardWidth)
            make.top.equalToSuperview().offset(47*Constants.standardHeight)
        }

        writeReviewLabel.snp.makeConstraints { make in
            //make.width.equalToSuperview()
            //make.height.equalTo(5*Constants.standardHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(59*Constants.standardHeight)
        }

        separateFirstView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(5*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(92*Constants.standardHeight)
        }

        scrollView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            //make.height.equalTo(18*Constants.standardHeight)
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(separateFirstView.snp.bottom)
        }
        
        [quesFirstLabel,firstStarButton,secondStarButton,thirdStarButton,fourthStarButton,fifthStarButton,photoAddCollectionView,textView,separateSecondView]
            .forEach { UIView in
                scrollView.addSubview(UIView)
            }

        quesFirstLabel.snp.makeConstraints { make in
            //make.width.equalToSuperview()
            //make.height.equalTo(5*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(16*Constants.standardHeight)
        }
        
        firstStarButton.snp.makeConstraints { make in
            make.width.equalTo(28*Constants.standardWidth)
            make.height.equalTo(28*Constants.standardHeight)
            make.leading.equalToSuperview().offset(24*Constants.standardWidth)
            make.top.equalTo(quesFirstLabel.snp.bottom).offset(11*Constants.standardHeight)
        }
        
        secondStarButton.snp.makeConstraints { make in
            make.width.equalTo(28*Constants.standardWidth)
            make.height.equalTo(28*Constants.standardHeight)
            make.leading.equalTo(firstStarButton.snp.trailing).offset(16*Constants.standardWidth)
            make.top.equalTo(quesFirstLabel.snp.bottom).offset(11*Constants.standardHeight)
        }
        
        thirdStarButton.snp.makeConstraints { make in
            make.width.equalTo(28*Constants.standardWidth)
            make.height.equalTo(28*Constants.standardHeight)
            make.leading.equalTo(secondStarButton.snp.trailing).offset(16*Constants.standardWidth)
            make.top.equalTo(quesFirstLabel.snp.bottom).offset(11*Constants.standardHeight)
        }
        
        fourthStarButton.snp.makeConstraints { make in
            make.width.equalTo(28*Constants.standardWidth)
            make.height.equalTo(28*Constants.standardHeight)
            make.leading.equalTo(thirdStarButton.snp.trailing).offset(16*Constants.standardWidth)
            make.top.equalTo(quesFirstLabel.snp.bottom).offset(11*Constants.standardHeight)
        }
        
        fifthStarButton.snp.makeConstraints { make in
            make.width.equalTo(28*Constants.standardWidth)
            make.height.equalTo(28*Constants.standardHeight)
            make.leading.equalTo(fourthStarButton.snp.trailing).offset(16*Constants.standardWidth)
            make.top.equalTo(quesFirstLabel.snp.bottom).offset(11*Constants.standardHeight)
        }
        
        photoAddCollectionView.snp.makeConstraints { make in
            make.width.equalTo(359*Constants.standardWidth)
            make.height.equalTo(101*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(quesFirstLabel.snp.bottom).offset(67*Constants.standardHeight)
        }
        
        textView.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(119*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(photoAddCollectionView.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        separateSecondView.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(1*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(textView.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        
        [quesSecondLabel,aloneButton,friendButton,familyButton]
            .forEach { UIView in
                viewOne.addSubview(UIView)
            }
        
        quesSecondLabel.snp.makeConstraints { make in
            //make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(19*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview()
        }
        
        aloneButton.snp.makeConstraints { make in
            //make.width.equalTo(74*Constants.standardWidth)
            //make.height.equalTo(35*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(quesSecondLabel.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        friendButton.snp.makeConstraints { make in
            //make.width.equalTo(74*Constants.standardWidth)
            //make.height.equalTo(35*Constants.standardHeight)
            make.leading.equalTo(aloneButton.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalTo(quesSecondLabel.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        familyButton.snp.makeConstraints { make in
            //make.width.equalTo(74*Constants.standardWidth)
            //make.height.equalTo(35*Constants.standardHeight)
            make.leading.equalTo(friendButton.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalTo(quesSecondLabel.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        [quesThirdLabel,veganButton,lactoButton,ovoButton,polloButton,pescoButton,flexitarianButton,noneVeganButton]
            .forEach { UIView in
                viewTwo.addSubview(UIView)
            }
        
        quesThirdLabel.snp.makeConstraints { make in
            //make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(19*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview()
        }
        
        veganButton.snp.makeConstraints { make in
            //make.width.equalTo(74*Constants.standardWidth)
            //make.height.equalTo(35*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(quesThirdLabel.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        lactoButton.snp.makeConstraints { make in
            //make.width.equalTo(74*Constants.standardWidth)
            //make.height.equalTo(35*Constants.standardHeight)
            make.leading.equalTo(veganButton.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalTo(quesThirdLabel.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        ovoButton.snp.makeConstraints { make in
            //make.width.equalTo(74*Constants.standardWidth)
            //make.height.equalTo(35*Constants.standardHeight)
            make.leading.equalTo(lactoButton.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalTo(quesThirdLabel.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        pescoButton.snp.makeConstraints { make in
            //make.width.equalTo(74*Constants.standardWidth)
            //make.height.equalTo(35*Constants.standardHeight)
            make.leading.equalTo(ovoButton.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalTo(quesThirdLabel.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        polloButton.snp.makeConstraints { make in
            //make.width.equalTo(74*Constants.standardWidth)
            //make.height.equalTo(35*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(veganButton.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        flexitarianButton.snp.makeConstraints { make in
            //make.width.equalTo(74*Constants.standardWidth)
            //make.height.equalTo(35*Constants.standardHeight)
            make.leading.equalTo(polloButton.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalTo(veganButton.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        noneVeganButton.snp.makeConstraints { make in
            //make.width.equalTo(74*Constants.standardWidth)
            //make.height.equalTo(35*Constants.standardHeight)
            make.leading.equalTo(flexitarianButton.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalTo(veganButton.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        [quesFourthLabel,yesButton,noButton]
            .forEach { UIView in
                viewThree.addSubview(UIView)
            }
        
        quesFourthLabel.snp.makeConstraints { make in
            //make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(19*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview()
        }
        
        yesButton.snp.makeConstraints { make in
            //make.width.equalTo(74*Constants.standardWidth)
            //make.height.equalTo(35*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(quesFourthLabel.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        noButton.snp.makeConstraints { make in
            //make.width.equalTo(74*Constants.standardWidth)
            //make.height.equalTo(35*Constants.standardHeight)
            make.leading.equalTo(yesButton.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalTo(quesFourthLabel.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        
        [viewOne,viewTwo,viewThree,registerButton]
            .forEach { UIView in
                scrollView.addSubview(UIView)
            }
        
        viewOne.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(94*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalTo(separateSecondView).offset(19*Constants.standardHeight)
        }
        
        viewTwo.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(137*Constants.standardHeight)
            make.leading.equalTo(view.snp.trailing)
            make.top.equalTo(viewOne.snp.bottom)
        }
        
        viewThree.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(70*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalTo(viewOne.snp.bottom)
        }
        
        registerButton.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardWidth)
            make.height.equalTo(56*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.bottom.equalToSuperview().offset(-35*Constants.standardHeight)
        }
        
       
        
        

    }
}




#if DEBUG
import SwiftUI
struct Preview: UIViewControllerRepresentable {

    // 여기 ViewController를 변경해주세요
    func makeUIViewController(context: Context) -> UIViewController {
        WriteReviewViewController(writeReviewViewModel: WriteReviewViewModel(localizationManager: LocalizationManager.shared))
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

        Preview()
            .edgesIgnoringSafeArea(.all)
            .previewDisplayName("Preview")
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))

        Preview()
            .edgesIgnoringSafeArea(.all)
            .previewDisplayName("Preview")
            .previewDevice(PreviewDevice(rawValue: "iPad (9th generation)"))
    }
}
#endif
