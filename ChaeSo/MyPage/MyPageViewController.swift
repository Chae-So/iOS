import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MyPageViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    var myPageviewModel: MyPageViewModel
    var ptCollectionViewModel: PTCollectionViewModel
    
    // MARK: - UI Elements
    
    private lazy var myChaesoLabel = UILabel()
    private lazy var nicknameButton = UIButton()
    private lazy var plusButton = UIButton()
    private lazy var nicknameLabel = UILabel()
    private lazy var postNumberLabel = UILabel()
    private lazy var followingNumberLabel = UILabel()
    private lazy var followerNumberLabel = UILabel()
    private lazy var postLabel = UILabel()
    private lazy var followingLabel = UILabel()
    private lazy var followerLabel = UILabel()
    private lazy var separateView = UIView()
    private lazy var separateSecondView = UIView()
    
    private var tableView = UITableView()
    
    // MARK: - Initializers
    
    init(myPageviewModel: MyPageViewModel, ptCollectionViewModel: PTCollectionViewModel) {
        self.myPageviewModel = myPageviewModel
        self.ptCollectionViewModel = ptCollectionViewModel
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
        myPageviewModel.myChaesoText
            .asDriver(onErrorDriveWith: .empty())
            .drive(myChaesoLabel.rx.text)
            .disposed(by: disposeBag)
        
        myPageviewModel.postText
            .asDriver(onErrorDriveWith: .empty())
            .drive(postLabel.rx.text)
            .disposed(by: disposeBag)
        
        myPageviewModel.followingText
            .asDriver(onErrorDriveWith: .empty())
            .drive(followingLabel.rx.text)
            .disposed(by: disposeBag)
        
        myPageviewModel.followerText
            .asDriver(onErrorDriveWith: .empty())
            .drive(followerLabel.rx.text)
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
        
        tableView.rx.willDisplayCell
            .subscribe(onNext: { [self] (cell, indexPath) in
                if indexPath.row == (tableView.numberOfRows(inSection: indexPath.section) - 1) {
                    cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0)
                } else {
                    cell.separatorInset = UIEdgeInsets.zero
                }
            })
            .disposed(by: disposeBag)
        
        

        
    }
    
    private func shouldShowSeparator(at index: Int) -> Bool {
        return index == 2 || index == 6  // "좋아요"와 "설정" 셀 바로 아래에 구분뷰가 옵니다.
    }
  

    
    func attribute(){
        
        //MARK: myChaesoLabel Attribute
        myChaesoLabel.font = UIFont(name: "Pretendard-Medium", size: 16)
        
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
        
        //MARK: post,following,followerNumberLabel Attribute
        //ToDo: 숫자 실제걸로 변경
        postNumberLabel.font = UIFont(name: "Pretendard-Bold", size: 13)
        postNumberLabel.text = "20"
        followingNumberLabel.font = UIFont(name: "Pretendard-Bold", size: 13)
        followingNumberLabel.text = "80"
        followerNumberLabel.font = UIFont(name: "Pretendard-Bold", size: 13)
        followerNumberLabel.text = "100"
        
        //MARK: post,following,followerLabel Attribute
        postLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        followingLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        followerLabel.font = UIFont(name: "Pretendard-Medium", size: 13)
        
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20*Constants.standardWidth, bottom: 0, right: 20*Constants.standardWidth)
        tableView.separatorColor = UIColor(hexCode: "D9D9D9")
        tableView.register(MyPageTableViewCell.self, forCellReuseIdentifier: "MyPageTableViewCell")
        
        
    }
    
    func layout(){
        [myChaesoLabel,separateView,nicknameButton,plusButton,nicknameLabel,separateSecondView,postNumberLabel,followingNumberLabel,followerNumberLabel,postLabel,followingLabel,followerLabel,tableView]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        myChaesoLabel.snp.makeConstraints { make in
            //make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(19*Constants.standardHeight)
            make.leading.equalToSuperview().offset(20*Constants.standardWidth)
            make.top.equalToSuperview().offset(54*Constants.standardHeight)
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
        
        postNumberLabel.snp.makeConstraints { make in
            //make.width.equalTo(17*Constants.standardWidth)
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalToSuperview().offset(55*Constants.standardWidth)
            make.top.equalToSuperview().offset(188*Constants.standardHeight)
        }
        
        postLabel.snp.makeConstraints { make in
            //make.width.equalTo(34*Constants.standardWidth)
            make.height.equalTo(16*Constants.standardHeight)
            make.centerX.equalTo(postNumberLabel.snp.centerX)
            make.top.equalTo(postNumberLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        followingNumberLabel.snp.makeConstraints { make in
            //make.width.equalTo(17*Constants.standardWidth)
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalTo(postNumberLabel.snp.trailing).offset(107*Constants.standardWidth)
            make.top.equalToSuperview().offset(188*Constants.standardHeight)
        }
        
        followingLabel.snp.makeConstraints { make in
            //make.width.equalTo(34*Constants.standardWidth)
            make.height.equalTo(16*Constants.standardHeight)
            make.centerX.equalTo(followingNumberLabel.snp.centerX)
            make.top.equalTo(followingNumberLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        followerNumberLabel.snp.makeConstraints { make in
            //make.width.equalTo(17*Constants.standardWidth)
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalTo(followingNumberLabel.snp.trailing).offset(107*Constants.standardWidth)
            make.top.equalToSuperview().offset(188*Constants.standardHeight)
        }
        
        followerLabel.snp.makeConstraints { make in
            //make.width.equalTo(34*Constants.standardWidth)
            make.height.equalTo(16*Constants.standardHeight)
            make.centerX.equalTo(followerNumberLabel.snp.centerX)
            make.top.equalTo(followerNumberLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        separateSecondView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(5*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(244*Constants.standardHeight)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(separateSecondView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
    }
}




#if DEBUG
import SwiftUI
struct Preview: UIViewControllerRepresentable {

    // 여기 ViewController를 변경해주세요
    func makeUIViewController(context: Context) -> UIViewController {
        MyPageViewController(myPageviewModel: MyPageViewModel(localizationManager: LocalizationManager.shared), ptCollectionViewModel: PTCollectionViewModel())
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
