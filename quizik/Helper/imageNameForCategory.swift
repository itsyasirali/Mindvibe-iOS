struct ImageCategory {
    static func imageName(_ category: String) -> String {
        switch category.lowercased() {
        case "general knowledge": return "general_knowledge"
        case "books": return "books"
        case "film": return "film"
        case "music": return "music"
        case "musical & theatres": return "musical"
        case "television": return "television"
        case "video games": return "video_games"
        case "board games": return "board_games"
        case "computer science": return "computer"
        case "science & nature": return "science"
        case "mathematics": return "math"
        case "mythology": return "mythology"
        case "geography": return "geography"
        case "sports": return "sports"
        case "politics": return "politics"
        case "history": return "history"
        case "art": return "art"
        case "celebrities": return "celebrities"
        case "animals": return "animals"
        case "vehicles": return "vehicles"
        case "comics": return "comics"
        case "gadgets": return "gadgets"
        case "japanese anime & manga": return "anime"
        case "cartoon & animation": return "cartoon"
        default: return "default_category"
        }
    }
}
