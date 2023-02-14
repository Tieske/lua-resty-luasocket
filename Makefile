.PHONY: test lint

test:
		@busted -v -o gtest spec
		@t/reindex t/*.t
		@prove

lint:
		@luacheck .
