import Foundation

struct ExampleViewModel {
    struct Category {
        let name: String
        let values: [String]
    }
    
    let datasource: [Category] = [
        Category(name: "DRINKS", values: ["Cups of coffee", "Glasses of water"]),
        Category(name: "FOOD", values: ["Hot Dogs", "Cupcakes eaten"]),
        Category(name: "MISC", values: ["Times sneezed", "Naps", "Day dreaming"]),
    ]
}
