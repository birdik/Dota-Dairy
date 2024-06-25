//
//  TournamentsViewModel.swift
//  Dota Dairy
//
//  Created by birdik on 14.06.2024.
//

import SwiftUI
import CoreData

class TournamentsViewModel: ObservableObject {
    @Published var tournaments: [TournamentsModel] = []
    @Published var tournament: TournamentsModel?
    
    @Published var isShowingAddTour = false
    @Published var isShowingDetailTour = false
    
    @Published var tourName = ""
    @Published var location = ""
    @Published var date = ""
    @Published var prizePool = ""
    @Published var descriptions = ""
    
    func fetchTournaments() {
        let context = CoreDatas.shared.container.viewContext
        let fetchRequest = NSFetchRequest<TournamentsModel>(entityName: "TournamentsModel")
        
        do {
            tournaments = try context.fetch(fetchRequest)
        } catch {
            tournaments = []
        }
    }
    
    func clear() {
        tourName = ""
        location = ""
        date = ""
        prizePool = ""
        descriptions = ""
    }
    
    func addTournament() {
        let context = CoreDatas.shared.container.viewContext
        let tournament = NSEntityDescription.insertNewObject(forEntityName: "TournamentsModel", into: context) as! TournamentsModel
        
        tournament.tourName = tourName
        tournament.location = location
        tournament.date = date
        tournament.prizePool = prizePool
        tournament.descriptions = descriptions
        
        CoreDatas.shared.save()
        clear()
    }
    
    func deleteTournament(tournament: TournamentsModel?) {
        guard let tournament else { return }
        let context = CoreDatas.shared.container.viewContext
        context.delete(tournament)
        CoreDatas.shared.save()
        fetchTournaments()
    }
    
    func onDetail(tournament: TournamentsModel?) {
        guard let tournament else { return }
        self.tournament = tournament
        onDetailTour()
        isShowingDetailTour = true
    }
    
    func onDetailTour() {
        tourName = tournament?.tourName ?? ""
        location = tournament?.location ?? ""
        date = tournament?.date ?? ""
        prizePool = tournament?.prizePool ?? ""
        descriptions = tournament?.descriptions ?? ""
    }
    
    func saveChangeTour() {
        tournament?.tourName = tourName
        tournament?.location = location
        tournament?.date = date
        tournament?.prizePool = prizePool
        tournament?.descriptions = descriptions
        CoreDatas.shared.save()
    }
}
