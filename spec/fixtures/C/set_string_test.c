#include <string.h>

/*
 * <tt>int set_string_test(const char *string, char **result)</tt>
 *
 * takes an <tt>string-like</tt> argument as input and duplicates
 * the strings in an output string (which must also be passed as a
 * third input argument.
 *
 * The user is responsible to make sure that all pointers are correctly
 * setup.
 */

int set_string_test(const char *string, char **result)
{
  int res = 0;

  *result = strdup(string);

  return res;
}
