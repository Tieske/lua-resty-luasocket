.PHONY: test lint docs

test:
	@busted -v -o gtest spec
	@t/reindex t/*.t
	@prove

lint:
	@luacheck .

docs:
	@ldoc .
