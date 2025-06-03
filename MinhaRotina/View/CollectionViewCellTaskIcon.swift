//
//  CollectionViewCellTaskIcon.swift
//  MinhaRotina
//
//  Created by Vítor Bruno on 02/06/25.
//

import UIKit

class CollectionViewCellTaskIcon: UICollectionViewCell {
    
    static let reuseIdentifier = "CollectionViewCellTaskIcon"
    
    lazy var imageICon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.heightAnchor.constraint(equalToConstant: 24).isActive = true
        image.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return image
    }()
    
    lazy var labelIcon: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "SFPro", size: 16)
        return label
    }()
    
    lazy var stackViewImagelabelIcon: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageICon, labelIcon])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        stackView.spacing = 12
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setUptConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with icon: Icons){
        labelIcon.text = icon.name
        labelIcon.textColor = icon.isSelected ? .white : .selectedLavanda
        imageICon.tintColor = icon.isSelected ? .white : .selectedLavanda
        imageICon.image = icon.icon
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = icon.isSelected ? .selectedLavanda : .backgroundLavanda
        contentView.layer.borderColor = icon.isSelected ? UIColor.selectedLavanda.cgColor : UIColor.white.cgColor
        contentView.layer.borderWidth = 4
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = icon.isSelected ? 0.15 : 0.0
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 4
    }
    
}

extension CollectionViewCellTaskIcon: ViewCodeProtocol {
    func addSubViews() {
        contentView.addSubview(stackViewImagelabelIcon)
    }
    
    func setUptConstraints() {
        NSLayoutConstraint.activate([
            stackViewImagelabelIcon.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackViewImagelabelIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackViewImagelabelIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackViewImagelabelIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    
}
