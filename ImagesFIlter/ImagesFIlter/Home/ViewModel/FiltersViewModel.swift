//
//  FiltersViewModel.swift
//  ImagesFIlter
//
//  Created by Ahmed Abuelmagd on 23/11/2022.
//

import Foundation
import Combine

class FiltersViewModel {
    @Published private (set) var tasks: [FilterModel] = []
    
    func getFilters() async {
        let filtersList = await loadFilters()
        tasks = filtersList ?? []
    }
    
    private func loadFilters() async -> [FilterModel]? {
        guard let url = Bundle.main.url(forResource: "Filters", withExtension: "json") else {
            fatalError()
        }
        do {
            let data = try Data(contentsOf: url)
            let filtersList = try JSONDecoder().decode([FilterModel].self, from: data)
            return filtersList
        } catch {
            print("error\(error)")
        }
        return nil
    }
}
