protocol CityInputValidator {
    func validate(_ string: String) -> Bool
}

struct CityInputValidatorImpl: CityInputValidator {
    func validate(_ string: String) -> Bool {
        let pattern = "[A-Za-zżźćńółęąśŻŹĆĄŚĘŁÓŃ ]" // TODO: refactor
        guard string != "" else { return true }
        return string.range(of: pattern, options: .regularExpression) != nil
    }
}
