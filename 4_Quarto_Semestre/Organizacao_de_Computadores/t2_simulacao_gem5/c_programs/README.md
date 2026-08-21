# C Programs Overview

This folder contains three benchmark programs that exercise different aspects of processor and memory behavior:

- **Matrix multiplication (matrix.c)**: computationally heavy with a large amount of arithmetic logic unit (ALU) activity. It exhibits predictable, sequential memory access patterns.
- **Merge sort (sort.c)**: branch-heavy, designed to test branch predictor quality and control-flow performance.
- **Breadth-first search (bfs.c)**: features random memory access patterns, stressing the cache subsystem.
