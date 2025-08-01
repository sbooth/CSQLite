# CSQLite

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsbooth%2FCSQLite%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/sbooth/CSQLite)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsbooth%2FCSQLite%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/sbooth/CSQLite)

[SQLite](https://sqlite.org/index.html) packaged for the [Swift Package Manager](https://swift.org/package-manager/).

The package contains the [SQLite amalgamation](https://sqlite.org/amalgamation.html) built using the [recommended compile-time options](https://sqlite.org/compile.html#recommended_compile_time_options).

The default build configuration includes the [FTS5 extension](https://sqlite.org/fts5.html), built-in [SQL math functions](https://sqlite.org/lang_mathfunc.html), the [R\*Tree index extension](https://sqlite.org/rtree.html), [database snapshots](https://sqlite.org/c3ref/snapshot.html), [sqlite_stmt table](https://www.sqlite.org/stmt.html), and the [sqlite_stat4 table](https://sqlite.org/fileformat2.html#stat4tab).

Additionally, the [carray](https://sqlite.org/carray.html), [decimal](https://sqlite.org/floatingpoint.html#the_decimal_c_extension), [ieee754](https://sqlite.org/floatingpoint.html#the_ieee754_c_extension), [percentile](https://www.sqlite.org/src/file/ext/misc/percentile.c), [series](https://www.sqlite.org/src/file/ext/misc/series.c), [sha3](https://www.sqlite.org/src/file/ext/misc/shathree.c), and [uuid](https://www.sqlite.org/src/file/ext/misc/uuid.c) extensions are statically linked.

The package also includes [shims](Sources/CSQLite/include/csqlite_shims.h) for various C functions not easily accessible from Swift.

## Customization

For Swift 6.1 and later the build configuration and features may be customized using package traits.

### Recommended Compile-Time Options

The following traits are used to specify the build configuration and the defaults reflect the SQLite [recommended compile-time options](https://sqlite.org/compile.html#recommended_compile_time_options):

| Package Trait | Default | SQLite Compile-Time Option |
| --- | :---: | --- |
| DQS_0 | Y | [SQLITE_DQS=0](https://sqlite.org/compile.html#dqs) |
| DQS_1 | | [SQLITE_DQS=1](https://sqlite.org/compile.html#dqs) |
| DQS_2 | | [SQLITE_DQS=2](https://sqlite.org/compile.html#dqs) |
| DQS_3 | | [SQLITE_DQS=3](https://sqlite.org/compile.html#dqs) |
| THREADSAFE_0 | Y | [SQLITE_THREADSAFE=0](https://sqlite.org/compile.html#threadsafe) |
| THREADSAFE_1 | | [SQLITE_THREADSAFE=1](https://sqlite.org/compile.html#threadsafe) |
| THREADSAFE_2 | | [SQLITE_THREADSAFE=2](https://sqlite.org/compile.html#threadsafe) |
| DEFAULT_MEMSTATUS_0 | Y | [SQLITE_DEFAULT_MEMSTATUS=0](https://sqlite.org/compile.html#default_memstatus) |
| DEFAULT_WAL_SYNCHRONOUS_1 | Y | [SQLITE_DEFAULT_WAL_SYNCHRONOUS=1](https://sqlite.org/compile.html#default_wal_synchronous) |
| LIKE_DOESNT_MATCH_BLOBS | Y | [SQLITE_LIKE_DOESNT_MATCH_BLOBS](https://sqlite.org/compile.html#like_doesnt_match_blobs) |
| MAX_EXPR_DEPTH_0 | Y | [SQLITE_MAX_EXPR_DEPTH=0](https://sqlite.org/compile.html#max_expr_depth) |
| OMIT_DECLTYPE | Y | [SQLITE_OMIT_DECLTYPE](https://sqlite.org/compile.html#omit_decltype) |
| OMIT_DEPRECATED | Y | [SQLITE_OMIT_DEPRECATED](https://sqlite.org/compile.html#omit_deprecated) |
| OMIT_PROGRESS_CALLBACK | Y | [SQLITE_OMIT_PROGRESS_CALLBACK](https://sqlite.org/compile.html#omit_progress_callback) |
| OMIT_SHARED_CACHE | Y | [SQLITE_OMIT_SHARED_CACHE](https://sqlite.org/compile.html#omit_shared_cache) |
| USE_ALLOCA | Y | [SQLITE_USE_ALLOCA](https://sqlite.org/compile.html#use_alloca) |
| OMIT_AUTOINIT | Y | [SQLITE_OMIT_AUTOINIT](https://sqlite.org/compile.html#omit_autoinit) |
| STRICT_SUBTYPE_1 | Y | [SQLITE_STRICT_SUBTYPE=1](https://sqlite.org/compile.html#strict_subtype) |

#### [Double-Quoted Strings](https://sqlite.org/quirks.html#dblquote)

> [!IMPORTANT]
> The `DQS_` traits are mutually exclusive and only one should be specified. 

The SQLite default is `SQLITE_DQS=3` but the SQLite recommended value is `SQLITE_DQS=0`.

#### [Threading Mode](https://sqlite.org/threadsafe.html)

> [!IMPORTANT]
> The `THREADSAFE_` traits are mutually exclusive and only one should be specified.

The SQLite default is `SQLITE_THREADSAFE=1` but the SQLite recommended value is `SQLITE_THREADSAFE=0`.

### Features

The following traits enable commonly-used SQLite features:

| Package Trait | Default | SQLite Feature |
| --- | :---: | --- |
| ENABLE_BYTECODE_VTAB | | [SQLITE_ENABLE_BYTECODE_VTAB](https://sqlite.org/bytecodevtab.html) |
| ENABLE_COLUMN_METADATA | | [SQLITE_ENABLE_COLUMN_METADATA](https://sqlite.org/c3ref/column_database_name.html) |
| ENABLE_DBPAGE_VTAB | | [SQLITE_ENABLE_DBPAGE_VTAB](https://sqlite.org/dbpage.html) |
| ENABLE_DBSTAT_VTAB | | [SQLITE_ENABLE_DBSTAT_VTAB](https://sqlite.org/dbstat.html) |
| ENABLE_FTS4 | | [SQLITE_ENABLE_FTS4](https://sqlite.org/fts3.html) |
| ENABLE_FTS5 | Y | [SQLITE_ENABLE_FTS5](https://sqlite.org/fts5.html) |
| ENABLE_GEOPOLY | | [SQLITE_ENABLE_GEOPOLY](https://sqlite.org/geopoly.html) |
| ENABLE_MATH_FUNCTIONS | Y | [SQLITE_ENABLE_MATH_FUNCTIONS](https://sqlite.org/lang_mathfunc.html) |
| ENABLE_NORMALIZE | | [SQLITE_ENABLE_NORMALIZE](https://sqlite.org/c3ref/expanded_sql.html) |
| ENABLE_PREUPDATE_HOOK | | [SQLITE_ENABLE_PREUPDATE_HOOK](https://sqlite.org/c3ref/preupdate_blobwrite.html) |
| ENABLE_RTREE | Y | [SQLITE_ENABLE_RTREE](https://sqlite.org/rtree.html) |
| ENABLE_SESSION | | [SQLITE_ENABLE_SESSION](https://sqlite.org/sessionintro.html) |
| ENABLE_SNAPSHOT | Y | [SQLITE_ENABLE_SNAPSHOT](https://sqlite.org/c3ref/snapshot.html) |
| ENABLE_STMTVTAB | Y | [SQLITE_ENABLE_STMTVTAB](https://sqlite.org/stmt.html) |
| ENABLE_STAT4 | Y | [SQLITE_ENABLE_STAT4](https://sqlite.org/fileformat2.html#stat4tab) |

> [!NOTE]
> The `ENABLE_SESSION` trait also sets the `ENABLE_PREUPDATE_HOOK` trait.

## License

SQLite is in the [public domain](https://sqlite.org/copyright.html).
