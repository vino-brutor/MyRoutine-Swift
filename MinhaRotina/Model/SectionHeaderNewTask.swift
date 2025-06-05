//
//  CollectionReusableView.swift
//  MinhaRotina
//
//  Created by Vítor Bruno on 02/06/25.
//

import UIKit

class SectionHeaderNewTask: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeaderNewTask"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .titleLavanda
        
        return label
    }()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            addSubViews()
            setUptConstraints()
    }

    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
}

extension SectionHeaderNewTask: ViewCodeProtocol {
    func addSubViews() {
        addSubview(titleLabel)
    }
    
    func setUptConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
}
