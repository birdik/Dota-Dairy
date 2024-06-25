//
//  SettingViewModel.swift
//  Dota Dairy
//
//  Created by birdik on 16.06.2024.
//
import SwiftUI
import CoreData

class SettingViewModel: ObservableObject {
    @Published var matches: [MatchesModel] = []
    @Published var tournaments: [TournamentsModel] = []
    
    
    func deleteData() {
        let context = CoreDatas.shared.container.viewContext
        let fetchRequestTournaments: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "TournamentsModel")
        let fetchRequestMatches: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "MatchesModel")
        let tournamentsDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequestTournaments)
        let matchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequestMatches)
        
        
        do {
            try context.execute(tournamentsDeleteRequest)
            try context.execute(matchDeleteRequest)
        } catch {
            print("Ошибка при удалении данных для сущности: \(error)")
        }
        
        CoreDatas.shared.save()
    }
}
