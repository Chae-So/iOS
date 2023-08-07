import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import RxDataSources
import ImageSlideshow

class CommunityViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let communityViewModel: CommunityViewModel
    
    private let chaesoLogLabel = UILabel()
    private lazy var tabCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal
        
        // 컬렉션뷰의 폭을 반으로 나누어서 itemSize를 설정
        let halfWidth = UIScreen.main.bounds.width * 0.5
        $0.itemSize = CGSize(width: halfWidth, height: 45 * Constants.standardHeight) // 여기서 높이는 원하는 높이로 설정
        
        $0.minimumInteritemSpacing = 0 // 아이템 간의 최소 간격
    })
    private let leftActiveTabIndicator = UIView().then{
        $0.backgroundColor = UIColor(named: "prColor")
    }
    private let rightActiveTabIndicator = UIView().then{
        $0.backgroundColor = UIColor(named: "gray10")
    }
    private let contentsTableView = UITableView()
    var length = 0
    var aa = ""
    var labelHeights: [IndexPath: CGFloat] = [:]

    
    
    init(communityViewModel: CommunityViewModel) {
        self.communityViewModel = communityViewModel
        super.init(nibName: nil, bundle: nil)
        attribute()
        layout()
        bind()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(){
        communityViewModel.chaesoLogText
            .asDriver(onErrorDriveWith: .empty())
            .drive(chaesoLogLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        
        communityViewModel.tabItems
            .bind(to: tabCollectionView.rx.items(cellIdentifier: "BookmarkTabCell", cellType: BookmarkTabCell.self)) { row, element, cell in
                cell.titleLabel.text = element
            }
            .disposed(by: disposeBag)
        
        
        tabCollectionView.rx.itemSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                switch indexPath.row {
                case 0:
                    self.leftActiveTabIndicator.backgroundColor = UIColor(named: "prColor")
                    self.rightActiveTabIndicator.backgroundColor = UIColor(named: "gray10")
                    
                case 1:
                    self.leftActiveTabIndicator.backgroundColor = UIColor(named: "gray10")
                    self.rightActiveTabIndicator.backgroundColor = UIColor(named: "prColor")
                    
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        communityViewModel.chaesoLog
            .drive(contentsTableView.rx.items(cellIdentifier: "CommunityTableViewCell", cellType: CommunityTableViewCell.self)){ [weak self] (row, element, cell) in
                
                guard let self = self else {return}
                
                cell.userImageView.image = element.userImage
                cell.nicknameLabel.text = element.nickname
                cell.configureImageSlideshow(with: element.imagesArr)

                cell.likeNumLabel.text = "좋아요 \(element.likeNum)개"
                //cell.contentsLabel.text = element.contents
                cell.setContentText(element.contents)
                cell.commentNumLabel.text = "댓글 \(element.commentNum)개 모두 보기"
                cell.commentUserImageView.image = element.commentImage
                cell.commentLabel.text = element.comment
                print(row)
                
                
                cell.labelLength
                    .subscribe(onNext: { [weak self] height in
                        guard let self = self else { return }
                        self.labelHeights[IndexPath(row: row, section: 0)] = 580 + height
                        //self.contentsTableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
                        self.contentsTableView.beginUpdates()
                        
                        self.contentsTableView.endUpdates()
                    })
                    .disposed(by: self.disposeBag)

                cell.commentButton.rx.tap
                    .subscribe(onNext: {
                        let a = CommentViewController(commentViewModel: CommentViewModel(localizationManager: LocalizationManager.shared))
                        //a.modalPresentationStyle = .
                        self.present(a, animated: true)
                    })
                    .disposed(by: self.disposeBag)
                
                
            }
            .disposed(by: disposeBag)
        
        contentsTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    
    func attribute(){
        view.backgroundColor = UIColor(hexCode: "F5F5F5")
        
        tabCollectionView.do{
            $0.showsHorizontalScrollIndicator = false
            $0.register(BookmarkTabCell.self, forCellWithReuseIdentifier: "BookmarkTabCell")
        }
        
        contentsTableView.do{
            $0.separatorStyle = .singleLine
            $0.separatorInset = UIEdgeInsets(top: 0, left: 20*Constants.standardWidth, bottom: 0, right: 20*Constants.standardWidth)
            $0.separatorColor = UIColor(hexCode: "D9D9D9")
            //$0.estimatedRowHeight = 620
            //$0.rowHeight = UITableView.automaticDimension
            
            $0.register(CommunityTableViewCell.self, forCellReuseIdentifier: "CommunityTableViewCell")
        }
        
        
    }
    
    func layout(){
        [chaesoLogLabel,tabCollectionView,leftActiveTabIndicator,rightActiveTabIndicator,contentsTableView]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        chaesoLogLabel.snp.makeConstraints { make in
            //make.width.equalToSuperview()
            make.height.equalTo(19*Constants.standardHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(54*Constants.standardHeight)
        }
        
        tabCollectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(45*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalTo(chaesoLogLabel.snp.bottom).offset(5*Constants.standardHeight)
        }
        
        leftActiveTabIndicator.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(5*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalTo(tabCollectionView.snp.bottom)
        }
        
        rightActiveTabIndicator.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(5*Constants.standardHeight)
            make.trailing.equalToSuperview()
            make.top.equalTo(tabCollectionView.snp.bottom)
        }
        
        contentsTableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.top.equalTo(leftActiveTabIndicator.snp.bottom)
        }
        
    }
    
}


extension CommunityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //print("labelHeights[indexPath] ?? 0",labelHeights[indexPath] ?? 0,indexPath.row)
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return labelHeights[indexPath] ?? UITableView.automaticDimension
//    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 580
//    }
    
}




//#if DEBUG
//import SwiftUI
//struct Preview: UIViewControllerRepresentable {
//
//    // 여기 ViewController를 변경해주세요
//    func makeUIViewController(context: Context) -> UIViewController {
//        CommunityViewController(communityViewModel: CommunityViewModel(localizationManager: LocalizationManager.shared))
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
