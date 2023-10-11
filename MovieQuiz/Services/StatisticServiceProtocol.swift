//
//  StatisticServiceProtocol.swift
//  MovieQuiz
//
//  Created by Margarita Pitinova on 14.03.2023.
//

import Foundation

protocol StatisticService {
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: GameRecord { get }
    
    func store(correct count: Int, total amount: Int)
}
