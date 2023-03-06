//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Margarita Pitinova on 24.02.2023.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    
    let completion: () -> Void
}
