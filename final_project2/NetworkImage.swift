//
//  NetworkImage.swift
//  final_project2
//
//  Created by 林湘羚 on 2021/1/1.
//

import Foundation
import SwiftUI

struct NetworkImage: View  {
    var urlString: String
    @State private var image = Image(systemName: "photo")
    @State private var downloadImageOk = false
    func downLoad() {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data,response, error) in
                if let data = data,
                   let uiImage = UIImage(data: data) {
                        image = Image(uiImage: uiImage)
                        downloadImageOk = true
                }
            }.resume()
        }
    }
    var body: some View {
        image
            .resizable()
            .onAppear {
                if downloadImageOk == false {
                    downLoad()
                }
            }
    }
}
