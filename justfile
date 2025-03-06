build-release:
    BUILD_BENCHMARK=1 CORE_EXTENSIONS='autocomplete;icu;parquet;json;tpch;httpfs' GEN=ninja make -j 16

benchmarkbloom: build-release
    sed -i -e 's/.*hash_join_bloom_filter.*/set hash_join_bloom_filter=true;/' benchmark/imdb/imdb.benchmark.in
    build/release/benchmark/benchmark_runner "benchmark/imdb/.*" 1> imdb_with_bloom.log

benchmarknobloom: build-release
    sed -i -e 's/.*hash_join_bloom_filter.*/set hash_join_bloom_filter=false;/' benchmark/imdb/imdb.benchmark.in
    build/release/benchmark/benchmark_runner "benchmark/imdb/.*" 1> imdb_without_bloom.log

plot:
    conda init
    conda activate duckdb
    python python plot_bloom_filter.py

measure_cycles:
    build/release/benchmark/benchmark_runner "benchmark/imdb/.*" 1> cycle_counts.log
    grep -A 1 "cycles,  kcycles, instructions" cycle_counts.txt | cut -d ',' -f 1 | grep "[0-9]" | awk '{ total += $1; count++ } END { print total/count }'

singleimdb:
    build/release/duckdb -init benchmark/imdb_plan_cost/queries/07c.sql -no-stdin duckdb_benchmark_data/imdb.duckdb
