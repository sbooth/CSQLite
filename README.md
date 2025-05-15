# CSQLite

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsbooth%2FCSQLite%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/sbooth/CSQLite)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsbooth%2FCSQLite%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/sbooth/CSQLite)

[SQLite](https://sqlite.org/index.html) packaged for the [Swift Package Manager](https://swift.org/package-manager/).

The package contains the [SQLite amalgamation](https://sqlite.org/amalgamation.html) built using the [recommended compile-time options](https://sqlite.org/compile.html#recommended_compile_time_options).

The default build configuration includes the [FTS5 extension](https://sqlite.org/fts5.html), built-in [SQL math functions](https://sqlite.org/lang_mathfunc.html), the [R\*Tree index extension](https://sqlite.org/rtree.html), [database snapshots](https://sqlite.org/c3ref/snapshot.html), [sqlite_stmt table](https://www.sqlite.org/stmt.html), and the [sqlite_stat4 table](https://sqlite.org/fileformat2.html#stat4tab).

Additionally, the [carray](https://sqlite.org/carray.html), [decimal](https://sqlite.org/floatingpoint.html#the_decimal_c_extension), [ieee754](https://sqlite.org/floatingpoint.html#the_ieee754_c_extension), [percentile](https://www.sqlite.org/src/file/ext/misc/percentile.c), [series](https://www.sqlite.org/src/file/ext/misc/series.c), [sha3](https://www.sqlite.org/src/file/ext/misc/shathree.c), and [uuid](https://www.sqlite.org/src/file/ext/misc/uuid.c) extensions are statically linked.

The package also includes [shims](Sources/CSQLite/include/csqlite_shims.h) for various C functions not easily accessible from Swift.

## Customization

The build configuration may be customized using package traits. The tables below summarize the supported and **default** traits.

| Package Trait | SQLite Compile-Time Option | Notes |
| --- | --- | --- |
| **OMIT_AUTOINIT** | [SQLITE_OMIT_AUTOINIT](https://sqlite.org/compile.html#omit_autoinit) | |

| Package Trait | SQLite Feature | Notes |
| --- | --- | --- |
| ENABLE_BYTECODE_VTAB | [SQLITE_ENABLE_BYTECODE_VTAB](https://sqlite.org/bytecodevtab.html) | |
| ENABLE_COLUMN_METADATA | [SQLITE_ENABLE_COLUMN_METADATA](https://sqlite.org/c3ref/column_database_name.html) | |
| ENABLE_DBPAGE_VTAB | [SQLITE_ENABLE_DBPAGE_VTAB](https://sqlite.org/dbpage.html) | |
| ENABLE_DBSTAT_VTAB | [SQLITE_ENABLE_DBSTAT_VTAB](https://sqlite.org/dbstat.html) | |
| **ENABLE_FTS5** | [SQLITE_ENABLE_FTS5](https://sqlite.org/fts5.html) | |
| ENABLE_GEOPOLY | [SQLITE_ENABLE_GEOPOLY](https://sqlite.org/geopoly.html) | |
| **ENABLE_MATH_FUNCTIONS** | [SQLITE_ENABLE_MATH_FUNCTIONS](https://sqlite.org/lang_mathfunc.html) | |
| ENABLE_NORMALIZE | [SQLITE_ENABLE_NORMALIZE](https://sqlite.org/c3ref/expanded_sql.html) | |
| ENABLE_PREUPDATE_HOOK | [SQLITE_ENABLE_PREUPDATE_HOOK](https://sqlite.org/c3ref/preupdate_blobwrite.html) | |
| **ENABLE_RTREE** | [SQLITE_ENABLE_RTREE](https://sqlite.org/rtree.html) | |
| ENABLE_SESSION | [SQLITE_ENABLE_SESSION](https://sqlite.org/sessionintro.html) | Also sets `ENABLE_PREUPDATE_HOOK` |
| **ENABLE_SNAPSHOT** | [SQLITE_ENABLE_SNAPSHOT](https://sqlite.org/c3ref/snapshot.html) | |
| **ENABLE_STMTVTAB** | [SQLITE_ENABLE_STMTVTAB](https://sqlite.org/stmt.html) | |
| **ENABLE_STAT4** | [SQLITE_ENABLE_STAT4](https://sqlite.org/fileformat2.html#stat4tab) | |

## License

SQLite is in the [public domain](https://sqlite.org/copyright.html).
