#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define NUM_NODES 2000 

// Adjacency Matrix and traversal data structures
bool graph[NUM_NODES][NUM_NODES];
bool visited[NUM_NODES];
int queue[NUM_NODES];

int main() {
    printf("Starting BFS Traversal...\n");

    // Initialize graph with a pseudo-random edge pattern
    for(int i = 0; i < NUM_NODES; i++) {
        visited[i] = false;
        for(int j = 0; j < NUM_NODES; j++) {
            // Create scattered edges to randomize memory access later
            if ((i + j) % 7 == 0 || (i ^ j) % 13 == 0) {
                graph[i][j] = true;
            } else {
                graph[i][j] = false;
            }
        }
    }

    int front = 0, rear = 0;
    int start_node = 0;
    int nodes_visited = 0;

    // Enqueue start_node
    queue[rear++] = start_node;
    visited[start_node] = true;

    // Core BFS Loop
    while (front < rear) {
        int current = queue[front++];
        nodes_visited++;

        for (int i = 0; i < NUM_NODES; i++) {
            if (graph[current][i] && !visited[i]) {
                queue[rear++] = i;
                visited[i] = true;
            }
        }
    }

    printf("BFS complete. Total nodes visited: %d\n", nodes_visited);
    return 0;
}