import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MyPageViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Properties
    
    var disposeBag = DisposeBag()
    var myPageviewModel: MyPageViewModel
    let bookmarkView = BookmarkView(bookmarkViewModel: BookmarkViewModel(localizationManager: LocalizationManager.shared))
    
    // MARK: - UI Elements
    private lazy var titleLabel = UILabel()
    private lazy var leftButton = UIButton()
    private lazy var nicknameButton = UIButton()
    private lazy var plusButton = UIButton()
    private lazy var nicknameLabel = UILabel()
    private lazy var separateView = UIView()
    private lazy var separateSecondView = UIView()
    
    private var tableView = UITableView()
    
    // MARK: - Initializers
    
    init(myPageviewModel: MyPageViewModel) {
        self.myPageviewModel = myPageviewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        bind()
        attribute()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("마이페이지 뷰일어피어")
        myPageviewModel.titleText
            .subscribe { title in
                print(title,123123123)
            }
            .disposed(by: disposeBag)
    }
    
    
    func bind(){
        
        myPageviewModel.titleText
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        plusButton.rx.tap
            .bind(to: myPageviewModel.nicknameButtonTapped)
            .disposed(by: disposeBag)
        
        nicknameButton.rx.tap
            .bind(to: myPageviewModel.nicknameButtonTapped)
            .disposed(by: disposeBag)
        
        myPageviewModel.nicknameButtonTapped
            .subscribe(onNext: {
                let mainPTCollectionViewController = MainPTCollectionViewController(mainPTCollectionViewModel: MainPTCollectionViewModel(photoViewModelProtocol: self.myPageviewModel))
                mainPTCollectionViewController.modalPresentationStyle = .fullScreen
                mainPTCollectionViewController.type = "nickname"
                self.present(mainPTCollectionViewController, animated: true)
            })
            .disposed(by: disposeBag)
  
        myPageviewModel.selectedPhotosRelay
            .map { $0.first }
            .bind(to: nicknameButton.rx.image(for: .normal))
            .disposed(by: disposeBag)
        
        myPageviewModel.items
            .bind(to: tableView.rx.items(cellIdentifier: "MyPageTableViewCell", cellType: MyPageTableViewCell.self)){ [weak self] (row, element, cell) in
                
                if let self = self, self.shouldShowSeparator(at: row) {
                    cell.showSeparator()  // 구분뷰를 표시하는 함수
                } else {
                    cell.hideSeparator()  // 구분뷰를 숨기는 함수
                }
                
                cell.titleLabel.text = element.title
                cell.iconImageView.image = element.icon
            }
            .disposed(by: disposeBag)
        
        
        //마지막 구분선 없애는 작업
        tableView.rx.willDisplayCell
            .subscribe(onNext: { [self] (cell, indexPath) in
                if indexPath.row == (tableView.numberOfRows(inSection: indexPath.section) - 1) {
                    cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0)
                } else {
                    cell.separatorInset = UIEdgeInsets.zero
                }
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] (index) in
                guard let self = self else { return }
                let row = index.row
                switch row{
                case 1:
                    self.showBookmarkView()
                    self.leftButton.isHidden = false
                case 5:
                    let languageSetViewController = LanguageSetViewController(languageSetViewModel: LanguageSetViewModel(localizationManager: LocalizationManager.shared))
                    self.show(languageSetViewController, sender: nil)
                default:
                    break
                }
                
            })
            .disposed(by: disposeBag)
        
        leftButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.showMyPage()
                self.leftButton.isHidden = true
            })
            .disposed(by: disposeBag)
        
    }
    
    private func shouldShowSeparator(at index: Int) -> Bool {
        return index == 1 || index == 5  
    }
    
    private func showBookmarkView() {
        UIView.animate(withDuration: 0.3, animations: {
            // 테이블뷰를 왼쪽으로 슬라이드
            self.tableView.snp.remakeConstraints { make in
                make.right.equalTo(self.view.snp.left) // 이것은 테이블뷰를 왼쪽으로 완전히 슬라이드시킵니다.
                make.top.equalTo(self.separateSecondView.snp.bottom)  // 기존의 top 제약 조건
                make.bottom.equalTo(self.view)
                // 여기에 기존의 top, bottom, height 제약조건을 유지하려면 추가적인 코드가 필요합니다.
            }
            
            // BookmarkView를 화면 내로 슬라이드
            self.bookmarkView.snp.remakeConstraints { make in
                make.top.equalTo(self.separateSecondView.snp.bottom)
                make.left.equalTo(self.view)  // 화면 안쪽으로 이동
                make.width.equalTo(self.view)
                make.bottom.equalTo(self.view)
            }
            
            // 레이아웃을 즉시 업데이트
            self.view.layoutIfNeeded()

        })
    }
    
    private func showMyPage() {
        UIView.animate(withDuration: 0.3, animations: {
            // tableView를 원래 위치로 복원
            self.tableView.snp.remakeConstraints { make in
                // 원래의 tableView 제약 조건을 여기에 다시 설정하세요.
                // 예:
                make.left.right.equalTo(self.view)
                make.top.equalTo(self.separateSecondView.snp.bottom)
                make.bottom.equalTo(self.view)
                // 기타 필요한 제약 조건을 추가하세요.
            }
            
            // bookmarkView를 원래 위치로 복원
            self.bookmarkView.snp.remakeConstraints { make in
                // 원래의 bookmarkView 제약 조건을 여기에 다시 설정하세요.
                // 예:
                make.left.equalTo(self.view.snp.right) // 화면 밖으로 이동
                make.top.equalTo(self.separateSecondView.snp.bottom)
                make.width.equalTo(self.view)
                make.bottom.equalTo(self.view)
            }
            
            // 레이아웃을 즉시 업데이트
            self.view.layoutIfNeeded()
        })
    }


    
    func attribute(){
        view.backgroundColor = .white
        
        //MARK: myChaesoLabel Attribute
        titleLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        //titleLabel.text = myPageviewModel.myChaesoText
        
        leftButton.setImage(UIImage(named: "left"), for: .normal)
        leftButton.isHidden = true
        
        //MARK: separateView Attribute
        separateView.backgroundColor = UIColor(hexCode: "D9D9D9")
        
        //MARK: separateView Attribute
        separateView.backgroundColor = UIColor(hexCode: "D9D9D9")
        separateSecondView.backgroundColor = UIColor(hexCode: "D9D9D9")
        
        //MARK: nicknameButton Attribute
        //Todo: 닉네임 이미지 실제 유저 이미지로 교체
        nicknameButton.setImage(UIImage(named: "userImage"), for: .normal)
        nicknameButton.backgroundColor = .blue
        nicknameButton.clipsToBounds = true
        nicknameButton.layer.cornerRadius = 30*Constants.standardWidth
        nicknameButton.adjustsImageWhenHighlighted = false
        
        //MARK: plusButton Attribute
        plusButton.setImage(UIImage(named: "plusButton"), for: .normal)
        plusButton.backgroundColor = UIColor(named: "gray10")
        plusButton.layer.cornerRadius = 9*Constants.standardHeight //(plusButton.frame.height*Constants.standardHeight) / 2
        plusButton.adjustsImageWhenHighlighted = false
        
        //MARK: nicknameLabel Attribute
        nicknameLabel.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        //ToDo: 닉네임 실제걸로 변경
        nicknameLabel.text = "씩씩한 시금치님"
        
        
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20*Constants.standardWidth, bottom: 0, right: 20*Constants.standardWidth)
        tableView.separatorColor = UIColor(hexCode: "D9D9D9")
        tableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: "MyPageTableViewCell")
        
        
    }
    
    func layout(){
        [titleLabel,leftButton,separateView,nicknameButton,plusButton,nicknameLabel,separateSecondView,tableView,bookmarkView]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        titleLabel.snp.makeConstraints { make in
            //make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(19*Constants.standardHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(54*Constants.standardHeight)
        }
        
        leftButton.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardHeight)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(10*Constants.standardHeight)
            make.centerY.equalTo(titleLabel)
        }
        
        separateView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(5*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(84*Constants.standardHeight)
        }
        
        nicknameButton.snp.makeConstraints { make in
            make.width.equalTo(60*Constants.standardWidth)
            make.height.equalTo(60*Constants.standardHeight)
            make.leading.equalToSuperview().offset(20*Constants.standardWidth)
            make.top.equalToSuperview().offset(104*Constants.standardHeight)
        }
        
        plusButton.snp.makeConstraints { make in
            make.width.equalTo(18*Constants.standardWidth)
            make.height.equalTo(18*Constants.standardHeight)
            make.leading.equalTo(nicknameButton.snp.leading).offset(42*Constants.standardWidth)
            make.top.equalTo(nicknameButton.snp.top).offset(42*Constants.standardHeight)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            //make.width.equalTo(60*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(94*Constants.standardWidth)
            make.top.equalToSuperview().offset(122*Constants.standardHeight)
        }
        
        separateSecondView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(5*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalTo(nicknameButton.snp.bottom).offset(15*Constants.standardHeight)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(separateSecondView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        bookmarkView.snp.remakeConstraints { make in
            make.top.equalTo(separateSecondView.snp.bottom)
            make.left.equalTo(view.snp.right)  // 화면 바깥쪽
            make.width.equalTo(view)
            make.bottom.equalTo(view)
        }
        
        
    }
}




//#if DEBUG
//import SwiftUI
//struct Preview: UIViewControllerRepresentable {
//
//    // 여기 ViewController를 변경해주세요
//    func makeUIViewController(context: Context) -> UIViewController {
//        MyPageViewController(myPageviewModel: MyPageViewModel(localizationManager: LocalizationManager.shared), ptCollectionViewModel: PTCollectionViewModel())
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
