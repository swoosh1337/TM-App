//
//  LibraryView.swift
//  TM.io
//
//  Created by Tazi Grigolia on 10/21/24.
//

import SwiftUI
import WebKit

struct LibraryView: View {
    @StateObject private var viewModel = LibraryViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .padding(.top, 50)
                } else {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.videos) { video in
                            VideoCard(video: video)
                                .onTapGesture {
                                    viewModel.selectVideo(video)
                                }
                        }
                    }
                    .padding()
                }
            }
            .background(Color(red: 1.0, green: 1.0, blue: 0.9))
            .navigationTitle("Meditation Library")
            .sheet(item: $viewModel.selectedVideo) { video in
                WebView(url: video.videoURL)
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .onAppear {
            if viewModel.videos.isEmpty {
                viewModel.fetchVideos()
            }
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}

