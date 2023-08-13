import UIKit
import RxSwift
import RxCocoa
import SnapKit

class RatingTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    
    let writeReviewButtonTapped = PublishRelay<Void>()
    
    let starImageView = UIImageView()
    let ratingLabel = UILabel()
    let oneLabel = UILabel()
    let twoLabel = UILabel()
    let threeLabel = UILabel()
    let fourLabel = UILabel()
    let fiveLabel = UILabel()
    let firstGaugeView = UIProgressView()
    let secondGaugeView = UIProgressView()
    let thirdGaugeView = UIProgressView()
    let fourthGaugeView = UIProgressView()
    let fifthGaugeView = UIProgressView()
    let writeReviewButton = UIButton()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        writeReviewButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.writeReviewButtonTapped.accept(())
            })
            .disposed(by: disposeBag)
        
        attribute()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        disposeBag = DisposeBag()
//    }
    
    func attribute(){
        ratingLabel.text = "4.3 / 5"
        
        starImageView.image = UIImage(named: "starFill")
        
        ratingLabel.textAlignment = .center
        ratingLabel.font = UIFont(name: "Pretendard-SemiBord", size: 16)
        
        oneLabel.textAlignment = .center
        oneLabel.font = UIFont(name: "Pretendard-Regular", size: 13)
        oneLabel.text = "1"
        
        twoLabel.textAlignment = .center
        twoLabel.font = UIFont(name: "Pretendard-Regular", size: 13)
        twoLabel.text = "2"
        
        
        threeLabel.textAlignment = .center
        threeLabel.font = UIFont(name: "Pretendard-Regular", size: 13)
        threeLabel.text = "3"
        
        fourLabel.textAlignment = .center
        fourLabel.font = UIFont(name: "Pretendard-Regular", size: 13)
        fourLabel.text = "4"
        
        fiveLabel.textAlignment = .center
        fiveLabel.font = UIFont(name: "Pretendard-Regular", size: 13)
        fiveLabel.text = "5"
        
        firstGaugeView.trackTintColor = UIColor(hexCode: "D9D9D9")
        firstGaugeView.progressTintColor = UIColor(hexCode: "FFC700")
        firstGaugeView.progress = 0.2
        
        secondGaugeView.trackTintColor = UIColor(hexCode: "D9D9D9")
        secondGaugeView.progressTintColor = UIColor(hexCode: "FFC700")
        
        thirdGaugeView.trackTintColor = UIColor(hexCode: "D9D9D9")
        thirdGaugeView.progressTintColor = UIColor(hexCode: "FFC700")
        
        fourthGaugeView.trackTintColor = UIColor(hexCode: "D9D9D9")
        fourthGaugeView.progressTintColor = UIColor(hexCode: "FFC700")
        
        fifthGaugeView.trackTintColor = UIColor(hexCode: "D9D9D9")
        fifthGaugeView.progressTintColor = UIColor(hexCode: "FFC700")

        //MARK: writeReviewButton Attribute
        writeReviewButton.titleLabel?.textAlignment = .center
        writeReviewButton.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        writeReviewButton.setTitleColor(UIColor(named: "prColor"), for: .normal)
        writeReviewButton.setTitle("리뷰 작성하기", for: .normal)
        writeReviewButton.backgroundColor = .white
        writeReviewButton.layer.cornerRadius = 16
        writeReviewButton.layer.borderWidth = 1
        writeReviewButton.layer.borderColor = UIColor(named: "prColor")?.cgColor
        writeReviewButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    func layout(){
        [starImageView,ratingLabel,oneLabel,twoLabel,threeLabel,fourLabel,fiveLabel,firstGaugeView,secondGaugeView,thirdGaugeView,fourthGaugeView,fifthGaugeView,writeReviewButton]
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






