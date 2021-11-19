//
//  ContentView.swift
//  RandomPhoto
//
//  Created by Tatsuya Moriguchi on 11/18/21.
//

import SwiftUI

// https://random.imagecdn.app/500/500


class ViewModel: ObservableObject {
    
    // Property
    @Published var image: Image?
    
    func fetchNewImage() {
        guard let url = URL( string: "https://random.imagecdn.app/500/500") else { return }
        //let task = URLSession.shared.dataTask(with: url)
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                guard let uiImage = UIImage(data: data) else { return }
                
            self.image = Image(uiImage: uiImage)
                
            }
        }
        task.resume()
    }
}


struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                if let image = viewModel.image {
                    ZStack {
                    image
                        .resizable()
                        .foregroundColor(Color.pink)
                        .frame(width: 200, height: 200)
                        .padding()
                    }
                    .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.width / 1.2)
                    .background(Color.green)
                    .cornerRadius(8)
                    

                } else {
                    
                    Image(systemName: "photo")
                        .resizable()
                        .foregroundColor(Color.pink)
                        .frame(width: 200, height: 200)
                        .padding()

                }
                
                Spacer()
                
                Button(action: {
                    // Do something
                    viewModel.fetchNewImage()
                    
                }, label: {
                    Text("New Image")
                        .bold()
                        .frame(width: 250, height: 55)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding()
                    
                    
                })
            }
            .navigationTitle("Random Photo")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
