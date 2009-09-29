#include <iostream>
#include <string>

#include "Rdefines.h"

using namespace std;

typedef class Foo* fooPtr;

class Foo {
public:

    /* declare construstors inline */
    Foo(string t) {
        Rprintf("Constructor Foo called\n");
        str = t;
    }
    ~Foo() {Rprintf("Destructor Foo called\n"); }

    /* defined in Foo.cc */
    string get();
    void set(string s);

private:

    string str;
};

