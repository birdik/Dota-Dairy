//
//  TournamentsViewAdd.swift
//  Dota Dairy
//
//  Created by birdik on 13.06.2024.
//

import SwiftUI

struct TournamentsViewAdd: View {
    @Environment(\.presentationMode) var router
    @ObservedObject var viewModel: TournamentsViewModel
    
    var body: some View {
        ZStack {
            Color.color1.ignoresSafeArea()
            
            VStack {
                ZStack {
                    Text("Add tournament")
                        .foregroundColor(.white)
                        .font(.headline)
                    HStack {
                        Button {
                            viewModel.clear()
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
                    }
                }
                .padding([.horizontal])
                
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    
                    VStack {
                        VStack {
                            TextField("", text: $viewModel.tourName)
                                .placeholder(when: viewModel.tourName.isEmpty) {
                                    Text("Tournament name").foregroundColor(.white).opacity(0.5)
                                }
                                .foregroundColor(.white)
                                .padding([.horizontal, .top])
                                .padding(.bottom, 5)
                            
                            Divider().background(Color.white)
                            
                            TextField("", text: $viewModel.location)
                                .placeholder(when: viewModel.location.isEmpty) {
                                    Text("Location").foregroundColor(.white).opacity(0.5)
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                            
                            Divider().background(Color.white)
                            
                            TextField("", text: $viewModel.date)
                                .placeholder(when: viewModel.date.isEmpty) {
                                    Text("Date").foregroundColor(.white).opacity(0.5)
                                }
                                .foregroundColor(.white)
                                .padding([.horizontal, .bottom])
                                .padding(.top, 5)
                        }
                        .background(Color.color)
                        .cornerRadius(10)
                        .padding()
                        .padding(.top, 10)
                        
                        VStack {
                            TextField("", text: $viewModel.prizePool)
                                .placeholder(when: viewModel.prizePool.isEmpty) {
                                    Text("Prize pool").foregroundColor(.white).opacity(0.5)
                                }
                                .foregroundColor(.white)
                                .padding([.horizontal, .top])
                                .padding(.bottom, 5)
                            
                            Divider().background(Color.white)
                            
                            TextField("", text: $viewModel.descriptions)
                                .placeholder(when: viewModel.descriptions.isEmpty) {
                                    Text("Descriptions").foregroundColor(.white).opacity(0.5)
                                }
                                .foregroundColor(.white)
                                .padding([.horizontal, .bottom])
                                .padding(.top, 5)

                            

                        }
                        .background(Color.color)
                        .cornerRadius(10)
                        .padding()
                        
                        Spacer()
                        
                        Button {
                            viewModel.addTournament()
                            viewModel.fetchTournaments()
                            viewModel.clear()
                            router.wrappedValue.dismiss()
                        } label: {
                            Text("Add")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.color1)
                                .cornerRadius(16)
                        }
                        .padding([.horizontal, .bottom])
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                }
            }
        }
    }
}

#Preview {
    TournamentsViewAdd(viewModel: TournamentsViewModel())
}

