infix operator ??= { associativity right precedence 90 }

func ??= <T> (inout lhs: T?, rhs: T?) {
    if lhs == nil {
        lhs = rhs
    }
}
