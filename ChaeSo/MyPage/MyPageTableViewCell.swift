//
//  MyPageTableViewCell.swift
//  ChaeSo
//
//  Created by 박중선 on 2023/07/22.
//

import UIKit
import SnapKit

class MyPageTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let iconImageView = UIImageView()
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "D9D9D9")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        addSubview(titleLabel)
        addSubview(iconImageView)
        addSubview(separatorView)
        
        separatorView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(3)
        }
        
        titleLabel.font = UIFont(name: "Pretendard-Medium", size: 14)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showSeparator() {
        separatorView.isHidden = false
    }
    
    func hideSeparator() {
        separatorView.isHidden = true
    }
    
}
