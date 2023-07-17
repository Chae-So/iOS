//import UIKit
//import RxSwift
//import RxCocoa
//import SnapKit
//
//class MyPageViewController: UIViewController {
//
//    // MARK: - Properties
//
//    let disposeBag = DisposeBag()
//    var myPageviewModel: MyPageViewModel
//
//    // MARK: - UI Elements
//
//    let tableView = UITableView()
//    let separatorView = UIView()
//    let profileImageView = UIImageView()
//    let nameLabel = UILabel()
//    let emailLabel = UILabel()
//    let logoutButton = UIButton()
//
//    // MARK: - Initializers
//
//    init(myPageviewModel: MyPageViewModel) {
//        self.myPageviewModel = myPageviewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: - Life Cycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//
//
//    func bind(){
//
//    }
//
//    func attribute(){
//
//        // 네비게이션 타이틀 설정
//        self.title = "마이컬리"
//
//        // 테이블뷰 설정
//        tableView.rx.setDelegate(self).disposed(by: disposeBag) // rx를 사용하여 델리게이트 설정
//
//        // 테이블뷰 셀 등록
//        tableView.register(UserHeaderCell.self, forCellReuseIdentifier: "UserHeaderCell")
//        tableView.register(VegetableCell.self, forCellReuseIdentifier: "VegetableCell")
//        tableView.register(MyPostCell.self, forCellReuseIdentifier: "MyPostCell")
//        tableView.register(SupportCell.self, forCellReuseIdentifier: "SupportCell")
//        tableView.register(LogoutCell.self, forCellReuseIdentifier: "LogoutCell")
//
//        // 네비게이션 바 바로 밑에 검은색 구분선 추가 및 오토레이아웃 설정
//        separatorView.backgroundColor = .black
//
//
//    }
//
//    func layout(){
//        [tableView,separatorView]
//            .forEach { view.addSubview($0) }
//
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
//            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
//            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
//            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
//        }
//
//        // 스냅킷을 사용한 오토레이아웃 설정
//        separatorView.snp.makeConstraints { make in
//            make.top.equalTo(self.navigationController?.navigationBar.snp.bottom ?? self.view.snp.top)
//            make.leading.equalTo(self.view.snp.leading)
//            make.trailing.equalTo(self.view.snp.trailing)
//            make.height.equalTo(5)
//        }
//
//
//
//    }
//
//}
//
//extension MyPageViewController: UITableViewDelegate {
//    // 섹션의 개수를 반환하는 메소드
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//
//    // 섹션의 헤더 높이를 반환하는 메소드
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        switch section {
//        case 0:
//            return 0 // 첫 번째 섹션의 헤더는 검은색 구분선이므로 네비게이션 바 바로 밑에 추가했으므로 여기서는 0을 반환합니다.
//
//        case 1, 2:
//            return 33 // 나머지 섹션의 헤더는 텍스트가 있는 헤더이므로 높이는 33
//        default:
//            return 0 // 예외 처리
//        }
//    }
//
//    // 섹션의 헤더 뷰를 반환하는 메소드
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        switch section {
//        case 0:
//            let headerView = UIView()
//            headerView.backgroundColor = .black // 첫 번째 섹션의 헤더는 검은색 구분선이므로 배경색을 검은색으로 설정
//            return headerView
//        case 1:
//            let headerView = UILabel()
//            headerView.text = "나의 채소" // 두 번째 섹션의 헤더는 "나의 채소"라는 텍스트를 가지는 라벨로 설정
//            headerView.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//            headerView.textAlignment = .center
//            return headerView
//        case 2:
//            let headerView = UILabel()
//            headerView.text = "고객지원" // 세 번째 섹션의 헤더는 "고객지원"이라는 텍스트를 가지는 라벨로 설정
//            headerView.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//            headerView.textAlignment = .center
//            return headerView
//        default:
//            return nil // 예외 처리
//        }
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.section {
//        case 0:
//            switch indexPath.row {
//            case 0:
//                return UITableView.automaticDimension // 첫 번째 섹션의 첫 번째 셀은 유저 헤더 셀이므로 오토레이아웃에 맞게 높이를 자동으로 설정합니다.
//                // 수정해야 하는 부분: 유저 헤더 셀은 헤더가 아니라 셀이므로 높이를 반환하는 것이 아니라 UserHeaderCell 클래스를 정의하고 그 안에서 오토레이아웃을 설정해야 합니다.
//                // 예시:
//                /*
//                 class UserHeaderCell: UITableViewCell {
//                 let userImageView = UIImageView()
//                 let userNameLabel = UILabel()
//
//                 override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//                 super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//                 // 유저 이미지뷰 설정
//                 userImageView.contentMode = .scaleAspectFill
//                 userImageView.layer.cornerRadius = 50
//                 userImageView.clipsToBounds = true
//
//                 // 유저 이름 라벨 설정
//                 userNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//                 userNameLabel.textAlignment = .center
//
//                 // 셀에 유저 이미지뷰와 유저 이름 라벨 추가 및 오토레이아웃 설정
//                 self.contentView.addSubview(userImageView)
//                 self.contentView.addSubview(userNameLabel)
//
//                 // 스냅킷을 사용한 오토레이아웃 설정
//                 userImageView.snp.makeConstraints { make in
//                 make.centerX.equalToSuperview()
//                 make.top.equalToSuperview().offset(10)
//                 make.width.height.equalTo(100)
//                 }
//
//                 userNameLabel.snp.makeConstraints { make in
//                 make.centerX.equalToSuperview()
//                 make.top.equalTo(userImageView.snp.bottom).offset(10)
//                 make.bottom.equalToSuperview().offset(-10)
//                 make.width.equalToSuperview().multipliedBy(0.8)
//                 }
//                 }
//
//                 required init?(coder: NSCoder) {
//                 fatalError("init(coder:) has not been implemented")
//                 }
//                 }
//                 */
//            case 1:
//                return 150 // 첫 번째 섹션의 두 번째 셀은 나의 채소 셀이므로 높이는 150
//            default:
//                return 0 // 예외 처리
//            }
//        case 1:
//            switch indexPath.row {
//            case 0, 1, 2:
//                return 50 // 두 번째 섹션의 첫 번째, 두 번째, 세 번째 셀은 내가 쓴 글, 북마크, 좋아요 셀이므로 높이는 50
//            case 3:
//                return 1 // 두 번째 섹션의 네 번째 셀은 구분선 셀이므로 높이는 1
//            default:
//                return 0 // 예외 처리
//            }
//        case 2:
//            switch indexPath.row {
//            case 0, 1, 2, 3:
//                return 50 // 세 번째 섹션의 첫 번째, 두 번째, 세 번째, 네 번째 셀은 공지사항, 문의하기, 약관 및 정책, 설정 셀이므로 높이는 50
//            case 4:
//                return 1 // 세 번째 섹션의 다섯 번째 셀은 구분선 셀이므로 높이는 1
//            case 5, 6:
//                return 50 // 세 번째 섹션의 여섯 번째, 일곱 번째 셀은 로그아웃, 회원탈퇴 셀이므로 높이는 50
//            default:
//                return 0 // 예외 처리
//            }
//        default:
//            return 0 // 예외 처리
//        }
//    }
//
//    // 셀을 반환하는 메소드
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch indexPath.section {
//        case 0:
//            switch indexPath.row {
//            case 0:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "UserHeaderCell", for: indexPath) as! UserHeaderCell
//                // 유저 헤더 셀에 뷰모델의 유저 정보를 바인딩하는 코드
//                // 예시:
//                /*
//                 viewModel.user.map { $0.image }.bind(to: cell.userImageView.rx.image).disposed(by: cell.disposeBag)
//                 viewModel.user.map { $0.name }.bind(to: cell.userNameLabel.rx.text).disposed(by: cell.disposeBag)
//                 */
//                return cell
//            case 1:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "VegetableCell", for: indexPath) as! VegetableCell
//                // 나의 채소 셀에 뷰모델의 유저 정보를 바인딩하는 코드
//                // 예시:
//                /*
//                 viewModel.user.map { $0.vegetables }.bind(to: cell.collectionView.rx.items(cellIdentifier: "VegetableCollectionViewCell", cellType: VegetableCollectionViewCell.self)) { index, vegetable, cell in
//                 cell.vegetableImageView.image = vegetable.image
//                 cell.vegetableNameLabel.text = vegetable.name
//                 }.disposed(by: cell.disposeBag)
//                 */
//                return cell
//            default:
//                return UITableViewCell() // 예외 처리
//            }
//        case 1:
//            switch indexPath.row {
//            case 0, 1, 2:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "MyPostCell", for: indexPath) as! MyPostCell
//                // 내가 쓴 글, 북마크, 좋아요 셀에 뷰모델의 유저 정보를 바인딩하는 코드
//                // 예시:
//                /*
//                 switch indexPath.row {
//                 case 0:
//                 viewModel.user.map { $0.posts.count }.map { "\($0)" }.bind(to: cell.countLabel.rx.text).disposed(by: cell.disposeBag)
//                 cell.titleLabel.text = "내가 쓴 글"
//                 case 1:
//                 viewModel.user.map { $0.bookmarks.count }.map { "\($0)" }.bind(to: cell.countLabel.rx.text).disposed(by: cell.disposeBag)
//                 cell.titleLabel.text = "북마크"
//                 case 2:
//                 viewModel.user.map { $0.likes.count }.map { "\($0)" }.bind(to: cell.countLabel.rx.text).disposed(by: cell.disposeBag)
//                 cell.titleLabel.text = "좋아요"
//                 default:
//                 break
//                 }
//                 */
//                return cell
//            case 3:
//                let cell = UITableViewCell()
//                // 구분선 셀에 리딩, 트레일링 간격이 20인 구분선을 추가하는 코드
//                // 예시:
//                /*
//                 let separatorView = UIView()
//                 separatorView.backgroundColor = .lightGray
//                 cell.contentView.addSubview(separatorView)
//
//                 // 스냅킷을 사용한 오토레이아웃 설정
//                 separatorView.snp.makeConstraints { make in
//                 make.top.bottom.equalToSuperview()
//                 make.leading.equalToSuperview().offset(20)
//                 make.trailing.equalToSuperview().offset(-20)
//                 }
//                 */
//                return cell
//            default:
//                return UITableViewCell() // 예외 처리
//            }
//        case 2:
//            switch indexPath.row {
//            case 0, 1, 2, 3:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "SupportCell", for: indexPath) as! SupportCell
//                // 공지사항, 문의하기, 약관 및 정책, 설정 셀에 텍스트를 설정하는 코드
//                // 예시:
//                /*
//                 switch indexPath.row {
//                 case 0:
//                 cell.titleLabel.text = "공지사항"
//                 case 1:
//                 cell.titleLabel.text = "문의하기"
//                 case 2:
//                 cell.titleLabel.text = "약관 및 정책"
//                 case 3:
//                 cell.titleLabel.text = "설정"
//                 default:
//                 break
//                 }
//                 */
//                return cell
//            case 4:
//                let cell = UITableViewCell()
//                // 구분선 셀에 리딩, 트레일링 간격이 20인 구분선을 추가하는 코드
//                // 예시:
//                /*
//                 let separatorView = UIView()
//                 separatorView.backgroundColor = .lightGray
//                 cell.contentView.addSubview(separatorView)
//
//                 // 스냅킷을 사용한 오토레이아웃 설정
//                 separatorView.snp.makeConstraints { make in
//                 make.top.bottom.equalToSuperview()
//                 make.leading.equalToSuperview().offset(20)
//                 make.trailing.equalToSuperview().offset(-20)
//                 }
//                 */
//                return cell
//            case 5, 6:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "LogoutCell", for: indexPath) as! LogoutCell
//                // 로그아웃, 회원탈퇴 셀에 텍스트와 버튼 액션을 설정하는 코드
//                // 예시:
//                /*
//                 switch indexPath.row {
//                 case 5:
//                 cell.titleLabel.text = "로그아웃"
//                 cell.button.rx.tap.subscribe(onNext: { [weak self] in
//                 self?.viewModel.logout() // 버튼을 누르면 뷰모델의 로그아웃 메소드 호출
//                 }).disposed(by: cell.disposeBag)
//
//                 case 6:
//                 cell.titleLabel.text = "회원탈퇴"
//                 cell.button.rx.tap.subscribe(onNext: { [weak self] in
//                 self?.viewModel.withdraw() // 버튼을 누르면 뷰모델의 회원탈퇴 메소드 호출
//                 }).disposed(by: cell.disposeBag)
//
//                 default:
//                 break
//                 }
//                 */
//                return cell
//            default:
//                return UITableViewCell() // 예외 처리
//            }
//        default:
//            return UITableViewCell() // 예외 처리
//        }
//    }
//}
