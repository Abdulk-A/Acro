//
//  ListDefinitionsViewModel.swift
//  Acro
//
//  Created by Abdullah on 10/15/25.
//

import Foundation


@Observable
class ListDefinitionsViewModel {
    private(set) var acronym: Acronym
    
    init(acronym: Acronym) {
        self.acronym = acronym
    }
}
