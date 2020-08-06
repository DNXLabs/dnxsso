install:
	@pip install '.[dev,test]' .

test:
	@py.test

unit:
	@python -m unittest

coverage:
	@coverage run --source=dnxsso -m pytest tests/

tox:
	@tox -vv

tf:
	@AWS_PROFILE=dev terraform refresh

.PHONY: doc
doc:
	@py.test --cov-report html:local/coverage --cov=dnxsso tests/
	@py.test --cov-report xml:local/coverage.xml --cov=dnxsso tests/

.PHONY: dist
dist:
	@python setup.py sdist bdist_wheel

# Usage: make ver version=0.1.0
ver: dist/dnxsso-$(version).tar.gz
	@echo $(version)

testpypi: dist/dnxsso-$(version).tar.gz
	@twine upload --repository testpypi --sign dist/dnxsso-$(version)*

pypi: dist/dnxsso-$(version).tar.gz
	@twine upload --sign dist/dnxsso-$(version)*
