//
//  MoviesLoadingProtocol.swift
//  MovieQuiz
//
//  Created by Margarita Pitinova on 14.03.2023.
//

import Foundation

protocol MoviesLoading {
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void)
}
