import * as $atom from "../../../gleam_erlang/gleam/erlang/atom.mjs";
import * as $charlist from "../../../gleam_erlang/gleam/erlang/charlist.mjs";
import * as $process from "../../../gleam_erlang/gleam/erlang/process.mjs";
import * as $http from "../../../gleam_http/gleam/http.mjs";
import * as $request from "../../../gleam_http/gleam/http/request.mjs";
import * as $response from "../../../gleam_http/gleam/http/response.mjs";
import { Response } from "../../../gleam_http/gleam/http/response.mjs";
import * as $bit_array from "../../../gleam_stdlib/gleam/bit_array.mjs";
import * as $bytes_tree from "../../../gleam_stdlib/gleam/bytes_tree.mjs";
import * as $dict from "../../../gleam_stdlib/gleam/dict.mjs";
import * as $dynamic from "../../../gleam_stdlib/gleam/dynamic.mjs";
import * as $decode from "../../../gleam_stdlib/gleam/dynamic/decode.mjs";
import * as $int from "../../../gleam_stdlib/gleam/int.mjs";
import * as $list from "../../../gleam_stdlib/gleam/list.mjs";
import * as $option from "../../../gleam_stdlib/gleam/option.mjs";
import * as $pair from "../../../gleam_stdlib/gleam/pair.mjs";
import * as $result from "../../../gleam_stdlib/gleam/result.mjs";
import * as $string from "../../../gleam_stdlib/gleam/string.mjs";
import * as $yielder from "../../../gleam_yielder/gleam/yielder.mjs";
import * as $glisten from "../../../glisten/glisten.mjs";
import * as $transport from "../../../glisten/glisten/transport.mjs";
import * as $websocket from "../../../gramps/gramps/websocket.mjs";
import { Ok, CustomType as $CustomType, makeError, toBitArray } from "../../gleam.mjs";
import * as $buffer from "../../mist/internal/buffer.mjs";
import { Buffer } from "../../mist/internal/buffer.mjs";
import * as $clock from "../../mist/internal/clock.mjs";
import * as $encoder from "../../mist/internal/encoder.mjs";
import * as $file from "../../mist/internal/file.mjs";

const FILEPATH = "src/mist/internal/http.gleam";

export class Websocket extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const ResponseData$Websocket = ($0) => new Websocket($0);
export const ResponseData$isWebsocket = (value) => value instanceof Websocket;
export const ResponseData$Websocket$0 = (value) => value[0];

export class Bytes extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const ResponseData$Bytes = ($0) => new Bytes($0);
export const ResponseData$isBytes = (value) => value instanceof Bytes;
export const ResponseData$Bytes$0 = (value) => value[0];

export class Chunked extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const ResponseData$Chunked = ($0) => new Chunked($0);
export const ResponseData$isChunked = (value) => value instanceof Chunked;
export const ResponseData$Chunked$0 = (value) => value[0];

export class File extends $CustomType {
  constructor(descriptor, offset, length) {
    super();
    this.descriptor = descriptor;
    this.offset = offset;
    this.length = length;
  }
}
export const ResponseData$File = (descriptor, offset, length) =>
  new File(descriptor, offset, length);
export const ResponseData$isFile = (value) => value instanceof File;
export const ResponseData$File$descriptor = (value) => value.descriptor;
export const ResponseData$File$0 = (value) => value.descriptor;
export const ResponseData$File$offset = (value) => value.offset;
export const ResponseData$File$1 = (value) => value.offset;
export const ResponseData$File$length = (value) => value.length;
export const ResponseData$File$2 = (value) => value.length;

export class ServerSentEvents extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const ResponseData$ServerSentEvents = ($0) => new ServerSentEvents($0);
export const ResponseData$isServerSentEvents = (value) =>
  value instanceof ServerSentEvents;
export const ResponseData$ServerSentEvents$0 = (value) => value[0];

export class Connection extends $CustomType {
  constructor(body, socket, transport) {
    super();
    this.body = body;
    this.socket = socket;
    this.transport = transport;
  }
}
export const Connection$Connection = (body, socket, transport) =>
  new Connection(body, socket, transport);
export const Connection$isConnection = (value) => value instanceof Connection;
export const Connection$Connection$body = (value) => value.body;
export const Connection$Connection$0 = (value) => value.body;
export const Connection$Connection$socket = (value) => value.socket;
export const Connection$Connection$1 = (value) => value.socket;
export const Connection$Connection$transport = (value) => value.transport;
export const Connection$Connection$2 = (value) => value.transport;

export class Http extends $CustomType {}
export const PacketType$Http = () => new Http();
export const PacketType$isHttp = (value) => value instanceof Http;

export class HttphBin extends $CustomType {}
export const PacketType$HttphBin = () => new HttphBin();
export const PacketType$isHttphBin = (value) => value instanceof HttphBin;

export class HttpBin extends $CustomType {}
export const PacketType$HttpBin = () => new HttpBin();
export const PacketType$isHttpBin = (value) => value instanceof HttpBin;

