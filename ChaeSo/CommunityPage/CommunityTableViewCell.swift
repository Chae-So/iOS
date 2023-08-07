import UIKit
import RxSwift
import RxCocoa
import ImageSlideshow
import SnapKit
import Then

class CommunityTableViewCell: UITableViewCell {
    let disposeBag = DisposeBag()
    
    lazy var userImageView = UIImageView()
    lazy var nicknameLabel = UILabel()
    lazy var setButton = UIButton()
    lazy var imageSlide = ImageSlideshow()
    lazy var likeButton = UIButton()
    lazy var commentButton = UIButton()
    lazy var shareButton = UIButton()
    lazy var bookmarkButton = UIButton()
    lazy var likeNumLabel = UILabel()
    lazy var contentLabel = UILabel()
    lazy var moreButton = UIButton()
    lazy var commentNumLabel = UILabel()
    lazy var commentUserImageView = UIImageView()
    lazy var commentLabel = UILabel()
    var constrainedWidth = 334*Constants.standardWidth
    lazy var allText = ""
    private var aaa = false
    let isExpanded = BehaviorRelay(value: false)
    let labelLength = PublishRelay<CGFloat>()
    
    private var tapGestureRecognizer: UITapGestureRecognizer?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        
        
        layout()
        attribute()
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func setContentText(_ text: String) {
        allText = text
        
        if text.count > 50 {
            
            aaa = true
            let truncatedString = text.prefix(50) + "...더보기"
            let attributedString = NSMutableAttributedString(string: String(truncatedString))
            attributedString.addAttribute(.foregroundColor, value: UIColor(named: "gray20"), range: NSRange(location: truncatedString.count - 5, length: 5))
            contentLabel.attributedText = attributedString
            contentLabel.isUserInteractionEnabled = true
            tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(contentTapped))
            contentLabel.addGestureRecognizer(tapGestureRecognizer!)

        } else {
            contentLabel.text = text
        }
        let constraintSize = CGSize(width: constrainedWidth, height: .greatestFiniteMagnitude)
        let boundingBox = contentLabel.text!.boundingRect(with: constraintSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: contentLabel.font!], context: nil)
        let heightForLessThan50Chars = boundingBox.height
        print(heightForLessThan50Chars)
        labelLength.accept(heightForLessThan50Chars)
    }
    
    
    @objc private func contentTapped() {
        contentLabel.text = allText
        let constraintSize = CGSize(width: self.constrainedWidth, height: .greatestFiniteMagnitude)
        let boundingBoxForFullText = self.contentLabel.text!.boundingRect(with: constraintSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.contentLabel.font!], context: nil)
        let heightForMoreThan50Chars = boundingBoxForFullText.height
        print(heightForMoreThan50Chars)
        labelLength.accept(heightForMoreThan50Chars)
