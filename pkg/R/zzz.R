.First.lib <- function(lib, pkg) {
	library.dynam("testcpp", pkg, lib)
	.Call("TESTCPP_init")
}