export class AbsPath extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const HttpUri$AbsPath = ($0) => new AbsPath($0);
export const HttpUri$isAbsPath = (value) => value instanceof AbsPath;
export const HttpUri$AbsPath$0 = (value) => value[0];

export class HttpRequest extends $CustomType {
  constructor($0, $1, $2) {
    super();
    this[0] = $0;
    this[1] = $1;
    this[2] = $2;
  }
}
export const HttpPacket$HttpRequest = ($0, $1, $2) =>
  new HttpRequest($0, $1, $2);
export const HttpPacket$isHttpRequest = (value) => value instanceof HttpRequest;
export const HttpPacket$HttpRequest$0 = (value) => value[0];
export const HttpPacket$HttpRequest$1 = (value) => value[1];
export const HttpPacket$HttpRequest$2 = (value) => value[2];

export class HttpHeader extends $CustomType {
  constructor($0, $1, $2, $3) {
    super();
    this[0] = $0;
    this[1] = $1;
    this[2] = $2;
    this[3] = $3;
  }
}
export const HttpPacket$HttpHeader = ($0, $1, $2, $3) =>
  new HttpHeader($0, $1, $2, $3);
export const HttpPacket$isHttpHeader = (value) => value instanceof HttpHeader;
export const HttpPacket$HttpHeader$0 = (value) => value[0];
export const HttpPacket$HttpHeader$1 = (value) => value[1];
export const HttpPacket$HttpHeader$2 = (value) => value[2];
export const HttpPacket$HttpHeader$3 = (value) => value[3];

export class BinaryData extends $CustomType {
  constructor($0, $1) {
    super();
    this[0] = $0;
    this[1] = $1;
  }
}
export const DecodedPacket$BinaryData = ($0, $1) => new BinaryData($0, $1);
export const DecodedPacket$isBinaryData = (value) =>
  value instanceof BinaryData;
export const DecodedPacket$BinaryData$0 = (value) => value[0];
export const DecodedPacket$BinaryData$1 = (value) => value[1];

export class EndOfHeaders extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const DecodedPacket$EndOfHeaders = ($0) => new EndOfHeaders($0);
export const DecodedPacket$isEndOfHeaders = (value) =>
  value instanceof EndOfHeaders;
export const DecodedPacket$EndOfHeaders$0 = (value) => value[0];

export class MoreData extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const DecodedPacket$MoreData = ($0) => new MoreData($0);
export const DecodedPacket$isMoreData = (value) => value instanceof MoreData;
export const DecodedPacket$MoreData$0 = (value) => value[0];

export class Http2Upgrade extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const DecodedPacket$Http2Upgrade = ($0) => new Http2Upgrade($0);
export const DecodedPacket$isHttp2Upgrade = (value) =>
  value instanceof Http2Upgrade;
export const DecodedPacket$Http2Upgrade$0 = (value) => value[0];

export class MalformedRequest extends $CustomType {}
export const DecodeError$MalformedRequest = () => new MalformedRequest();
export const DecodeError$isMalformedRequest = (value) =>
  value instanceof MalformedRequest;

export class InvalidMethod extends $CustomType {}
export const DecodeError$InvalidMethod = () => new InvalidMethod();
export const DecodeError$isInvalidMethod = (value) =>
  value instanceof InvalidMethod;

export class InvalidPath extends $CustomType {}
export const DecodeError$InvalidPath = () => new InvalidPath();
export const DecodeError$isInvalidPath = (value) =>
  value instanceof InvalidPath;

export class UnknownHeader extends $CustomType {}
export const DecodeError$UnknownHeader = () => new UnknownHeader();
export const DecodeError$isUnknownHeader = (value) =>
  value instanceof UnknownHeader;

export class UnknownMethod extends $CustomType {}
export const DecodeError$UnknownMethod = () => new UnknownMethod();
export const DecodeError$isUnknownMethod = (value) =>
  value instanceof UnknownMethod;

export class InvalidBody extends $CustomType {}
export const DecodeError$InvalidBody = () => new InvalidBody();
export const DecodeError$isInvalidBody = (value) =>
  value instanceof InvalidBody;

export class DiscardPacket extends $CustomType {}
export const DecodeError$DiscardPacket = () => new DiscardPacket();
export const DecodeError$isDiscardPacket = (value) =>
  value instanceof DiscardPacket;

export class NoHostHeader extends $CustomType {}
export const DecodeError$NoHostHeader = () => new NoHostHeader();
export const DecodeError$isNoHostHeader = (value) =>
  value instanceof NoHostHeader;

export class InvalidHttpVersion extends $CustomType {}
export const DecodeError$InvalidHttpVersion = () => new InvalidHttpVersion();
export const DecodeError$isInvalidHttpVersion = (value) =>
  value instanceof InvalidHttpVersion;

export class Chunk extends $CustomType {
  constructor(data, buffer) {
    super();
    this.data = data;
    this.buffer = buffer;
  }
}
export const Chunk$Chunk = (data, buffer) => new Chunk(data, buffer);
export const Chunk$isChunk = (value) => value instanceof Chunk;
export const Chunk$Chunk$data = (value) => value.data;
export const Chunk$Chunk$0 = (value) => value.data;
export const Chunk$Chunk$buffer = (value) => value.buffer;
export const Chunk$Chunk$1 = (value) => value.buffer;

