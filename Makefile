# ESBuild + Terraform Lambda

BUILD_DIR=build
BUNDLE_NAME=index.js
PACKAGE_NAME=package.zip

.PHONY: package clean

package: ${BUILD_DIR}/${PACKAGE_NAME}

clean:
	rm -rf node_modules ${BUILD_DIR}

${BUILD_DIR}:
	mkdir -p ${BUILD_DIR}

${BUILD_DIR}/${PACKAGE_NAME}: ${BUILD_DIR}/${BUNDLE_NAME}
	(cd ${BUILD_DIR} && zip ${PACKAGE_NAME} ${BUNDLE_NAME})

${BUILD_DIR}/${BUNDLE_NAME}: ${BUILD_DIR} node_modules
	npx esbuild --bundle src/handler.ts --format=cjs --target=node14 --outfile=${BUILD_DIR}/${BUNDLE_NAME}

node_modules:
	npm ci
