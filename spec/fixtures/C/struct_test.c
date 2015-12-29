#include <string.h>
#include "struct.h"

/*
 * <tt>unmanaged_struct_test(STRUCT *p, STRUCT **result)</tt>
 *
 * picks up a STRUCT as input (pointer) and copies its content into some
 * pre-allocated memory form
 */

void unmanaged_struct_test(STRUCT *p, STRUCT **result)
{
    memcpy(*result, p, sizeof(STRUCT));
}
