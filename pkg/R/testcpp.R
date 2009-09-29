createFoo<-function(str) {
	.Call("TESTCPP_newFoo", str, .closeFoo)
}

.closeFoo <- function(p) {
	.Call("TESTCPP_closeFoo", p);
}

getStrFoo<-function(p) {
	.Call("TESTCPP_getFoo", p)
}

setStrFoo<-function(p, str) {
	invisible(.Call("TESTCPP_setFoo", p, str))
}
