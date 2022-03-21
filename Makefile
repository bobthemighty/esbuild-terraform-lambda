# ESBuild + Terraform Lambda

BUILD=$(shell realpath build)
BUNDLE_NAME=index.js
PACKAGE_NAME=package.zip

PACKAGE=${BUILD}/${PACKAGE_NAME}
BUNDLE=${BUILD}/${BUNDLE_NAME}

.PHONY: package clean

package: ${PACKAGE}

clean:
	rm -rf node_modules ${BUILD}

${BUILD}:
	mkdir -p ${BUILD}

${PACKAGE}: ${BUNDLE}
	(cd ${BUILD} && zip ${PACKAGE_NAME} ${BUNDLE_NAME})

${BUNDLE}: ${BUILD} node_modules
	npx esbuild --bundle src/handler.ts --format=cjs --target=node14 --outfile=${BUNDLE}

node_modules:
	npm ci

deploy: package
		terraform -chdir=infra \
		apply -var package_filename=${PACKAGE}

destroy: package
		terraform -chdir=infra \
		destroy -var package_filename=${PACKAGE}
