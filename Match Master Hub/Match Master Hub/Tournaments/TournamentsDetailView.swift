//
//  TournamentsDetailView.swift
//  Dota Dairy
//
//  Created by birdik on 14.06.2024.
//

import SwiftUI

struct TournamentsDetailView: View {
    @Environment(\.presentationMode) var router
    @State private var edit = false
    
    @ObservedObject var viewModel: TournamentsViewModel
    
    
    var body: some View {
        ZStack {
            Color.color1.ignoresSafeArea()
            
            VStack {
                ZStack {
                    Text(edit ? "Edit" : viewModel.tournament?.tourName ?? "")
                        .foregroundColor(.white)
                        .font(.headline)
                    HStack {
                        Button {
                            viewModel.clear()
                            viewModel.fetchTournaments()
                            router.wrappedValue.dismiss()
                        } label: {
                            
                            HStack {
                                
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.color)
                                    .font(.headline)
                                
                                Text("Back")
                                    .foregroundColor(.color)
                                    .font(.headline)
                            }
                        }
                        
                        Spacer()
                        
                        HStack {
                            Button {
                                edit.toggle()
                                viewModel.onDetailTour()
                            } label: {
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(.color)
                                    .font(.headline)
                            }
                            .padding(.trailing, 8)
                            
                            
                            Button {
                                viewModel.deleteTournament(tournament: viewModel.tournament)
                                viewModel.clear()
                                viewModel.fetchTournaments()
                                router.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "trash.fill")
                                    .foregroundColor(.red)
                                    .font(.headline)
                            }
                        }
                    }
                }
                .padding([.horizontal])
                
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    if edit {
                        VStack {
                            VStack {
                                HStack {
                                    Text("Tournament name:")
                                        .foregroundColor(.white).opacity(0.5)
                                    TextField("", text: $viewModel.tourName)
                                        .foregroundColor(.white)
                                }
                                .padding([.horizontal, .top])
                                .padding(.bottom, 5)
                                
                                Divider().background(Color.white)
                                
                                HStack {
                                    Text("Location:")
                                        .foregroundColor(.white).opacity(0.5)
                                    TextField("", text: $viewModel.location)
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                
                                Divider().background(Color.white)
                                
                                HStack {
                                    Text("Date:")
                                        .foregroundColor(.white).opacity(0.5)
                                    TextField("", text: $viewModel.date)
                                        .foregroundColor(.white)
                                }
                                .padding([.horizontal, .bottom])
                                .padding(.top, 5)
                            }
                            .background(Color.color)
                            .cornerRadius(10)
                            .padding()
                            .padding(.top, 10)
                            
                            VStack {
                                HStack {
                                    Text("Prize pool:")
                                        .foregroundColor(.white).opacity(0.5)
                                    TextField("", text: $viewModel.prizePool)
                                        .foregroundColor(.white)
                                }
                                .padding([.horizontal, .top])
                                .padding(.bottom, 5)
                                
                                Divider().background(Color.white)
                                
                                HStack {
                                    Text("Description:")
                                        .foregroundColor(.white).opacity(0.5)
                                    TextField("", text: $viewModel.descriptions)
                                        .foregroundColor(.white)
                                }
                                .padding([.horizontal, .bottom])
                                .padding(.top, 5)

                            }
                            .background(Color.color)
                            .cornerRadius(10)
                            .padding()
                            
                            Spacer()
                            
                            Button {
                                viewModel.saveChangeTour()
                                viewModel.fetchTournaments()
                                edit = false
                            } label: {
                                Text("Save")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.color1)
                                    .cornerRadius(16)
                            }
                            .padding([.horizontal, .bottom])

                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                    } else {
                        VStack {
                            VStack (alignment: .leading){
                                Text(viewModel.tournament?.tourName ?? "")
                                    .foregroundColor(.white)
                                    .padding([.horizontal, .top])
                                    .padding(.bottom, 5)
                            
                            Divider().background(Color.white)
                            
                                Text(viewModel.tournament?.location ?? "")
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                            
                            Divider().background(Color.white)
                            
                                Text(viewModel.tournament?.date ?? "")
                                    .foregroundColor(.white)
                                    .padding([.horizontal, .bottom])
                                    .padding(.top, 5)
                            }
                            .background(Color.color)
                            .cornerRadius(10)
                            .padding()
                            .padding(.top, 10)
                            
                            VStack (alignment: .leading){
                                Text(viewModel.tournament?.prizePool ?? "")
                                    .foregroundColor(.white)
                                    .padding([.horizontal, .top])
                                    .padding(.bottom, 5)
                                
                                Divider().background(Color.white)
                                
                                Text(viewModel.tournament?.descriptions ?? "")
                                    .foregroundColor(.white)
                                    .padding([.horizontal, .bottom])
                                    .padding(.top, 5)

                            }
                            .background(Color.color)
                            .cornerRadius(10)
                            .padding()
                            
                            Spacer()
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                    }
                }
            }
        }
        .onAppear {
            viewModel.onDetailTour()
        }
    }
}

