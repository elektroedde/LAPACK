import Accelerate


func symmetric_positiveDefinite_tridiagonal(diagonalElements: [Float],
                                            subdiagonalElements: [Float],
                                            dimension: Int,
                                            b: [Float],
                                            rightHandSideCount: Int) -> [Float]? {
    var info: __LAPACK_int = 0
    var x = b
    var d = diagonalElements
    var e = subdiagonalElements

    withUnsafePointer(to: __LAPACK_int(dimension)) { n in
        withUnsafePointer(to: __LAPACK_int(rightHandSideCount)) { nrhs in
            withUnsafePointer(to: __LAPACK_int(dimension)) { ldb in
                sptsv_(n,
                       nrhs,
                       &d,
                       &e,
                       &x,
                       ldb,
                       &info)
            }
        }
    }

    if info != 0 {
        NSLog("symmetric_positiveDefinite_tridiagonal error \(info)")
        return nil
    }
    return x

}
