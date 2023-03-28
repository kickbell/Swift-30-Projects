//
//  User.swift
//  SampleApp
//
//  Created by jc.kim on 3/28/23.
//

import Foundation

public struct User: Codable {
  let id: Int
  let name, username, email: String
  let address: Address
  let phone, website: String
  let company: Company
}

public struct Address: Codable {
  let street, suite, city, zipcode: String
  let geo: Geo
}

public struct Geo: Codable {
  let lat, lng: String
}

public struct Company: Codable {
  let name, catchPhrase, bs: String
}
