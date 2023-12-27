//
//  ContentView.swift
//  DALLEE
//
//  Created by Gabriel Chirico Mahtuk de Melo Sanzone on 27/12/23.
//
import OpenAIKit
import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel = ViewModel()
    @State var text = ""
    @State var image: UIImage?

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                } else {
                    Text("Type prompt to generate image")
                }
                Spacer()
                TextField("Type prompt here...", text: $text)
                    .padding()
                Button("Generate") {
                    if !text.trimmingCharacters(in: .whitespaces).isEmpty {
                        Task {
                            let result = await viewModel.generateImage(prompt: text)
                            guard let result else {
                                print("Error")
                                return
                            }
                            self.image = result
                        }
                    }
                }
            }
            .navigationTitle("Image Generator")
            .onAppear {
                viewModel.setup()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
