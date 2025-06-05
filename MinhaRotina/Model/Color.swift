//
//  Color.swift
//  MinhaRotina
//
//  Created by Vítor Bruno on 05/06/25.
//

import UIKit

struct Color {
    let name: String
    let color: UIColor
    var isSelected: Bool = false
}

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
