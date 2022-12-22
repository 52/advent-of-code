// This code is licensed under the MIT license.
// (C) 2022 by Max Karou

#include <stdio.h>
#include <stdlib.h>

#define LENGTH(a) (sizeof(a) / sizeof(*a))

int a(FILE* file) {
  char buff[256];
  int max = 0;
  int curr = 0;

  while (fgets(buff, sizeof(buff), file)) {
    if (buff[0] == '\n') {
      if (curr > max) {
        max = curr;
      }
      curr = 0;
      continue;
    }

    curr += strtol(buff, NULL, 10);
  }

  return max;
}

int sum(int arr[3]) {
  int s = 0;
  for (int i = 0; i < 3; i++) s += arr[i];
  return s;
}

int b(FILE* file) {
  char buff[256];
  int max[3] = {0};
  int curr = 0;

  while (fgets(buff, sizeof(buff), file)) {
    if (buff[0] == '\n') {
      int s = 0;

      for (int i = 0; i < 3; i++) {
        if (max[i] < max[s]) s = i;
      }

      if (curr > max[s]) {
        max[s] = curr;
      };

      curr = 0;
      continue;
    }

    curr += strtol(buff, NULL, 10);
  }

  return sum(max);
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