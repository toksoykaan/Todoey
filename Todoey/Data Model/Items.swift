//
//  Items.swift
//  Todoey
//
//  Created by Kaan TOKSOY on 29.10.2018.
//  Copyright © 2018 Kaan TOKSOY. All rights reserved.
//

import Foundation

class Items: Encodable, Decodable { // Veya Codeable yazabiliriz bu ikisi yerine
    var title = ""
    var done = false
}
//Property List'in içine kaydediliyor.
