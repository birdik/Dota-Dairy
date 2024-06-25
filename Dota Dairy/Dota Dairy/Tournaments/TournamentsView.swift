//
//  TournamentsView.swift
//  Dota Dairy
//
//  Created by birdik on 13.06.2024.
//

import SwiftUI

struct TournamentsView: View {
    
    @StateObject var viewModel = TournamentsViewModel()
    
    var body: some View {
        ZStack {
            Color.color1
                .ignoresSafeArea()
            VStack {
                HStack {
                    VStack{
                        Spacer()
                        Text("Tournaments")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    .frame(height: 40)
                    Spacer()
                }
                .padding(.horizontal)
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    
                    ZStack {
                        if viewModel.tournaments.isEmpty {
                            VStack {
                                Text("Empty")
                                    .foregroundColor(.color1)
                                    .font(.title2.bold())
                                Text("You don’t have any added tournaments")
                                    .foregroundColor(.color1)
                                    .font(.footnote)
                            }
                        } else {
                            ScrollView {
                                LazyVStack {
                                    VStack {}.padding(5)
                                    ForEach(viewModel.tournaments, id: \.self) { tournament in
                                        Button {
                                            viewModel.onDetail(tournament: tournament)
                                        } label: {
                                            SwipeableTourView(tournament: tournament, onDelete: {
                                                viewModel.deleteTournament(tournament: tournament)
                                            })
                                            
                                        }
                                    }
                                }
                            }
                        }
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button {
                                    viewModel.isShowingAddTour = true
                                } label: {
                                    Image("plus")
                                        .frame(width: 40, height: 40)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchTournaments()
        }
        .fullScreenCover(isPresented: $viewModel.isShowingAddTour, content: {
            TournamentsViewAdd(viewModel: viewModel)
        })
        .fullScreenCover(isPresented: $viewModel.isShowingDetailTour, content: {
            TournamentsDetailView(viewModel: viewModel)
        })
    }
}

#Preview {
    TournamentsView()
}

struct SwipeableTourView: View {
    @State private var offset: CGFloat = 0
    @State private var isSwiping = false
    var tournament: TournamentsModel
    var onDelete: () -> Void

    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                Spacer()
                Button(action: onDelete) {
                    VStack {
                        Image(systemName: "trash.fill")
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                    }
                    .frame(maxHeight: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 4)
            
            HStack {
                HStack {
                    VStack (alignment: .leading){
                        Text(tournament.date ?? "")
                            .foregroundColor(.white)
                            .font(.caption)
                            .lineLimit(1)
                        Text(tournament.tourName ?? "")
                            .foregroundColor(.white)
                            .font(.headline)
                            .lineLimit(1)
                            .padding(.vertical, 2)
                        Text(tournament.descriptions ?? "")
                            .lineLimit(1)
                            .foregroundColor(.white)
                            .font(.subheadline)
                    }
                    .padding()
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                        .padding()
                }
                .background(Color.color)
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.bottom, 4)
                    .offset(x: offset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if value.translation.width < 0 { // Swipe left
                                    self.offset = value.translation.width
                                    self.isSwiping = true
                                }
                            }
                            .onEnded { value in
                                if value.translation.width < -100 {
                                    self.offset = -90
                                } else {
                                    self.offset = 0
                                    self.isSwiping = false
                                }
                            }
                    )
            }
            .animation(.spring(), value: offset)
        }
    }
}
