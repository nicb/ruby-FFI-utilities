#include <string.h>
#include <stdlib.h>
#include "struct.h"

/*
 * <tt>unmanaged_struct_copy(STRUCT *p, STRUCT **result)</tt>
 *
 * picks up a STRUCT as input (pointer) and copies its content into some
 * pre-allocated memory form
 */

void unmanaged_struct_copy(STRUCT *p, STRUCT **result)
{
    memcpy(*result, p, sizeof(STRUCT));
}

/*
 * <tt>managed_struct_initialize(STRUCT *result, int, double)</tt>
 *
 * picks up a STRUCT_WITH_MEMALLOC as input (pointer) and loads its data
 * with memory allocation
 */

void managed_struct_initialize(STRUCT_WITH_MEMALLOC *result, int v1, double v2, const char *string)
{
    result->var_1 = v1;
    result->var_2 = v2;
    /* strdup() allocates memory to do its work... */
    result->var_3 = strdup(string);
}

/*
 * <tt>managed_struct_free(STRUCT_WITH_MEMALLOC *p)</tt>
 *
 * picks up a STRUCT_WITH_MEMALLOC as input (pointer) and loads its data
 * with memory allocation
 */

void managed_struct_free(STRUCT_WITH_MEMALLOC *p)
{
    /* ... and here we free it */
    free(p->var_3);
}
