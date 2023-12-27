//
//  ViewModel.swift
//  DALLEE
//
//  Created by Gabriel Chirico Mahtuk de Melo Sanzone on 27/12/23.
//

import Foundation
import OpenAIKit
import SwiftUI

final class ViewModel: ObservableObject {

    private var openAi: OpenAI?

    func setup() {
        openAi = OpenAI(Configuration(
            organizationId: "Personal",
            apiKey: "" //SECRETKEY
        ))
    }

    func generateImage(prompt: String) async -> UIImage? {
        guard let openAi else { return nil }

        do {
            let params = ImageParameters(
                prompt: prompt,
                resolution: .medium,
                responseFormat: .base64Json
            )
            let result = try await openAi.createImage(
                parameters: params
            )
            return try openAi.decodeBase64Image(
                result.data[0].image
            )
        }
        catch {
            print(String(describing: error))
            return nil
        }
    }

}
