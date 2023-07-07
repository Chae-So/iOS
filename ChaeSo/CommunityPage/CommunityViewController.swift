import UIKit
import RxSwift
import RxCocoa
import SnapKit

class CommunityViewController: UIViewController {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    let viewModel: CommunityViewModel
    
    // MARK: - UI Elements
    
    let tableView = UITableView()
    
    // MARK: - Initializers
    
    init(viewModel: CommunityViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        // Set up the table view
        //        view.addSubview(tableView)
        //        tableView.snp.makeConstraints { make in
        //            make.edges.equalToSuperview()
        //        }
        //
        //        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //
        //        // Bind the posts to the table view
        //        viewModel.posts
        //            .drive(tableView.rx.items(cellIdentifier: "cell")) { row, post, cell in
        //                cell.textLabel?.text = post.title
        //            }
        //            .disposed(by: disposeBag)
        //
        //        // Bind the selected post to the view model
        //        tableView.rx.modelSelected(Post.self)
        //            .bind(to: viewModel.selectedPost)
        //            .disposed(by: disposeBag)
        //
        //        // Navigate to the post detail view controller when selected
        //        viewModel.selectedPost
        //            .compactMap { $0 }
        //            .subscribe(onNext: { [weak self] post in
        //                guard let self = self else { return }
        //                let postDetailVC = PostDetailViewController(viewModel: PostDetailViewModel(model: PostDetailModel(post: post)))
        //                self.navigationController?.pushViewController(postDetailVC, animated: true)
        //            })
        //            .disposed(by: disposeBag)
        //
        //        // Fetch the posts from the view model
        //        viewModel.fetchPosts()
        //    }
        
    }
}
