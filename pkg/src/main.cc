#include "foo.hh"

// most be included after c++ headers!
#include <stdio.h>
#include "Rdefines.h"

#ifdef __cplusplus
extern "C" {
#endif

static SEXP type_tag;

/* macro to check if ptr valid */
#define CHECK_PTR(s) do { \
	if (TYPEOF(s) != EXTPTRSXP || \
		R_ExternalPtrTag(s) != type_tag) \
		error("External pointer not valid!"); \
} while (0)

/* Install the type tag */
SEXP TESTCPP_init(void)
{
	type_tag = install("TYPE_TAG");
	return R_NilValue;
}

/* Create a Foo object */
SEXP TESTCPP_newFoo(SEXP str, SEXP fun)
{
	fooPtr p = new Foo(CHAR(STRING_ELT(str, 0)));
	if (p == NULL)
		return R_NilValue;
	else {
		SEXP val = R_MakeExternalPtr(p, type_tag, R_NilValue);
		R_RegisterFinalizer(val, fun);
		return val;
	}
}

/* Remove the Foo object */
SEXP TESTCPP_closeFoo(SEXP s)
{
	CHECK_PTR(s);
	fooPtr p = (fooPtr)R_ExternalPtrAddr(s);
	if (p != NULL) {
		delete p;
		R_ClearExternalPtr(s);
	}
	return R_NilValue;
}

/* Get the string in the Foo object */
SEXP TESTCPP_getFoo(SEXP s)
{
	CHECK_PTR(s);
	fooPtr p = (fooPtr)R_ExternalPtrAddr(s);
	if (p == NULL) error("pointer is NULL");
	SEXP val;
	PROTECT(val = allocVector(STRSXP, 1));
	SET_STRING_ELT(val, 0, mkChar((p->get()).c_str()) );
	UNPROTECT(1);
	return val;
}

/* Set the string in the Foo object */
SEXP TESTCPP_setFoo(SEXP s, SEXP str)
{
	CHECK_PTR(s);
	fooPtr p = (fooPtr)R_ExternalPtrAddr(s);
	if (p == NULL) error("pointer is NULL");
	p->set((string)CHAR(STRING_ELT(str, 0)));
	return R_NilValue;
}

#ifdef __cplusplus
}
#endif
