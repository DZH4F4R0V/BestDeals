//
//  Deal.swift
//  BestDeals
//
//  Created by J Eff on 08.05.2023.
//

import Foundation

struct Deal: Decodable {
    let title: String
    let salePrice: Double
    let normalPrice: Double
    let metacriticScore: Int
    let thumb: URL
}
