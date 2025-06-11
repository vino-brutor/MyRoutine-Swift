//
//  CollectionViewCellColors.swift
//  MinhaRotina
//
//  Created by Vítor Bruno on 05/06/25.
//

import UIKit

class CollectionViewCellColors: UICollectionViewCell {
    
    static let reuseIdentifier: String = "CollectionViewCellColors"
    
    //array com as cores
    var taskColorsList: [Color] = [
        Color(name: "Vermelho", color: UIColor(red: 1.00, green: 0.35, blue: 0.27, alpha: 1.0)),
        Color(name: "Amarelo", color: UIColor(red: 1.00, green: 0.80, blue: 0.00, alpha: 1.0)),
        Color(name: "Verde Limão", color: UIColor(red: 0.66, green: 1.00, blue: 0.18, alpha: 1.0)),
        Color(name: "Ciano", color: UIColor(red: 0.00, green: 0.88, blue: 0.84, alpha: 1.0)),
        Color(name: "Azul", color: UIColor(red: 0.27, green: 0.44, blue: 0.97, alpha: 1.0)),
        Color(name: "Roxo", color: UIColor(red: 0.60, green: 0.47, blue: 0.94, alpha: 1.0)),
        Color(name: "Rosa", color: UIColor(red: 1.00, green: 0.38, blue: 0.80, alpha: 1.0))
    ]
    
    lazy var buttonColor: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.isUserInteractionEnabled = false 
        button.layer.masksToBounds = true
        
        return button
    }()
    
    func config(with color: Color) {
        print("Borda do botão cor: \(color.name), isSelected: \(color.isSelected)")
        buttonColor.backgroundColor = color.color
        buttonColor.layer.borderWidth = color.isSelected ? 3 : 0
        buttonColor.layer.borderColor = (color.isSelected ? UIColor.cardLavanda : UIColor.clear).cgColor
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

extension CollectionViewCellColors: ViewCodeProtocol {
    func addSubViews() {
        contentView.addSubview(buttonColor)
    }
    
    func setUptConstraints() {
        NSLayoutConstraint.activate([
            buttonColor.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonColor.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            buttonColor.heightAnchor.constraint(equalToConstant: 40),
            buttonColor.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    
}
