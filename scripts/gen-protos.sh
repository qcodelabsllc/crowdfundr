# shellcheck disable=SC2046
PROTO_PATH=/Users/quabynah/src/projects/qcodelabsllc/crowdfundr/protos

# define the path to the core-server directory
CORE_SERVER_DIR=/Users/quabynah/src/projects/qcodelabsllc/crowdfundr/crowdfunding

# define the path to the auth-server directory
AUTH_SERVER_DIR=/Users/quabynah/src/projects/qcodelabsllc/crowdfundr/auth

# define the path to the mobile directory
MOBILE_DIR=/Users/quabynah/src/projects/qcodelabsllc/crowdfundr/mobile
MOBILE_OUT_DIR=$MOBILE_DIR/lib/generated/protos

mkdir -p "$MOBILE_DIR/lib/generated/protos"
mkdir -p "$CORE_SERVER_DIR/gen"
mkdir -p "$AUTH_SERVER_DIR/gen"

# generate for core-server
protoc -I=$PROTO_PATH --go_out=$CORE_SERVER_DIR/gen --go_opt=paths=source_relative \
  --go-grpc_out=$CORE_SERVER_DIR/gen --go-grpc_opt=paths=source_relative \
  $(find $PROTO_PATH -iname "*.proto")

# generate for flutter using dart
protoc -I=$PROTO_PATH \
  --dart_out=grpc:$MOBILE_OUT_DIR \
  $(find $PROTO_PATH -iname "*.proto")