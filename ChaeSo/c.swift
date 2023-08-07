import UIKit
import RxSwift
import RxCocoa

class UserViewController: UIViewController {
    private let tableView = UITableView()
    private let viewModel = UserListViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindTableView()
    }
    
    private func setupUI() {
        tableView.backgroundColor = .gray
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.register(UserCell.self, forCellReuseIdentifier: "UserCell")
    }
    
    private func bindTableView() {
        viewModel.users
            .bind(to: tableView.rx.items(cellIdentifier: "UserCell", cellType: UserCell.self)) { row, user, cell in
                let cellViewModel = ContentViewModel(user: user)
                cell.viewModel = cellViewModel
            }
            .disposed(by: disposeBag)
    }
}
