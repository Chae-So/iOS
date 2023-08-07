import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit
import Then

class CommentViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var commentViewModel: CommentViewModel
    
    let topView = UIView()
    let commentTableView = UITableView()
    
    init(commentViewModel: CommentViewModel) {
        self.commentViewModel = commentViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind()
        layout()
        attribute()
        
        
    }
    
    func bind(){
        commentTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        let dataSource = RxTableViewSectionedReloadDataSource<CommentSectionModel>(
            configureCell: { (dataSource, tableView, indexPath, reply) -> UITableViewCell in
                print(reply)
                let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
                cell.userImageView.image = reply.user.profileImage
                cell.nicknameLabel.text = reply.user.nickname
                cell.commentLabel.text = reply.content
                return cell
            }
        )
        
        commentViewModel.comments
            .observeOn(MainScheduler.instance)
            .map { comments in
                let sections = comments.map { CommentSectionModel(model: $0, items: $0.isExpanded ? $0.replies : []) }
                
                sections.forEach {
                    print("Section items count: \($0.items.count)")
                }
                return sections
            }
            .bind(to: commentTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    
    func layout(){
        [topView,commentTableView]
            .forEach { UIView in
                view.addSubview(UIView)
            }
        
        topView.snp.makeConstraints { make in
            make.width.equalTo(60*Constants.standardHeight)
            make.height.equalTo(5*Constants.standardHeight)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10*Constants.standardHeight)
        }
        
        commentTableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(600*Constants.standardHeight)
            make.leading.equalToSuperview()
            make.top.equalTo(topView.snp.bottom).offset(10*Constants.standardHeight)
        }
        
    }
    
    func attribute(){
        
        topView.do{
            $0.backgroundColor = UIColor(named: "gray10")
            $0.layer.cornerRadius = $0.bounds.height / 2
        }
        
        commentTableView.do{
            $0.separatorStyle = .singleLine
            $0.separatorColor = .yellow
            $0.register(CommentHeaderView.self, forHeaderFooterViewReuseIdentifier: "CommentHeaderView")
            $0.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentTableViewCell")
        }
        
    }
    
}

typealias CommentSectionModel = SectionModel<Comment, Reply>

extension CommentViewController: UITableViewDelegate{
    
   
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CommentHeaderView") as? CommentHeaderView else { return nil }
        let headerDisposeBag = DisposeBag()
        let comment = commentViewModel.comments.value[section]
        headerView.userImageView.image = comment.user.profileImage
        headerView.nicknameLabel.text = comment.user.nickname
        headerView.commentLabel.text = comment.content
        
        headerView.writeRepliesButton.setTitle("답글달기", for: .normal)
        
        // replies의 개수에 따라서 답글 보기 버튼의 텍스트를 설정
        let repliesText = commentViewModel.localizationManager.localizedString(forKey: "View replies", arguments: comment.replies.count)
        headerView.showRepliesButton.setTitle(repliesText, for: .normal)
        
        //        //replies View replies(1)
//        myPageviewModel.myChaesoText
//            .asDriver(onErrorDriveWith: .empty())
//            .drive(myChaesoLabel.rx.text)
//            .disposed(by: disposeBag)
        
        headerView.showRepliesButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.commentViewModel.toggleSection(section: section)
            })
            .disposed(by: headerDisposeBag)
        headerView.disposeBag = headerDisposeBag
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 90.0
        }
    
    
}
