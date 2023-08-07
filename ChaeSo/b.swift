import UIKit
import SnapKit
import RxSwift
import RxCocoa

class UserCell: UITableViewCell, UITextViewDelegate {
    var viewModel: ContentViewModel? {
        didSet {
            bindViewModel()
        }
    }
    private var disposeBag = DisposeBag()
    private let nicknameLabel = UILabel()
    private let ageLabel = UILabel()
    private let contentTextView = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(ageLabel)
        contentView.addSubview(contentTextView)
        
        // Layout and other UI setup code here ...
        
        contentTextView.isEditable = false
        contentTextView.delegate = self
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        disposeBag = DisposeBag()
        
        nicknameLabel.text = viewModel.nickname
        ageLabel.text = "\(viewModel.age)"
        
        viewModel.displayText
            .bind(to: contentTextView.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.showMoreOrLess
            .map { $0 == "더보기" ? "... \($0)" : $0 }
            .subscribe(onNext: { [weak self] moreOrLessText in
                if moreOrLessText == "더보기" {
                    let attributedString = NSMutableAttributedString(string: self?.contentTextView.text ?? "")
                    attributedString.addAttribute(.link, value: "action://toggle", range: NSRange(location: attributedString.length - 4, length: 4))
                    self?.contentTextView.attributedText = attributedString
                } else {
                    self?.contentTextView.text = self?.viewModel?.content
                }
            })
            .disposed(by: disposeBag)
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.scheme == "action" {
            viewModel?.toggleContent.onNext(())
            return false
        }
        return true
    }
}
