//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Margarita Pitinova on 28.02.2023.
//

import Foundation

final class StatisticServiceImplementation: StatisticService {
    private let userDefaults = UserDefaults.standard
    private enum Keys: String {
        case correct, total, bestGame, gamesCount
    }
    
    var totalAccuracy: Double {
        get {
            userDefaults.double(forKey: Keys.total.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.total.rawValue)
        }
    }
    
    var gamesCount: Int {
        get {
            userDefaults.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameRecord {
        get {
            guard let data:Data = userDefaults.data(forKey: Keys.bestGame.rawValue),
                  let record:GameRecord = try? JSONDecoder().decode(GameRecord.self, from: data) else {
                return GameRecord(correct: 0, total: 0, date: Date())
            }
            
            return record
        }
        
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
    }
    
    func store(correct count: Int, total amount: Int) {
        let newGameResult = GameRecord(correct: count, total: amount, date: Date())
        
        if bestGame < newGameResult {
            bestGame = newGameResult
        }
        
        gamesCount += 1
        totalAccuracy = (Double(count) / Double(amount) + totalAccuracy) / Double(gamesCount)
    }
}
