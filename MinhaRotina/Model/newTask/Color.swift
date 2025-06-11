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
    Color(name: "Lavanda Escuro", color: UIColor(red: 132/255, green: 94/255, blue: 194/255, alpha: 1.0)),   // roxo/lilás escuro
    Color(name: "Pêssego", color: UIColor(red: 255/255, green: 182/255, blue: 153/255, alpha: 1.0)),         // coral/pêssego suave
    Color(name: "Verde Menta", color: UIColor(red: 119/255, green: 221/255, blue: 119/255, alpha: 1.0)),     // verde menta
    Color(name: "Azul Pastel", color: UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1.0)),     // azul claro
    Color(name: "Rosa Chiclete", color: UIColor(red: 255/255, green: 105/255, blue: 180/255, alpha: 1.0)),   // rosa vibrante
    Color(name: "Amarelo Canário", color: UIColor(red: 255/255, green: 255/255, blue: 153/255, alpha: 1.0)), // amarelo pastel
    Color(name: "Ciano Neon", color: UIColor(red: 0/255, green: 255/255, blue: 255/255, alpha: 1.0))         // ciano brilhante
]
