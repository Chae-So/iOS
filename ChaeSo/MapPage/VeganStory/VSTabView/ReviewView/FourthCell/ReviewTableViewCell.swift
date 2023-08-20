import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import ImageSlideshow

class ReviewTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    
    let userImage = UIImageView()
    let userName = UILabel()
    let setButton = UIButton()
    let starButton = UIButton()
    let userTypeButton = UIButton()
    let withTypeButton = UIButton()
    let otherTypeButton = UIButton()
    let imageSlideShow = ImageSlideshow()
    let contentLabel = UILabel()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor(hexCode: "F5F5F5")
        
        
        attribute()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func configure(with reviewList: ReviewList){
        userImage.image = reviewList.userImage
        userName.text = reviewList.userName
        starButton.setTitle(reviewList.starPoint, for: .normal)
        userTypeButton.setTitle(reviewList.userType, for: .normal)
        withTypeButton.setTitle(reviewList.withType, for: .normal)
        otherTypeButton.setTitle(reviewList.otherType, for: .normal)
        if reviewList.otherType == ""{
            otherTypeButton.isHidden = true
        }
        configureImageSlideshow(with: reviewList.reviewImages)
        contentLabel.text = reviewList.content
        
    }
    
    func configureImageSlideshow(with images: [UIImage?]) {
        // nil이 아닌 UIImage 인스턴스만 추출
        let nonOptionalImages = images.compactMap { $0 }
        
        // ImageSource 배열 생성
        let imageSources = nonOptionalImages.map { ImageSource(image: $0) }
        
        // ImageSlideshow에 이미지 설정
        imageSlideShow.setImageInputs(imageSources)
        
        // 사용자 상호 작용 활성화
        imageSlideShow.isUserInteractionEnabled = true
    }
    
    func attribute(){
        
        userImage.do{
            $0.sizeToFit()
            $0.layer.cornerRadius = $0.frame.size.height / 2
        }
        
        userName.do{
            $0.font = UIFont(name: "Pretendard-Medium", size: 13)
        }
        
        setButton.do{
            $0.setImage(UIImage(named: "set"), for: .normal)
            $0.backgroundColor = UIColor(named: "sbgColor")
        }
        
        starButton.do{
            $0.isEnabled = false
            $0.setImage(UIImage(named: "starFill"), for: .normal)
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 13)
            $0.layer.cornerRadius = 4 * Constants.standardHeight
            $0.backgroundColor = .white
            $0.setTitleColor(.black, for: .normal)
            $0.contentEdgeInsets = UIEdgeInsets(top: 4*Constants.standardHeight, left: 8*Constants.standardWidth, bottom: 4*Constants.standardHeight, right: 8*Constants.standardWidth)
        }
        
        [userTypeButton,withTypeButton,otherTypeButton].forEach{
            $0.isEnabled = false
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 13)
            $0.layer.cornerRadius = 4 * Constants.standardHeight
            $0.backgroundColor = .white
            $0.setTitleColor(.black, for: .normal)
            $0.contentEdgeInsets = UIEdgeInsets(top: 4*Constants.standardHeight, left: 8*Constants.standardWidth, bottom: 4*Constants.standardHeight, right: 8*Constants.standardWidth)
        }
        
        
        imageSlideShow.do{
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = UIColor(named: "prColor")
            pageIndicator.pageIndicatorTintColor = UIColor(named: "gray10")
            $0.pageIndicator = pageIndicator
            $0.isUserInteractionEnabled = true
        }
        
        contentLabel.do{
            $0.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.numberOfLines = 0
        }
        
        
    }
    
    func layout(){
        [userImage,userName,setButton,starButton,userTypeButton,withTypeButton,otherTypeButton,imageSlideShow,contentLabel]
            .forEach { UIView in
                contentView.addSubview(UIView)
            }
        
        userImage.snp.makeConstraints { make in
            make.width.equalTo(44*Constants.standardWidth)
            make.height.equalTo(44*Constants.standardHeight)
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalToSuperview().offset(17*Constants.standardHeight)
        }
        
        userName.snp.makeConstraints { make in
            make.leading.equalTo(userImage.snp.trailing).offset(12*Constants.standardWidth)
            make.centerY.equalTo(userImage)
        }
        
        setButton.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.trailing.equalToSuperview().offset(-10*Constants.standardWidth)
            make.centerY.equalTo(userImage)
            
        }
        
        starButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16*Constants.standardWidth)
            make.top.equalTo(userImage.snp.bottom).offset(9*Constants.standardHeight)
        }
        
        userTypeButton.snp.makeConstraints { make in
            make.leading.equalTo(starButton.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalTo(userImage.snp.bottom).offset(9*Constants.standardHeight)
        }
        
        withTypeButton.snp.makeConstraints { make in
            make.leading.equalTo(userTypeButton.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalTo(userImage.snp.bottom).offset(9*Constants.standardHeight)
        }
        
        otherTypeButton.snp.makeConstraints { make in
            make.leading.equalTo(withTypeButton.snp.trailing).offset(8*Constants.standardWidth)
            make.top.equalTo(userImage.snp.bottom).offset(9*Constants.standardHeight)
        }
        
        imageSlideShow.snp.makeConstraints { make in
            make.width.equalTo(343*Constants.standardHeight)
            make.height.equalTo(343*Constants.standardHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(otherTypeButton.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.width.equalTo(imageSlideShow.snp.width)
            make.centerX.equalToSuperview()
            make.top.equalTo(imageSlideShow.snp.bottom).offset(24*Constants.standardHeight)
            make.bottom.equalToSuperview().offset(-19*Constants.standardHeight)
        }
        
    }

}
