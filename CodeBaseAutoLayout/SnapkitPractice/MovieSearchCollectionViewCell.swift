//
//  MovieSearchCollectionViewCell.swift
//  CodeBaseAutoLayout
//
//  Created by 이빈 on 1/13/25.
//

import UIKit
import SnapKit

class MovieSearchCollectionViewCell: UICollectionViewCell {
    
    let rankView = {
        let rankView = UIView()
        rankView.backgroundColor = .white
        return rankView
    }()
    
    let rankLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let movieNameLabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let mainView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setAutoLayout()
        
        // movieNameLabel의 huggingPriority를 낮춰서 늘어날 수 있도록 하고
        // dateLabel의 compressionResistancePriority를 높여서 Intrinsic Content Size를 항상 갖도록
        // 2가지 제약 조건만 걸면, 레이아웃이 원했던 대로 안 잡힙니다..
        // 2가지만 걸어줘도 상대적으로 값이 높아지거나 낮아져서 잘 잡혀야 하는 것 아닌가요?! 왜 다 설정해줘야 하는지 모르겠습니다..!
        movieNameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        movieNameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        dateLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ item: Movie) {
        rankLabel.text = item.rank
        movieNameLabel.text = item.movieNm
        dateLabel.text = item.openDt
    }
    
    func setUI() {
        rankView.addSubview(rankLabel)
        
        [
            rankView,
            movieNameLabel,
            dateLabel
        ].forEach { contentView.addSubview($0) }
    
    }
    
    func setAutoLayout() {

        rankView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(30)
        }
        
        rankLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        movieNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(rankView.snp.trailing).offset(15)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(dateLabel.snp.leading).offset(-10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
    }
    
}
