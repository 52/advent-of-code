// This code is licensed under the MIT license.
// (C) 2022 by Max Karou

#include <stdio.h>
#include <stdlib.h>

#define NORMALIZE(a)          \
  (a == 'A' || a == 'X'   ? 0 \
   : a == 'B' || a == 'Y' ? 1 \
   : a == 'C' || a == 'Z' ? 2 \
                          : -1)

int score(int x, int y) {
  int matrix[3][3] = {
      {1 + 3, 2 + 6, 3 + 0}, {1 + 0, 2 + 3, 3 + 6}, {1 + 6, 2 + 0, 3 + 3}};

  return matrix[x][y];
}

int a(FILE* file) {
  char buff[256];
  int max = 0;

  while (fgets(buff, sizeof(buff), file)) {
    int x = NORMALIZE(buff[0]);
    int y = NORMALIZE(buff[2]);

    max += score(x, y);
  }

  return max;
}

int b(FILE* file) {
  char buff[256];
  int map[3] = {2, 3, 1};
  int max = 0;

  while (fgets(buff, sizeof(buff), file)) {
    int x = NORMALIZE(buff[0]);
    int y = NORMALIZE(buff[2]);

    max += score(x, (x + map[y]) % 3);
  }

  return max;
}

int main(int argc, char* argv[]) {
  char const* const fileName = argv[1];
  FILE* file = fopen(fileName, "r");

  printf("Part 1 Solution: %d\n", a(file));
  rewind(file);
  printf("Part 2 Solution: %d\n", b(file));
  fclose(file);
  exit(EXIT_SUCCESS);
}