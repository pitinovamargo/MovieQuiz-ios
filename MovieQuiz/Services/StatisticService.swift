//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Margarita Pitinova on 28.02.2023.
//

import Foundation

protocol StatisticService {
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: GameRecord { get }
    
    func store(correct count: Int, total amount: Int)
}

final class StatisticServiceImplementation: StatisticService {
    private let userDefaults = UserDefaults.standard
    private enum Keys: String {
        case correct, total, bestGame, gamesCount
    }
    
    var totalAccuracy: Double {
        get {
            guard let data:Data = userDefaults.data(forKey: Keys.total.rawValue),
                  let totalAcc:Double = try? JSONDecoder().decode(Double.self, from: data) else {
                    return 0
            }
            return totalAcc
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            userDefaults.set(data, forKey: Keys.total.rawValue)
        }
    }
    
    var gamesCount: Int {
        get {
            guard let data:Data = userDefaults.data(forKey: Keys.gamesCount.rawValue),
                  let count:Int = try? JSONDecoder().decode(Int.self, from: data) else {
                    return 0
            }
            return count
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            userDefaults.set(data, forKey: Keys.gamesCount.rawValue)
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
        let chosenBestGame = bestGame.comparisonRecords(gameResult: GameRecord(correct: count, total: amount, date: Date()))
        bestGame = chosenBestGame
        
        gamesCount += 1

        totalAccuracy = (Double(count) / Double(amount) + totalAccuracy) / Double(gamesCount)
    }
}
