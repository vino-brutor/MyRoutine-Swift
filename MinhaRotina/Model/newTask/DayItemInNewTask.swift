//
//  DayItemInNewTask.swift
//  MinhaRotina
//
//  Created by Vítor Bruno on 02/06/25.
//

struct DayItemInNewTask {
    let name: String
    var isSelected: Bool
}

//dia das semana apara a collection view
var weekDays: [DayItemInNewTask] = [
    .init(name: "Segunda", isSelected: false),
    .init(name: "Terça", isSelected: false),
    .init(name: "Quarta", isSelected: false),
    .init(name: "Quinta", isSelected: false),
    .init(name: "Sexta", isSelected: false),
    .init(name: "Sábado", isSelected: false),
    .init(name: "Domingo", isSelected: false)
]
