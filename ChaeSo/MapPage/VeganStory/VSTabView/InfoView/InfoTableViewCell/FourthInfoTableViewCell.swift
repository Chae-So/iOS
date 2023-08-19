import UIKit
import SnapKit

class FourthInfoTableViewCell: UITableViewCell {
    
    private let monLabel = UILabel()
    private let tueLabel = UILabel()
    private let wedLabel = UILabel()
    private let thuLabel = UILabel()
    private let friLabel = UILabel()
    private let satLabel = UILabel()
    private let sunLabel = UILabel()
    private let monTimeLabel = UILabel()
    private let tueTimeLabel = UILabel()
    private let wedTimeLabel = UILabel()
    private let thuTimeLabel = UILabel()
    private let friTimeLabel = UILabel()
    private let satTimeLabel = UILabel()
    private let sunTimeLabel = UILabel()
    
    private lazy var dayLabels: [UILabel] = [monLabel, tueLabel, wedLabel, thuLabel, friLabel, satLabel, sunLabel]
    private lazy var timeLabels: [UILabel] = [monTimeLabel, tueTimeLabel, wedTimeLabel, thuTimeLabel, friTimeLabel, satTimeLabel, sunTimeLabel]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: ItemC) {
        let times = [model.monTime, model.tueTime, model.wedTime, model.thuTime, model.friTime, model.satTime, model.sunTime]
        
        for (index, time) in times.enumerated() {
            timeLabels[index].text = time
        }
        
        let dayIndex = Calendar.current.component(.weekday, from: Date())-2
        dayLabels[dayIndex].font = UIFont(name: "Pretendard-Bold", size: 13)
        timeLabels[dayIndex].font = UIFont(name: "Pretendard-Bold", size: 13)
    }
    
    private func bind(){
        monLabel.text = "월요일"
        tueLabel.text = "화요일"
        wedLabel.text = "수요일"
        thuLabel.text = "목요일"
        friLabel.text = "금요일"
        satLabel.text = "토요일"
        sunLabel.text = "일요일"
        
    }
    
    private func attribute(){
        [monLabel,monTimeLabel,tueLabel,tueTimeLabel,wedLabel,wedTimeLabel,thuLabel,thuTimeLabel,friLabel,friTimeLabel,satLabel,satTimeLabel,sunLabel,sunTimeLabel]
            .forEach{ $0.font = UIFont(name: "Pretendard-Regular", size: 13) }
        
    }
    
    private func layout(){
        [monLabel,monTimeLabel,tueLabel,tueTimeLabel,wedLabel,wedTimeLabel,thuLabel,thuTimeLabel,friLabel,friTimeLabel,satLabel,satTimeLabel,sunLabel,sunTimeLabel]
            .forEach { UILabel in
                contentView.addSubview(UILabel)
            }
        
        monLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50*Constants.standardWidth)
            make.top.equalToSuperview().offset(14*Constants.standardHeight)
        }
        
        tueLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50*Constants.standardWidth)
            make.top.equalTo(monLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        wedLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50*Constants.standardWidth)
            make.top.equalTo(tueLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        thuLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50*Constants.standardWidth)
            make.top.equalTo(wedLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        friLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50*Constants.standardWidth)
            make.top.equalTo(thuLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        satLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50*Constants.standardWidth)
            make.top.equalTo(friLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        sunLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50*Constants.standardWidth)
            make.top.equalTo(satLabel.snp.bottom).offset(8*Constants.standardHeight)
            make.bottom.equalToSuperview().offset(-14*Constants.standardHeight)
        }
        
        monTimeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(140*Constants.standardWidth)
            make.top.equalToSuperview().offset(14*Constants.standardHeight)
        }
        
        tueTimeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(140*Constants.standardWidth)
            make.top.equalTo(monTimeLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        wedTimeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(140*Constants.standardWidth)
            make.top.equalTo(tueTimeLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        thuTimeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(140*Constants.standardWidth)
            make.top.equalTo(wedTimeLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        friTimeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(140*Constants.standardWidth)
            make.top.equalTo(thuLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        satTimeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(140*Constants.standardWidth)
            make.top.equalTo(friLabel.snp.bottom).offset(8*Constants.standardHeight)
        }
        
        sunTimeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(140*Constants.standardWidth)
            make.top.equalTo(satLabel.snp.bottom).offset(8*Constants.standardHeight)
            make.bottom.equalToSuperview().offset(-14*Constants.standardHeight)
        }
        
    }
    
}
