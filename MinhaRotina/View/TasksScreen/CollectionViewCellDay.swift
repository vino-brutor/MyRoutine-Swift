//
//  CollectionViewCellDay.swift
//  MinhaRotina
//
//  Created by Vítor Bruno on 28/05/25.
//
import UIKit

class CollectionViewCellDay: UICollectionViewCell {
    
    static let identifier = "CollectionViewCellDay"
    
    lazy var labelDayOfTheWeek: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "SFProRounded-Bold", size: 34)
        return label
    }()
    
    func config(with day: Day){
        labelDayOfTheWeek.text = day.name
        contentView.backgroundColor = day.isSelected ? .selectedLavanda : .cardLavanda
        contentView.layer.borderWidth = day.isSelected ? 2 : 0
        contentView.layer.borderColor = UIColor.white.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .cardLavanda
        contentView.layer.cornerRadius = 16
        addSubViews()
        setUptConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionViewCellDay: ViewCodeProtocol {
    
    func setUptConstraints() {
        NSLayoutConstraint.activate([
            labelDayOfTheWeek.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelDayOfTheWeek.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            labelDayOfTheWeek.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            labelDayOfTheWeek.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ])
    }
    
    func addSubViews(){
        contentView.addSubview(labelDayOfTheWeek)
    }
}
