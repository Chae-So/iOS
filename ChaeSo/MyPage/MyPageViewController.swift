import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

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
    private lazy var editProfileButton = UIButton()
    private lazy var nicknameLabel = UILabel()
    private lazy var separateView = UIView()
    private lazy var separateSecondView = UIView()
    
    private lazy var alertTitle = UILabel()
    private lazy var alertCancel = UILabel()
    private lazy var alertLogout = UILabel()
    
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
        
        bind()
        attribute()
        layout()
    }
    
    func bind(){
        
        myPageviewModel.titleText
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        myPageviewModel.editProfileText
            .bind(to: editProfileButton.rx.title())
            .disposed(by: disposeBag)
        
        myPageviewModel.alertTitleText
            .bind(to: alertTitle.rx.text)
            .disposed(by: disposeBag)
        
        myPageviewModel.alertCancelText
            .bind(to: alertCancel.rx.text)
            .disposed(by: disposeBag)
        
        myPageviewModel.alertLogoutText
            .bind(to: alertLogout.rx.text)
            .disposed(by: disposeBag)
        
        plusButton.rx.tap
            .bind(to: myPageviewModel.nicknameButtonTapped)
            .disposed(by: disposeBag)
        
        nicknameButton.rx.tap
            .bind(to: myPageviewModel.nicknameButtonTapped)
            .disposed(by: disposeBag)
        
        editProfileButton.rx.tap
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
        
        myPageviewModel.tabItems
            .bind(to: tableView.rx.items(cellIdentifier: "MyPageTableViewCell", cellType: MyPageTableViewCell.self)){ [weak self] (row, element, cell) in
                
                if let self = self, self.shouldShowSeparator(at: row) {
                    cell.showSeparator()
                } else {
                    cell.hideSeparator()
                }
                cell.titleLabel.text = element
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
                case 3:
                    let termsVC = TermsViewController(termsViewModel: TermsViewModel(localizationManager: LocalizationManager.shared))
                    self.navigationController?.pushViewController(termsVC, animated: true)
                case 4:
                    let languageSetViewController = LanguageSetViewController(languageSetViewModel: LanguageSetViewModel(localizationManager: LocalizationManager.shared))
                    self.navigationController?.pushViewController(languageSetViewController, animated: true)
                case 5:
                    self.showAlert(title: self.alertTitle.text!, cancel: self.alertCancel.text!, logout: self.alertLogout.text!)
                case 6:
                    let withdrawVC = WithdrawViewController(withdrawViewModel: WithdrawViewModel(localizationManager: LocalizationManager.shared))
                    self.navigationController?.pushViewController(withdrawVC, animated: true)
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
        return index == 1 || index == 4
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

    private func showAlert(title: String, cancel: String, logout: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: cancel, style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        let confirmAction = UIAlertAction(title: logout, style: .destructive, handler: nil)
        
        alertController.rx.action(of: confirmAction)
            .subscribe(onNext: { [weak self] _ in
                self?.myPageviewModel.logoutButtonTapped.onNext(())
            })
            .disposed(by: disposeBag)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func attribute(){
        view.backgroundColor = .white
        
        titleLabel.font = UIFont(name: "Pretendard-Medium", size: 16*Constants.standartFont)
        
        leftButton.do{
            $0.setImage(UIImage(named: "left"), for: .normal)
            $0.isHidden = true
        }
                
        [separateView,separateSecondView]
            .forEach{ $0.backgroundColor = UIColor(hexCode: "D9D9D9") }

        
        //Todo: 닉네임 이미지 실제 유저 이미지로 교체
        nicknameButton.do{
            $0.setImage(UIImage(named: "userImage"), for: .normal)
            $0.clipsToBounds = true
            $0.layer.borderColor = UIColor(named: "gray10")?.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 60*Constants.standardHeight / 2
        }

        plusButton.do{
            $0.setImage(UIImage(named: "plusButton"), for: .normal)
            $0.backgroundColor = UIColor(named: "gray10")
            $0.layer.cornerRadius = 9*Constants.standardHeight
        }
        
        nicknameLabel.font = UIFont(name: "Pretendard-SemiBold", size: 20*Constants.standartFont)
        //ToDo: 닉네임 실제걸로 변경
        nicknameLabel.text = "씩씩한 시금치님"
        
        editProfileButton.do{
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 13)
            $0.setTitleColor(UIColor(named: "gray20"), for: .normal)
            $0.setUnderline()
        }
        
        tableView.do{
            $0.tableFooterView = UIView()
            $0.isScrollEnabled = false
            $0.separatorStyle = .singleLine
            $0.separatorInset = UIEdgeInsets(top: 0, left: 20*Constants.standardWidth, bottom: 0, right: 20*Constants.standardWidth)
            $0.separatorColor = UIColor(hexCode: "D9D9D9")
            $0.register(MyPageTableViewCell.self, forCellReuseIdentifier: "MyPageTableViewCell")
        }
        
    }
    
    func layout(){
        [titleLabel,leftButton,separateView,nicknameButton,plusButton,nicknameLabel,editProfileButton,separateSecondView,tableView,bookmarkView]
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
            make.width.equalTo(60*Constants.standardHeight)
            make.height.equalTo(60*Constants.standardHeight)
            make.leading.equalToSuperview().offset(20*Constants.standardWidth)
            make.top.equalToSuperview().offset(104*Constants.standardHeight)
        }
        
        plusButton.snp.makeConstraints { make in
            make.width.equalTo(18*Constants.standardHeight)
            make.height.equalTo(18*Constants.standardHeight)
            make.leading.equalTo(nicknameButton.snp.leading).offset(42*Constants.standardWidth)
            make.top.equalTo(nicknameButton.snp.top).offset(42*Constants.standardHeight)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(94*Constants.standardWidth)
            make.top.equalToSuperview().offset(122*Constants.standardHeight)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.width.equalTo(70*Constants.standardWidth)
            make.height.equalTo(22*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(nicknameButton.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        separateSecondView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(5*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalTo(editProfileButton.snp.bottom).offset(16*Constants.standardHeight)
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
