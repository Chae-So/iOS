//
//  StarCollectionViewCell.swift
//  ChaeSo
//
//  Created by 박중선 on 2023/08/13.
//

import UIKit

class StarCollectionViewCell: UICollectionViewCell {
    var starImage = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hexCode: "F5F5F5")
        attribute()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute(){
        //starImage.contentMode = .scaleAspectFit
        starImage.image = UIImage(named: "star")
    }
    
    func layout(){
        addSubview(starImage)
        starImage.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }

   
}
