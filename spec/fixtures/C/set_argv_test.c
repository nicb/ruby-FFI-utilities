#include <string.h>

/*
 * <tt>set_argv_test(int argc, const char *argv[], char **result)</tt>
 *
 * takes an <tt>argv-like</tt> argument as input and duplicates
 * the strings in an output array of string (which must also be passed as a
 * third input argument.
 *
 * The user is responsible to make sure that result is big enough to hold all
 * results.
 */

int set_argv_test(int ac, const char *av[], char **result)
{
  int res = 0, k = 0;

  for(k = 0; k < ac; ++k)
    result[k] = strdup(av[k]);

  return res;
}
