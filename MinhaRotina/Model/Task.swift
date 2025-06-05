//
//  Task.swift
//  MinhaRotina
//
//  Created by Vítor Bruno on 28/05/25.
//

struct Task {
    var title: String
    var dayOfTheWeek: Int
    var color: Int
    var time: String
    var icon: String
}

enum newTaskSection: Int, CaseIterable {
    case taskName = 0
    case dayOfWeek = 1
    case taskTime = 2
    case taskIcon = 3
    case taskColor = 4
}
