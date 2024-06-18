# CSQLite

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsbooth%2FCSQLite%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/sbooth/CSQLite)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsbooth%2FCSQLite%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/sbooth/CSQLite)

[SQLite](https://sqlite.org/index.html) packaged for the [Swift Package Manager](https://swift.org/package-manager/).

The package contains the [SQLite amalgamation](https://sqlite.org/amalgamation.html) built using the [recommended compile-time options](https://sqlite.org/compile.html#recommended_compile_time_options).

The default build configuration includes the [FTS5 extension](https://sqlite.org/fts5.html), built-in [SQL math functions](https://sqlite.org/lang_mathfunc.html), the [R\*Tree index extension](https://sqlite.org/rtree.html), [database snapshots](https://sqlite.org/c3ref/snapshot.html), [sqlite_stmt table](https://www.sqlite.org/stmt.html), and the [sqlite_stat4 table](https://sqlite.org/fileformat2.html#stat4tab).

Additionally, the [carray](https://sqlite.org/carray.html), [decimal](https://sqlite.org/floatingpoint.html#the_decimal_c_extension), [ieee754](https://sqlite.org/floatingpoint.html#the_ieee754_c_extension), [series](https://www.sqlite.org/src/file/ext/misc/series.c), [sha3](https://www.sqlite.org/src/file/ext/misc/shathree.c), and [uuid](https://www.sqlite.org/src/file/ext/misc/uuid.c) extensions are statically linked.

The package also includes [shims](Sources/CSQLite/include/csqlite_shims.h) for various C functions not easily accessible from Swift.

## License

SQLite is in the [public domain](https://sqlite.org/copyright.html).
