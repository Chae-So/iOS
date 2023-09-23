import UIKit
import RxSwift
import RxCocoa
import SnapKit

class FirstTourTableViewCell: UITableViewCell {
    let disposeBag = DisposeBag()
    var tourViewModel: TourViewModel?

    private let firstImageView = UIImageView()
    private let firstLabel = UILabel()
    private let secondImageView = UIImageView()
    private let secondLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(tourViewModel: TourViewModel) {
        self.tourViewModel = tourViewModel
    }

    func configure(toilet: Bool, parking: Bool) {
        firstImageView.image = toilet ? UIImage(named: "checkFill") : UIImage(named: "check")
        secondImageView.image = parking ? UIImage(named: "checkFill") : UIImage(named: "check")
        
        tourViewModel!.toiletText
            .bind(to: firstLabel.rx.text)
            .disposed(by: disposeBag)
        
        tourViewModel!.parkingText
            .bind(to: secondLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func attribute(){
        [firstLabel,secondLabel]
            .forEach{
                $0.font = UIFont(name: "Pretendard-Medium", size: 13*Constants.standartFont)
            }

        [firstImageView,secondImageView]
            .forEach{
                $0.image = UIImage(named: "check")
                $0.contentMode = .scaleAspectFit
            }
    }

    private func layout(){
        [firstImageView,firstLabel,secondImageView,secondLabel]
            .forEach { UIView in
                contentView.addSubview(UIView)
            }

        firstImageView.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(13*Constants.standardWidth)
            make.centerY.equalToSuperview()
            //make.bottom.equalToSuperview().offset(-10*Constants.standardHeight)
        }

        secondImageView.snp.makeConstraints { make in
            make.width.equalTo(24*Constants.standardWidth)
            make.height.equalTo(24*Constants.standardHeight)
            make.leading.equalToSuperview().offset(200*Constants.standardWidth)
            make.centerY.equalToSuperview()
        }


        firstLabel.snp.makeConstraints { make in
            make.leading.equalTo(firstImageView.snp.trailing).offset(8*Constants.standardWidth)
            make.centerY.equalTo(firstImageView)
        }

        secondLabel.snp.makeConstraints { make in
            make.leading.equalTo(secondImageView.snp.trailing).offset(8*Constants.standardWidth)
            make.centerY.equalTo(firstImageView)
        }


    }

}
