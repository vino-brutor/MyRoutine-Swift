//
//  CollectionViewCell.swift
//  MinhaRotina
//
//  Created by Vítor Bruno on 02/06/25.
//

import UIKit

class CollectionViewCellTaskTIme: UICollectionViewCell {
    
    static let reuseIdentifier = "CollectionViewCellTaskTIme"
    var onTimeChanged: ((Date) -> Void)?
    
    lazy var hourPicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.date = Date()
        datePicker.addTarget(self, action: #selector(timeChanged(_:)), for: .valueChanged)
        datePicker.locale = Locale(identifier: "pt_BR")
        datePicker.setValue(UIColor(.cardLavanda), forKey: "textColor")
        return datePicker
    }()
    
    @objc func timeChanged(_ sender: UIDatePicker) {
        onTimeChanged?(sender.date)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setUptConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionViewCellTaskTIme: ViewCodeProtocol {
    func addSubViews() {
        contentView.addSubview(hourPicker)
    }
    
    func setUptConstraints() {
        NSLayoutConstraint.activate([
            hourPicker.topAnchor.constraint(equalTo: topAnchor),
            hourPicker.leadingAnchor.constraint(equalTo: leadingAnchor),
            hourPicker.trailingAnchor.constraint(equalTo: trailingAnchor),
            hourPicker.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
}
