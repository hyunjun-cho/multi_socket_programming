/* usleep
*/

#define _BSD_SOURCE
#include <unistd.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
  long t;
  sscanf (argv[1], "%ld", &t);
#ifdef DEBUG
  fprintf (stderr, "sleeping for %ld microseconds\n", t);
#endif
  usleep (t);
  return 0;
}
