gen-protos:
	chmod +x ./scripts/gen-protos.sh && ./scripts/gen-protos.sh

run-builder-for-mobile:
	@echo "running builder for mobile..." && \
	cd mobile && \
	dart run build_runner watch --delete-conflicting-outputs


.PHONY: gen-protos run-builder-for-mobile