//        contentLabel.snp.updateConstraints { make in
//            make.width.equalTo(334*Constants.standardWidth)
//            make.height.equalTo((40+heightForMoreThan50Chars)*Constants.standardHeight)
//            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
//            make.top.equalTo(likeNumLabel.snp.bottom).offset(8*Constants.standardHeight)
//        }
//        layoutIfNeeded()
        contentLabel.removeGestureRecognizer(tapGestureRecognizer!)

    }
    
    func configureImageSlideshow(with images: [UIImage?]) {
        // nil이 아닌 UIImage 인스턴스만 추출
        let nonOptionalImages = images.compactMap { $0 }
        
        // ImageSource 배열 생성
        let imageSources = nonOptionalImages.map { ImageSource(image: $0) }
        
        // ImageSlideshow에 이미지 설정
        imageSlide.setImageInputs(imageSources)
        
        // 사용자 상호 작용 활성화
        imageSlide.isUserInteractionEnabled = true
    }

    
    func attribute(){
        backgroundColor = UIColor(named: "sbgColor")
        
        userImageView.do{
            $0.layer.cornerRadius = userImageView.bounds.height / 2
        }
        
        nicknameLabel.do{
            $0.font = UIFont(name: "Pretendard-Medium", size: 13)
        }
        
        setButton.do{
            $0.adjustsImageWhenHighlighted = false
            $0.backgroundColor = UIColor(named: "sbgColor")
            $0.setImage(UIImage(named: "set"), for: .normal)
        }
        
        imageSlide.do{
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = UIColor(named: "prColor")
            pageIndicator.pageIndicatorTintColor = UIColor(named: "gray10")
            $0.pageIndicator = pageIndicator
            $0.isUserInteractionEnabled = true
        }
        
        likeButton.do{
            $0.adjustsImageWhenHighlighted = false
            $0.backgroundColor = UIColor(named: "sbgColor")
            $0.setImage(UIImage(named: "like"), for: .normal)
        }
        
        commentButton.do{
            $0.adjustsImageWhenHighlighted = false
            $0.backgroundColor = UIColor(named: "sbgColor")
            $0.setImage(UIImage(named: "comment"), for: .normal)
        }
        
        shareButton.do{
            $0.adjustsImageWhenHighlighted = false
            $0.backgroundColor = UIColor(named: "sbgColor")
            $0.setImage(UIImage(named: "share"), for: .normal)
        }
        
        bookmarkButton.do{
            $0.adjustsImageWhenHighlighted = false
            $0.backgroundColor = UIColor(named: "sbgColor")
            $0.setImage(UIImage(named: "bookmark"), for: .normal)
        }
        
        likeNumLabel.do{
            $0.font = UIFont(name: "Pretendard-Regular", size: 10)
        }
        

        
        commentNumLabel.do{
            $0.font = UIFont(name: "Pretendard-Medium", size: 13)
        }
        
        commentUserImageView.do{
            $0.layer.cornerRadius = userImageView.bounds.height / 2
        }
        
        commentLabel.do{
            $0.font = UIFont(name: "Pretendard-Regular", size: 13)
            $0.numberOfLines = 0
        }
        
        contentLabel.do{
            $0.font = UIFont(name: "Pretendard-Regular", size: 16)
            $0.numberOfLines = 0
        }
        
        
    }
    
    func layout(){
        [userImageView,nicknameLabel,setButton,imageSlide,likeButton,commentButton,shareButton,bookmarkButton,likeNumLabel,contentLabel,commentNumLabel,commentUserImageView,commentLabel]
            .forEach { UIView in
                contentView.addSubview(UIView)
            }
        
        userImageView.snp.makeConstraints { make in
            make.width.equalTo(44*Constants.standardHeight)
            make.height.equalTo(44*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(18*Constants.standardHeight)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            //make.width.equalTo(28*Constants.standardWidth)
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalTo(userImageView.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalToSuperview().offset(32*Constants.standardHeight)
        }
        
        setButton.snp.makeConstraints { make in
            make.width.equalTo(44*Constants.standardHeight)
            make.height.equalTo(44*Constants.standardHeight)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(18*Constants.standardHeight)
        }
        
        imageSlide.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardHeight)
            make.height.equalTo(343*Constants.standardHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(userImageView.snp.bottom).offset(13*Constants.standardHeight)
        }
        
        likeButton.snp.makeConstraints { make in
            make.width.equalTo(44*Constants.standardHeight)
            make.height.equalTo(44*Constants.standardHeight)
            make.leading.equalToSuperview().offset(3*Constants.standardWidth)
            make.top.equalTo(imageSlide.snp.bottom)
        }
        
        commentButton.snp.makeConstraints { make in
            make.width.equalTo(44*Constants.standardHeight)
            make.height.equalTo(44*Constants.standardHeight)
            make.leading.equalTo(likeButton.snp.trailing)
            make.top.equalTo(imageSlide.snp.bottom)
        }
        
        bookmarkButton.snp.makeConstraints { make in
            make.width.equalTo(44*Constants.standardHeight)
            make.height.equalTo(44*Constants.standardHeight)
            make.trailing.equalToSuperview()
            make.top.equalTo(imageSlide.snp.bottom)
        }
        
        shareButton.snp.makeConstraints { make in
            make.width.equalTo(44*Constants.standardHeight)
            make.height.equalTo(44*Constants.standardHeight)
            make.trailing.equalTo(bookmarkButton.snp.leading)
            make.top.equalTo(imageSlide.snp.bottom)
        }
        
        
        
        likeNumLabel.snp.makeConstraints { make in
            //make.width.equalTo(298*Constants.standardWidth)
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalToSuperview().offset(17*Constants.standardWidth)
            make.top.equalTo(likeButton.snp.bottom)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.width.equalTo(334*Constants.standardWidth)
            //make.height.equalTo(40*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(likeNumLabel.snp.bottom).offset(8*Constants.standardHeight)
            
        }

        
        commentNumLabel.snp.makeConstraints { make in
            make.width.equalTo(100*Constants.standardWidth)
            make.height.equalTo(10*Constants.standardHeight)
            make.leading.equalToSuperview().offset(18*Constants.standardWidth)
            make.top.equalTo(contentLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        commentUserImageView.snp.makeConstraints { make in
            make.width.equalTo(32*Constants.standardWidth)
            make.height.equalTo(32*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(commentNumLabel.snp.bottom).offset(4*Constants.standardHeight)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.width.equalTo(290*Constants.standardWidth)
            make.height.equalTo(32*Constants.standardHeight)
            make.leading.equalTo(commentUserImageView.snp.trailing).offset(8*Constants.standardWidth)
            make.centerY.equalTo(commentUserImageView)
            make.bottom.equalToSuperview().offset(-30*Constants.standardHeight)
        }
        
        
    }

}






//#if DEBUG
//import SwiftUI
//
//struct TableViewCellPreview: UIViewRepresentable {
//
//    func makeUIView(context: Context) -> UITableViewCell {
//        // 여기에서 원하는 테이블뷰 셀을 생성 및 구성하십시오.
//        let cell = RatingTableViewCell()
//
//        // 추가적인 셀 구성 ...
//        return cell
//    }
//
//    func updateUIView(_ uiView: UITableViewCell, context: Context) {
//        // 셀 업데이트는 필요에 따라 구현
//    }
//}
//
//struct TableViewCellPreviewProvider: PreviewProvider {
//    static var previews: some View {
//        TableViewCellPreview()
//            .edgesIgnoringSafeArea(.all)
//            .previewDisplayName("Preview")
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
//
//        TableViewCellPreview()
//            .previewLayout(.sizeThatFits)
//            .frame(height: 253) // 셀의 높이를 설정
//    }
//}
//#endif






