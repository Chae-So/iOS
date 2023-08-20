import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import ImageSlideshow

class ReviewTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    
    private let userImage = UIImageView()
    private let userName = UILabel()
    private let setButton = UIButton()
    private let starButton = UIButton()
    private let userTypeButton = UIButton()
    private let withTypeButton = UIButton()
    private let otherTypeButton = UIButton()
    private let imageSlideShow = ImageSlideshow()
    private let contentLabel = UILabel()
    

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
            $0.setImage(UIImage(named: "starFill"), for: .normal)
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 13)
            $0.layer.cornerRadius = 4 * Constants.standardHeight
            $0.contentEdgeInsets = UIEdgeInsets(top: 4*Constants.standardHeight, left: 8*Constants.standardWidth, bottom: 4*Constants.standardHeight, right: 8*Constants.standardWidth)
        }
        
        [userTypeButton,withTypeButton,otherTypeButton].forEach{
            $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 13)
            $0.layer.cornerRadius = 4 * Constants.standardHeight
            $0.contentEdgeInsets = UIEdgeInsets(top: 4*Constants.standardHeight, left: 8*Constants.standardWidth, bottom: 4*Constants.standardHeight, right: 8*Constants.standardWidth)
        }
        
        otherTypeButton.isHidden = true
        
        imageSlideShow.do{
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = UIColor(named: "prColor")
            pageIndicator.pageIndicatorTintColor = UIColor(named: "gray10")
            $0.pageIndicator = pageIndicator
            $0.isUserInteractionEnabled = true
        }
        
        contentLabel.do{
            $0.font = UIFont(name: "Pretendard-Medium", size: 16)
        }
        
        
    }
    
    func layout(){
        [userImage,userName,setButton,starButton,userTypeButton,withTypeButton]
            .forEach { UIView in
                contentView.addSubview(UIView)
            }
        
        starImageView.snp.makeConstraints { make in
            make.width.equalTo(28*Constants.standardWidth)
            make.height.equalTo(28*Constants.standardHeight)
            make.leading.equalToSuperview().offset(25*Constants.standardWidth)
            make.top.equalToSuperview().offset(14*Constants.standardHeight)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.width.equalTo(50*Constants.standardWidth)
            make.height.equalTo(19*Constants.standardHeight)
            make.leading.equalToSuperview().offset(61*Constants.standardWidth)
            make.top.equalToSuperview().offset(18*Constants.standardHeight)
        }
        
        fiveLabel.snp.makeConstraints { make in
            make.width.equalTo(10*Constants.standardWidth)
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalToSuperview().offset(35*Constants.standardWidth)
            make.top.equalToSuperview().offset(57*Constants.standardHeight)
        }
        
        fourLabel.snp.makeConstraints { make in
            make.width.equalTo(10*Constants.standardWidth)
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalToSuperview().offset(34*Constants.standardWidth)
            make.top.equalTo(fiveLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        threeLabel.snp.makeConstraints { make in
            make.width.equalTo(10*Constants.standardWidth)
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalToSuperview().offset(34*Constants.standardWidth)
            make.top.equalTo(fourLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        twoLabel.snp.makeConstraints { make in
            make.width.equalTo(10*Constants.standardWidth)
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalToSuperview().offset(34*Constants.standardWidth)
            make.top.equalTo(threeLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        oneLabel.snp.makeConstraints { make in
            make.width.equalTo(10*Constants.standardWidth)
            make.height.equalTo(16*Constants.standardHeight)
            make.leading.equalToSuperview().offset(34*Constants.standardWidth)
            make.top.equalTo(twoLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        firstGaugeView.snp.makeConstraints { make in
            make.width.equalTo(298*Constants.standardWidth)
            make.height.equalTo(10*Constants.standardHeight)
            make.leading.equalToSuperview().offset(61*Constants.standardWidth)
            make.top.equalToSuperview().offset(60*Constants.standardHeight)
        }
        
        secondGaugeView.snp.makeConstraints { make in
            make.width.equalTo(298*Constants.standardWidth)
            make.height.equalTo(10*Constants.standardHeight)
            make.leading.equalToSuperview().offset(61*Constants.standardWidth)
            make.top.equalTo(firstGaugeView.snp.bottom).offset(14*Constants.standardHeight)
        }
        
        thirdGaugeView.snp.makeConstraints { make in
            make.width.equalTo(298*Constants.standardWidth)
            make.height.equalTo(10*Constants.standardHeight)
            make.leading.equalToSuperview().offset(61*Constants.standardWidth)
            make.top.equalTo(secondGaugeView.snp.bottom).offset(14*Constants.standardHeight)
        }
        
        fourthGaugeView.snp.makeConstraints { make in
            make.width.equalTo(298*Constants.standardWidth)
            make.height.equalTo(10*Constants.standardHeight)
            make.leading.equalToSuperview().offset(61*Constants.standardWidth)
            make.top.equalTo(thirdGaugeView.snp.bottom).offset(14*Constants.standardHeight)
        }
        
        fifthGaugeView.snp.makeConstraints { make in
            make.width.equalTo(298*Constants.standardWidth)
            make.height.equalTo(10*Constants.standardHeight)
            make.leading.equalToSuperview().offset(61*Constants.standardWidth)
            make.top.equalTo(fourthGaugeView.snp.bottom).offset(14*Constants.standardHeight)
        }
        
        writeReviewButton.snp.makeConstraints { make in
            make.width.equalTo(120*Constants.standardWidth)
            //make.height.equalTo(35*Constants.standardHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(fifthGaugeView.snp.bottom).offset(20*Constants.standardHeight)
            make.bottom.equalToSuperview().offset(-17*Constants.standardHeight)
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