export class Complete extends $CustomType {}
export const Chunk$Complete = () => new Complete();
export const Chunk$isComplete = (value) => value instanceof Complete;

export class Http1 extends $CustomType {}
export const HttpVersion$Http1 = () => new Http1();
export const HttpVersion$isHttp1 = (value) => value instanceof Http1;

export class Http11 extends $CustomType {}
export const HttpVersion$Http11 = () => new Http11();
export const HttpVersion$isHttp11 = (value) => value instanceof Http11;

export class Http1Request extends $CustomType {
  constructor(request, version) {
    super();
    this.request = request;
    this.version = version;
  }
}
export const ParsedRequest$Http1Request = (request, version) =>
  new Http1Request(request, version);
export const ParsedRequest$isHttp1Request = (value) =>
  value instanceof Http1Request;
export const ParsedRequest$Http1Request$request = (value) => value.request;
export const ParsedRequest$Http1Request$0 = (value) => value.request;
export const ParsedRequest$Http1Request$version = (value) => value.version;
export const ParsedRequest$Http1Request$1 = (value) => value.version;

export class Upgrade extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const ParsedRequest$Upgrade = ($0) => new Upgrade($0);
export const ParsedRequest$isUpgrade = (value) => value instanceof Upgrade;
export const ParsedRequest$Upgrade$0 = (value) => value[0];

export class Initial extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const Body$Initial = ($0) => new Initial($0);
export const Body$isInitial = (value) => value instanceof Initial;
export const Body$Initial$0 = (value) => value[0];

export class Stream extends $CustomType {
  constructor(selector, data, remaining, attempts) {
    super();
    this.selector = selector;
    this.data = data;
    this.remaining = remaining;
    this.attempts = attempts;
  }
}
export const Body$Stream = (selector, data, remaining, attempts) =>
  new Stream(selector, data, remaining, attempts);
export const Body$isStream = (value) => value instanceof Stream;
export const Body$Stream$selector = (value) => value.selector;
export const Body$Stream$0 = (value) => value.selector;
export const Body$Stream$data = (value) => value.data;
export const Body$Stream$1 = (value) => value.data;
export const Body$Stream$remaining = (value) => value.remaining;
export const Body$Stream$2 = (value) => value.remaining;
export const Body$Stream$attempts = (value) => value.attempts;
export const Body$Stream$3 = (value) => value.attempts;

export class Sha extends $CustomType {}
export const ShaHash$Sha = () => new Sha();
export const ShaHash$isSha = (value) => value instanceof Sha;

const crnl = /* @__PURE__ */ toBitArray([13, 10]);

const websocket_key = "258EAFA5-E914-47DA-95CA-C5AB0DC85B11";

export function from_header(value) {
  let $ = $bit_array.to_string(value);
  let value$1;
  if ($ instanceof Ok) {
    value$1 = $[0];
  } else {
    throw makeError(
      "let_assert",
      FILEPATH,
      "mist/internal/http",
      78,
      "from_header",
      "Pattern match failed, no pattern matched the value.",
      {
        value: $,
        start: 1766,
        end: 1815,
        pattern_start: 1777,
        pattern_end: 1786
      }
    )
  }
  return $string.lowercase(value$1);
}

export function version_to_string(version) {
  if (version instanceof Http1) {
    return "1.0";
  } else {
    return "1.1";
  }
}

export function connection_close(resp) {
  return $response.set_header(resp, "connection", "close");
}

export function keep_alive(resp) {
  return $response.set_header(resp, "connection", "keep-alive");
}

export function maybe_keep_alive(resp) {
  let $ = $response.get_header(resp, "connection");
  if ($ instanceof Ok) {
    return resp;
  } else {
    return $response.set_header(resp, "connection", "keep-alive");
  }
}

function maybe_drop_body(resp, is_head_request) {
  if (is_head_request) {
    return $response.set_body(resp, $bytes_tree.new$());
  } else {
    return resp;
  }
}

export function add_content_length(when, length) {
  return (resp) => {
    if (when) {
      let _block;
      let _pipe = resp.headers;
      let _pipe$1 = $list.key_pop(_pipe, "content-length");
      _block = $result.lazy_unwrap(
        _pipe$1,
        () => { return ["", resp.headers]; },
      );
      let $ = _block;
      let headers;
      headers = $[1];
      let _pipe$2 = new Response(resp.status, headers, resp.body);
      return $response.set_header(
        _pipe$2,
        "content-length",
        $int.to_string(length),
      );
    } else {
      return resp;
    }
  };
}

function is_continue(req) {
  let _pipe = req.headers;
  let _pipe$1 = $list.find(
    _pipe,
    (tup) => {
      return ($pair.first(tup) === "expect") && ($pair.second(tup) === "100-continue");
    },
  );
  return $result.is_ok(_pipe$1);
}
