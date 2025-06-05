//
//  IconsEnum.swift
//  MinhaRotina
//
//  Created by Vítor Bruno on 03/06/25.
//

import UIKit

struct Icons{
    let name: String
    let icon: UIImage
    var isSelected: Bool
}

//array com os icones da collectio view
var taskIcons: [Icons] = [
    .init(name: "Sol", icon: UIImage(systemName: "sun.max") ?? UIImage(), isSelected: false),
    .init(name: "Lua", icon: UIImage(systemName: "moon") ?? UIImage(), isSelected: false),
    .init(name: "Café", icon: UIImage(systemName: "cup.and.saucer") ?? UIImage(), isSelected: false),
    .init(name: "Livro", icon: UIImage(systemName: "book") ?? UIImage(), isSelected: false),
    .init(name: "Halter", icon: UIImage(systemName: "dumbbell") ?? UIImage(), isSelected: false),
    .init(name: "Maleta", icon: UIImage(systemName: "briefcase") ?? UIImage(), isSelected: false),
    .init(name: "Pessoas", icon: UIImage(systemName: "person.2") ?? UIImage(), isSelected: false),
    .init(name: "Coração", icon: UIImage(systemName: "heart") ?? UIImage(), isSelected: false),
    .init(name: "Música", icon: UIImage(systemName: "music.note") ?? UIImage(), isSelected: false),
    .init(name: "Filme", icon: UIImage(systemName: "film") ?? UIImage(), isSelected: false),
    .init(name: "Compras", icon: UIImage(systemName: "bag") ?? UIImage(), isSelected: false),
    .init(name: "Carro", icon: UIImage(systemName: "car") ?? UIImage(), isSelected: false)
]
