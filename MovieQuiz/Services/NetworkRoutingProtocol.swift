//
//  NetworkRoutingProtocol.swift
//  MovieQuiz
//
//  Created by Margarita Pitinova on 14.03.2023.
//

import Foundation

protocol NetworkRouting {
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void)
}
