//
//  CollectionViewCellNewTaskInputs.swift
//  MinhaRotina
//
//  Created by Vítor Bruno on 30/05/25.
//

import UIKit

class CollectionViewCellNewTaskName: UICollectionViewCell {
    
    static let identifier: String = "CollectionViewCellNewTaskName"
    
    lazy var textFieldTaskName: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .cardLavanda
        textField.textColor = .white
        textField.layer.cornerRadius = 12
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.attributedPlaceholder = NSAttributedString(
            string: "Nome da tarefa",
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 16)
            ]
        )
        
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
        layer.masksToBounds = false
        addSubViews()
        setUptConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionViewCellNewTaskName: ViewCodeProtocol {
    
    func setUptConstraints() {
        NSLayoutConstraint.activate([
            textFieldTaskName.topAnchor.constraint(equalTo: contentView.topAnchor),
            textFieldTaskName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textFieldTaskName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textFieldTaskName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ])
    }
    
    func addSubViews(){
        contentView.addSubview(textFieldTaskName)
    }
}
