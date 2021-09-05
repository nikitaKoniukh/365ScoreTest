//
//  Utils.swift
//  365ScoreTest
//
//  Created by Nikita Koniukh on 03/09/2021.
//

import Foundation

func formatDate(dateToFormat: String, inputFormat: String, outputFormat: String ) -> String  {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = inputFormat
    let showDate = inputFormatter.date(from: dateToFormat)
    inputFormatter.dateFormat = outputFormat
    return inputFormatter.string(from: showDate!)
}

func sortItemsByDate(_ items: [Game], inputFormat: String) -> [Game] {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = inputFormat
    let sortedArray = items.sorted { inputFormatter.date(from: $0.dateTime)! < inputFormatter.date(from: $1.dateTime)! }
    return sortedArray
}
