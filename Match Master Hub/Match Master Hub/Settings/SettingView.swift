//
//  SettingView.swift
//  Dota Dairy
//
//  Created by birdik on 13.06.2024.
//

import SwiftUI
import StoreKit

struct SettingView: View {
    @StateObject var viewModel = SettingViewModel()
    @AppStorage("victories") private var victories = ""
    @AppStorage("defeats") private var defeats = ""
    @AppStorage("endTour") private var endTour = "0"
    @State private var isShowingShareSheet = false
    
    var body: some View {
        ZStack {
            Color.color1
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    VStack{
                        Spacer()
                        Text("Settings")
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
                    
                    VStack {
                        VStack {
                            Button {
                                guard let url = URL(string: "https://www.termsfeed.com/live/00b7bf23-654d-4252-b554-3fad528e1cef") else { return }
                                UIApplication.shared.open(url)
                                
                            } label: {
                                HStack {
                                    Image(systemName: "doc.text.fill")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text("Usage Policy")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .padding(.top, 10)
                            }
                            
                            Divider().background(Color.white).padding(.leading, 43)
                            
                            Button {
                                
                                isShowingShareSheet = true
                                
                            } label: {
                                HStack {
                                    Image(systemName: "square.and.arrow.up.fill")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text("Share App")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                                .padding()
                            }
                            
                            Divider().background(Color.white).padding(.leading, 43)
                            
                            
                            Button {
                                
                                SKStoreReviewController.requestReview()
                                
                            } label: {
                                HStack {
                                    Image(systemName: "star.fill")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text("Rate Us")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .padding(.bottom, 10)
                            }
                        }
                        .background(Color.color)
                        .cornerRadius(10)
                        .padding()
                        .padding(.top, 10)
                        
                        Spacer()
                        Button {
                            viewModel.deleteData()
                            victories = ""
                            defeats = ""
                            endTour = "0"
                        } label: {
                            Text("Reset progress")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.color)
                                .cornerRadius(16)
                        }
                        .padding([.horizontal, .bottom])
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingShareSheet) {
            ShareSheet(activityItems: ["https://apps.apple.com/app/match-master-hub/id6504752687"])
        }
    }
}

#Preview {
    SettingView()
}
