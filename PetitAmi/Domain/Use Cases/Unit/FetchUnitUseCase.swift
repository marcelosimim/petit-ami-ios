//
//  FetchUnitUseCase.swift
//  PetitAmi
//
//  Created by Marcelo Simim Santos on 22/03/22.
//

import Foundation

protocol FetchUnitUseCase {
    func fetchSize(unit:Int, completion: @escaping(Result<Int?, Error>) -> Void)
    func fetchCover(unit: Int, completion: @escaping(Result<Data?, Error>) -> Void)
}
