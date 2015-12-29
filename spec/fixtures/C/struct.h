#if !defined(_STRUCT_H_)
# define _STRUCT_H_

typedef struct
{
   int var_1;
   double var_2;
   char var_3;

} STRUCT;

typedef struct
{
   int var_1;
   double var_2;
   char *var_3; /* this is supposed to allocate a string which will get freed upon deletion */

} STRUCT_WITH_MEMALLOC;

#endif /* !defined(_STRUCT_H_) */
