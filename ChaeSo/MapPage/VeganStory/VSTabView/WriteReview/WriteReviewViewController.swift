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
    private lazy var quesFirstLabel = UILabel()
    private lazy var quesSecondLabel = UILabel()
    private lazy var quesThirdLabel = UILabel()
    private lazy var quesFourthLabel = UILabel()
    private lazy var separateFirstView = UIView()
    private lazy var separateSecondView = UIView()
    private lazy var textView = UITextView()
    private let starCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
        $0.itemSize = CGSize(width: 28 * Constants.standardHeight, height: 28 * Constants.standardHeight)
        $0.minimumInteritemSpacing = 16 // 아이템 간의 최소 간격
    })
    private let photoAddCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
        $0.itemSize = CGSize(width: 100 * Constants.standardHeight, height: 100 * Constants.standardHeight)
        $0.minimumInteritemSpacing = 8 // 아이템 간의 최소 간격
    })

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
            .subscribe(onNext: { [weak self] aaa in
                guard let self = self else { return }
                switch aaa.row{
                case 0:
                    let mainPTCollectionViewController = MainPTCollectionViewController(mainPTCollectionViewModel: MainPTCollectionViewModel(photoViewModelProtocol: self.writeReviewViewModel))
                    mainPTCollectionViewController.modalPresentationStyle = .fullScreen
                    self.present(mainPTCollectionViewController, animated: true)
                default:
                    break
                }
                
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
        
        
        [quesFirstLabel,quesSecondLabel,quesThirdLabel,quesFourthLabel].forEach{
            $0.textAlignment = .center
            $0.font = UIFont(name: "Pretendard-Medium", size: 16)
        }
        
        starCollectionView.do{
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = UIColor(hexCode: "F5F5F5")
            $0.register(StarCollectionViewCell.self, forCellWithReuseIdentifier: "StarCollectionViewCell")
        }
        
        photoAddCollectionView.do{
            $0.isPagingEnabled = false
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = UIColor(hexCode: "F5F5F5")
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
        
        [quesFirstLabel,starCollectionView,photoAddCollectionView,textView,separateSecondView]
            .forEach { UIView in
                scrollView.addSubview(UIView)
            }

        quesFirstLabel.snp.makeConstraints { make in
            //make.width.equalToSuperview()
            //make.height.equalTo(5*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(16*Constants.standardHeight)
        }
        
        starCollectionView.snp.makeConstraints { make in
            make.width.equalTo(359*Constants.standardWidth)
            make.height.equalTo(101*Constants.standardHeight)
            make.leading.equalToSuperview().offset(24*Constants.standardWidth)
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




//#if DEBUG
//import SwiftUI
//struct Preview: UIViewControllerRepresentable {
//
//    // 여기 ViewController를 변경해주세요
//    func makeUIViewController(context: Context) -> UIViewController {
//        WriteReviewViewController(writeReviewViewModel: WriteReviewViewModel(localizationManager: LocalizationManager.shared))
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
//        Preview()
//            .edgesIgnoringSafeArea(.all)
//            .previewDisplayName("Preview")
//            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
//
//        Preview()
//            .edgesIgnoringSafeArea(.all)
//            .previewDisplayName("Preview")
//            .previewDevice(PreviewDevice(rawValue: "iPad (9th generation)"))
//    }
//}
//#endif
