import UIKit
import RxSwift
import RxCocoa
import RxDataSources
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
        $0.minimumInteritemSpacing = 0
        $0.minimumLineSpacing = 16
    })
    private let photoAddCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
        $0.itemSize = CGSize(width: 100 * Constants.standardHeight, height: 100 * Constants.standardHeight)
    })
    private let firstCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
    })
    private let secondCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.scrollDirection = .vertical
        $0.minimumInteritemSpacing = 15
    })
    private let thirdCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
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
        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        bind()
        attribute()
        layout()
    }
    
    
    func bind(){
        
        backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                print(564596045)
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        textView.rx.didBeginEditing
            .subscribe(onNext: { [self] in
                textView.text = nil
                textView.textColor = .black
               })
            .disposed(by: disposeBag)
        
        writeReviewViewModel.selectedStar
            .asObservable()
            .map { selected in
                return Array(0..<5).map { $0 < selected }
            }
            .bind(to: starCollectionView.rx.items(cellIdentifier: "StarCollectionViewCell", cellType: StarCollectionViewCell.self)) { row, isFilled, cell in
                cell.configure(isFilled: isFilled)
            }
            .disposed(by: disposeBag)
        
        starCollectionView.rx.itemSelected
            .map { $0.row }
            .bind(onNext: writeReviewViewModel.didSelectStar(at:))
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
        
        //MARK: firstCollectionView
        firstCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        writeReviewViewModel.firstItems
            .bind(to: firstCollectionView.rx.items(cellIdentifier: "ButtonCollectionViewCell", cellType: ButtonCollectionViewCell.self)) { row, element, cell in
                cell.tabButton.setTitle(element, for: .normal)
            }
            .disposed(by: disposeBag)
        
        writeReviewViewModel.firstSelectedIndexPath
                .bind(to: firstCollectionView.rx.updateSelectedCellBorderColor)
                .disposed(by: disposeBag)
        
        firstCollectionView.rx.itemSelected
            .bind(to: writeReviewViewModel.firstSelectedIndexPath)
            .disposed(by: disposeBag)
        
        firstCollectionView.rx.itemSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                switch indexPath.row {
                case 0:
                    self.slideViewTwoIn()
                default:
                    self.slideViewTwoOut()
                }
            })
            .disposed(by: disposeBag)
        
        //MARK: secondCollectionView
        secondCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        writeReviewViewModel.secondItems
            .bind(to: secondCollectionView.rx.items(cellIdentifier: "ButtonCollectionViewCell", cellType: ButtonCollectionViewCell.self)) { row, element, cell in
                cell.tabButton.setTitle(element, for: .normal)
            }
            .disposed(by: disposeBag)
        
        writeReviewViewModel.secondSelectedIndexPath
                .bind(to: secondCollectionView.rx.updateSelectedCellBorderColor)
                .disposed(by: disposeBag)
        
        secondCollectionView.rx.itemSelected
            .bind(to: writeReviewViewModel.secondSelectedIndexPath)
            .disposed(by: disposeBag)

        //MARK: thirdCollectionView
        thirdCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        writeReviewViewModel.thirdItems
            .bind(to: thirdCollectionView.rx.items(cellIdentifier: "ButtonCollectionViewCell", cellType: ButtonCollectionViewCell.self)) { row, element, cell in
                cell.tabButton.setTitle(element, for: .normal)
            }
            .disposed(by: disposeBag)
        
        writeReviewViewModel.thirdSelectedIndexPath
                .bind(to: thirdCollectionView.rx.updateSelectedCellBorderColor)
                .disposed(by: disposeBag)
        
        thirdCollectionView.rx.itemSelected
            .bind(to: writeReviewViewModel.thirdSelectedIndexPath)
            .disposed(by: disposeBag)
        
        
        
    }

   
    
    func attribute(){
        view.backgroundColor = UIColor(hexCode: "F5F5F5")
        
        scrollView.do{
            $0.isScrollEnabled = true
            $0.contentSize = CGSize(width: self.view.frame.width, height: 800 * Constants.standardHeight)

        }
        
        backButton.do {
            $0.setImage(UIImage(systemName: "xmark"), for: .normal)
            $0.tintColor = .black
        }
        
        writeReviewLabel.do{
            $0.textAlignment = .center
            $0.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.text = writeReviewViewModel.titleText
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
            $0.text = writeReviewViewModel.firstText
        }
        
        quesSecondLabel.do{
            $0.textAlignment = .center
            $0.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.text = writeReviewViewModel.secondText
        }
        
        quesThirdLabel.do{
            $0.textAlignment = .center
            $0.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.text = writeReviewViewModel.thirdText
        }
        
        quesFourthLabel.do{
            $0.textAlignment = .center
            $0.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.text = writeReviewViewModel.fourthText
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
            $0.text = writeReviewViewModel.placeholderText
        }
        
        [firstCollectionView,secondCollectionView,thirdCollectionView].forEach{
            $0.backgroundColor = UIColor(hexCode: "F5F5F5")
            $0.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: "ButtonCollectionViewCell")
        }
        
        
        registerButton.do{
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
            $0.setTitleColor(UIColor(named: "prColor"), for: .normal)
            $0.setTitle("next", for: .normal)
            $0.backgroundColor = UIColor(hexCode: "F5F5F5")
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
            //make.width.equalTo(150*Constants.standardWidth)
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
            make.height.equalTo(740*Constants.standardHeight)
            make.leading.equalToSuperview()
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
            make.width.equalTo(300*Constants.standardWidth)
            make.height.equalTo(50*Constants.standardHeight)
            make.leading.equalToSuperview().offset(24*Constants.standardWidth)
            make.top.equalTo(quesFirstLabel.snp.bottom)
        }
        
        
        photoAddCollectionView.snp.makeConstraints { make in
            make.width.equalTo(359*Constants.standardWidth)
            make.height.equalTo(101*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(starCollectionView.snp.bottom)
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
        
        [quesSecondLabel,firstCollectionView]
            .forEach { UIView in
                viewOne.addSubview(UIView)
            }
        
        quesSecondLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview()
        }
        
        firstCollectionView.snp.makeConstraints { make in
            make.width.equalTo(359*Constants.standardWidth)
            make.height.equalTo(35*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(quesSecondLabel.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        [quesThirdLabel,secondCollectionView]
            .forEach { UIView in
                viewTwo.addSubview(UIView)
            }
        
        quesThirdLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview()
        }
        
        secondCollectionView.snp.makeConstraints { make in
            make.width.equalTo(300*Constants.standardWidth)
            make.height.equalTo(80*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(quesThirdLabel.snp.bottom).offset(16*Constants.standardHeight)
        }
        
        [quesFourthLabel,thirdCollectionView]
            .forEach { UIView in
                viewThree.addSubview(UIView)
            }
        
        quesFourthLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview()
        }
        
        thirdCollectionView.snp.makeConstraints { make in
            make.width.equalTo(359*Constants.standardWidth)
            make.height.equalTo(35*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
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
            make.top.equalTo(viewThree.snp.bottom).offset(50*Constants.standardHeight)
        }
        
    }
    
    private func slideViewTwoIn() {
        UIView.animate(withDuration: 0.5) { [self] in
            self.viewTwo.transform = CGAffineTransform(translationX: -self.viewTwo.bounds.width, y: 0)
            self.viewThree.transform = CGAffineTransform(translationX: 0, y: self.viewTwo.bounds.height)
            self.registerButton.transform = CGAffineTransform(translationX: 0, y: self.viewTwo.bounds.height)
            self.view.layoutIfNeeded()
        }
    }

    private func slideViewTwoOut() {
        UIView.animate(withDuration: 0.5){ [self] in
            self.viewTwo.transform = CGAffineTransform(translationX: self.viewTwo.bounds.width, y: 0)
            self.viewThree.transform = CGAffineTransform(translationX: 0, y: 0)
            self.registerButton.transform = CGAffineTransform(translationX: 0, y: 0)
            self.view.layoutIfNeeded()
        }
    }
    
}

extension WriteReviewViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var items = writeReviewViewModel.firstItems.value
        if collectionView == firstCollectionView {
            items = writeReviewViewModel.firstItems.value
        } else if collectionView == secondCollectionView {
            items = writeReviewViewModel.secondItems.value
        } else if collectionView == thirdCollectionView{
            items = writeReviewViewModel.thirdItems.value
        } else {
            return CGSize(width: 0, height: 0)
        }
        guard indexPath.item < items.count else {
            return CGSize(width: 0, height: 0)
        }
        
        let text = items[indexPath.item]
        let font = UIFont(name: "Pretendard-Medium", size: 16)
        
        let textSize = text.size(withAttributes: [NSAttributedString.Key.font: font])
        
        let width = textSize.width + 16 * 2 * Constants.standardWidth  // 좌우 패딩
        let height = textSize.height + 8 * 2 * Constants.standardHeight // 상하 패딩
        
        return CGSize(width: width, height: height-2)
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
