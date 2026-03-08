import * as $exception from "../exception/exception.mjs";
import * as $process from "../gleam_erlang/gleam/erlang/process.mjs";
import * as $gleam_http from "../gleam_http/gleam/http.mjs";
import { Http, Https } from "../gleam_http/gleam/http.mjs";
import * as $request from "../gleam_http/gleam/http/request.mjs";
import * as $response from "../gleam_http/gleam/http/response.mjs";
import * as $actor from "../gleam_otp/gleam/otp/actor.mjs";
import * as $static_supervisor from "../gleam_otp/gleam/otp/static_supervisor.mjs";
import * as $supervision from "../gleam_otp/gleam/otp/supervision.mjs";
import * as $bit_array from "../gleam_stdlib/gleam/bit_array.mjs";
import * as $bytes_tree from "../gleam_stdlib/gleam/bytes_tree.mjs";
import * as $function from "../gleam_stdlib/gleam/function.mjs";
import * as $int from "../gleam_stdlib/gleam/int.mjs";
import * as $io from "../gleam_stdlib/gleam/io.mjs";
import * as $list from "../gleam_stdlib/gleam/list.mjs";
import * as $option from "../gleam_stdlib/gleam/option.mjs";
import { None, Some } from "../gleam_stdlib/gleam/option.mjs";
import * as $result from "../gleam_stdlib/gleam/result.mjs";
import * as $string from "../gleam_stdlib/gleam/string.mjs";
import * as $string_tree from "../gleam_stdlib/gleam/string_tree.mjs";
import * as $yielder from "../gleam_yielder/gleam/yielder.mjs";
import * as $glisten from "../glisten/glisten.mjs";
import * as $transport from "../glisten/glisten/transport.mjs";
import * as $gramps_websocket from "../gramps/gramps/websocket.mjs";
import { BinaryFrame, Data, TextFrame } from "../gramps/gramps/websocket.mjs";
import * as $logging from "../logging/logging.mjs";
import { Ok, Error, CustomType as $CustomType } from "./gleam.mjs";
import * as $buffer from "./mist/internal/buffer.mjs";
import { Buffer } from "./mist/internal/buffer.mjs";
import * as $encoder from "./mist/internal/encoder.mjs";
import * as $file from "./mist/internal/file.mjs";
import * as $handler from "./mist/internal/handler.mjs";
import * as $http from "./mist/internal/http.mjs";
import {
  Bytes as InternalBytes,
  Chunked as InternalChunked,
  File as InternalFile,
  ServerSentEvents as InternalServerSentEvents,
  Websocket as InternalWebsocket,
} from "./mist/internal/http.mjs";
import * as $next from "./mist/internal/next.mjs";
import * as $websocket from "./mist/internal/websocket.mjs";
import { Internal, User } from "./mist/internal/websocket.mjs";

class Continue extends $CustomType {
  constructor($0, $1) {
    super();
    this[0] = $0;
    this[1] = $1;
  }
}

class NormalStop extends $CustomType {}

class AbnormalStop extends $CustomType {
  constructor(reason) {
    super();
    this.reason = reason;
  }
}

export class IpV4 extends $CustomType {
  constructor($0, $1, $2, $3) {
    super();
    this[0] = $0;
    this[1] = $1;
    this[2] = $2;
    this[3] = $3;
  }
}
export const IpAddress$IpV4 = ($0, $1, $2, $3) => new IpV4($0, $1, $2, $3);
export const IpAddress$isIpV4 = (value) => value instanceof IpV4;
export const IpAddress$IpV4$0 = (value) => value[0];
export const IpAddress$IpV4$1 = (value) => value[1];
export const IpAddress$IpV4$2 = (value) => value[2];
export const IpAddress$IpV4$3 = (value) => value[3];

export class IpV6 extends $CustomType {
  constructor($0, $1, $2, $3, $4, $5, $6, $7) {
    super();
    this[0] = $0;
    this[1] = $1;
    this[2] = $2;
    this[3] = $3;
    this[4] = $4;
    this[5] = $5;
    this[6] = $6;
    this[7] = $7;
  }
}
export const IpAddress$IpV6 = ($0, $1, $2, $3, $4, $5, $6, $7) =>
  new IpV6($0, $1, $2, $3, $4, $5, $6, $7);
export const IpAddress$isIpV6 = (value) => value instanceof IpV6;
export const IpAddress$IpV6$0 = (value) => value[0];
export const IpAddress$IpV6$1 = (value) => value[1];
export const IpAddress$IpV6$2 = (value) => value[2];
export const IpAddress$IpV6$3 = (value) => value[3];
export const IpAddress$IpV6$4 = (value) => value[4];
export const IpAddress$IpV6$5 = (value) => value[5];
export const IpAddress$IpV6$6 = (value) => value[6];
export const IpAddress$IpV6$7 = (value) => value[7];

export class ConnectionInfo extends $CustomType {
  constructor(port, ip_address) {
    super();
    this.port = port;
    this.ip_address = ip_address;
  }
}
export const ConnectionInfo$ConnectionInfo = (port, ip_address) =>
  new ConnectionInfo(port, ip_address);
export const ConnectionInfo$isConnectionInfo = (value) =>
  value instanceof ConnectionInfo;
export const ConnectionInfo$ConnectionInfo$port = (value) => value.port;
export const ConnectionInfo$ConnectionInfo$0 = (value) => value.port;
export const ConnectionInfo$ConnectionInfo$ip_address = (value) =>
  value.ip_address;
export const ConnectionInfo$ConnectionInfo$1 = (value) => value.ip_address;

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

/**
 * See `mist.send_file` to use this response type.
 */
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

export class IsDir extends $CustomType {}
export const FileError$IsDir = () => new IsDir();
export const FileError$isIsDir = (value) => value instanceof IsDir;

export class NoAccess extends $CustomType {}
export const FileError$NoAccess = () => new NoAccess();
export const FileError$isNoAccess = (value) => value instanceof NoAccess;

export class NoEntry extends $CustomType {}
export const FileError$NoEntry = () => new NoEntry();
export const FileError$isNoEntry = (value) => value instanceof NoEntry;

export class UnknownFileError extends $CustomType {}
export const FileError$UnknownFileError = () => new UnknownFileError();
export const FileError$isUnknownFileError = (value) =>
  value instanceof UnknownFileError;

export class ExcessBody extends $CustomType {}
export const ReadError$ExcessBody = () => new ExcessBody();
export const ReadError$isExcessBody = (value) => value instanceof ExcessBody;

export class MalformedBody extends $CustomType {}
export const ReadError$MalformedBody = () => new MalformedBody();
export const ReadError$isMalformedBody = (value) =>
  value instanceof MalformedBody;

export class Chunk extends $CustomType {
  constructor(data, consume) {
    super();
    this.data = data;
    this.consume = consume;
  }
}
export const Chunk$Chunk = (data, consume) => new Chunk(data, consume);
export const Chunk$isChunk = (value) => value instanceof Chunk;
export const Chunk$Chunk$data = (value) => value.data;
export const Chunk$Chunk$0 = (value) => value.data;
export const Chunk$Chunk$consume = (value) => value.consume;
export const Chunk$Chunk$1 = (value) => value.consume;

export class Done extends $CustomType {}
export const Chunk$Done = () => new Done();
export const Chunk$isDone = (value) => value instanceof Done;

class ChunkState extends $CustomType {
  constructor(data_buffer, chunk_buffer, done) {
    super();
    this.data_buffer = data_buffer;
    this.chunk_buffer = chunk_buffer;
    this.done = done;
  }
}

class CertKeyFiles extends $CustomType {
  constructor(certfile, keyfile) {
    super();
    this.certfile = certfile;
    this.keyfile = keyfile;
  }
}

class Builder extends $CustomType {
  constructor(port, handler, after_start, interface$, ipv6_support, tls_options) {
    super();
    this.port = port;
    this.handler = handler;
    this.after_start = after_start;
    this.interface = interface$;
    this.ipv6_support = ipv6_support;
    this.tls_options = tls_options;
  }
}

export class Assigned extends $CustomType {}
export const Port$Assigned = () => new Assigned();
export const Port$isAssigned = (value) => value instanceof Assigned;

export class Provided extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const Port$Provided = ($0) => new Provided($0);
export const Port$isProvided = (value) => value instanceof Provided;
export const Port$Provided$0 = (value) => value[0];

export class Text extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const WebsocketMessage$Text = ($0) => new Text($0);
export const WebsocketMessage$isText = (value) => value instanceof Text;
export const WebsocketMessage$Text$0 = (value) => value[0];

export class Binary extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const WebsocketMessage$Binary = ($0) => new Binary($0);
export const WebsocketMessage$isBinary = (value) => value instanceof Binary;
export const WebsocketMessage$Binary$0 = (value) => value[0];

export class Closed extends $CustomType {}
export const WebsocketMessage$Closed = () => new Closed();
export const WebsocketMessage$isClosed = (value) => value instanceof Closed;

export class Shutdown extends $CustomType {}
export const WebsocketMessage$Shutdown = () => new Shutdown();
export const WebsocketMessage$isShutdown = (value) => value instanceof Shutdown;

export class Custom extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const WebsocketMessage$Custom = ($0) => new Custom($0);
export const WebsocketMessage$isCustom = (value) => value instanceof Custom;
export const WebsocketMessage$Custom$0 = (value) => value[0];

class SSEConnection extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}

class SSEEvent extends $CustomType {
  constructor(id, event, retry, data) {
    super();
    this.id = id;
    this.event = event;
    this.retry = retry;
    this.data = data;
  }
}

export function continue$(state) {
  return new Continue(state, new None());
}

export function with_selector(next, selector) {
  if (next instanceof Continue) {
    let state = next[0];
    return new Continue(state, new Some(selector));
  } else {
    return next;
  }
}

export function stop() {
  return new NormalStop();
}

export function stop_abnormal(reason) {
  return new AbnormalStop(reason);
}

function convert_next(next) {
  if (next instanceof Continue) {
    let state = next[0];
    let selector = next[1];
    return new $next.Continue(state, selector);
  } else if (next instanceof NormalStop) {
    return new $next.NormalStop();
  } else {
    let reason = next.reason;
    return new $next.AbnormalStop(reason);
  }
}

function to_mist_ip_address(ip) {
  if (ip instanceof $glisten.IpV4) {
    let a = ip[0];
    let b = ip[1];
    let c = ip[2];
    let d = ip[3];
    return new IpV4(a, b, c, d);
  } else {
    let a = ip[0];
    let b = ip[1];
    let c = ip[2];
    let d = ip[3];
    let e = ip[4];
    let f = ip[5];
    let g = ip[6];
    let h = ip[7];
    return new IpV6(a, b, c, d, e, f, g, h);
  }
}

function to_glisten_ip_address(ip) {
  if (ip instanceof IpV4) {
    let a = ip[0];
    let b = ip[1];
    let c = ip[2];
    let d = ip[3];
    return new $glisten.IpV4(a, b, c, d);
  } else {
    let a = ip[0];
    let b = ip[1];
    let c = ip[2];
    let d = ip[3];
    let e = ip[4];
    let f = ip[5];
    let g = ip[6];
    let h = ip[7];
    return new $glisten.IpV6(a, b, c, d, e, f, g, h);
  }
}

/**
 * Convenience function for printing the `IpAddress` type. It will convert the
 * IPv6 loopback to the short-hand `::1`.
 */
export function ip_address_to_string(address) {
  return $glisten.ip_address_to_string(to_glisten_ip_address(address));
}

function convert_file_errors(err) {
  if (err instanceof $file.IsDir) {
    return new IsDir();
  } else if (err instanceof $file.NoAccess) {
    return new NoAccess();
  } else if (err instanceof $file.NoEntry) {
    return new NoEntry();
  } else {
    return new UnknownFileError();
  }
}

/**
 * Create a new `mist` handler with a given function. The default port is
 * 4000.
 */
export function new$(handler) {
  return new Builder(
    4000,
    handler,
    (port, scheme, interface$) => {
      let _block;
      if (interface$ instanceof IpV6) {
        _block = ("[" + ip_address_to_string(interface$)) + "]";
      } else {
        _block = ip_address_to_string(interface$);
      }
      let address = _block;
      let message = (((("Listening on " + $gleam_http.scheme_to_string(scheme)) + "://") + address) + ":") + $int.to_string(
        port,
      );
      return $io.println(message);
    },
    "localhost",
    false,
    new None(),
  );
}

/**
 * Assign a different listening port to the service.
 */
export function port(builder, port) {
  return new Builder(
    port,
    builder.handler,
    builder.after_start,
    builder.interface,
    builder.ipv6_support,
    builder.tls_options,
  );
}

/**
 * Override the default function to be called after the service starts. The
 * default is to log a message with the listening port.
 */
export function after_start(builder, after_start) {
  return new Builder(
    builder.port,
    builder.handler,
    after_start,
    builder.interface,
    builder.ipv6_support,
    builder.tls_options,
  );
}

/**
 * Specify an interface to listen on. This is a string that can have the
 * following values: "localhost", a valid IPv4 address (i.e. "127.0.0.1"), or
 * a valid IPv6 address (i.e. "::1"). An invalid value will cause the
 * application to crash.
 */
export function bind(builder, interface$) {
  return new Builder(
    builder.port,
    builder.handler,
    builder.after_start,
    interface$,
    builder.ipv6_support,
    builder.tls_options,
  );
}

/**
 * By default, `mist` will listen on `localhost` over IPv4. If you specify an
 * IPv4 address to bind to, it will still only serve over IPv4. Calling this
 * function will listen on both IPv4 and IPv6 for the given interface. If it is
 * not supported, your application will crash. If you provide an IPv6 address
 * to `mist.bind`, this function will have no effect.
 */
export function with_ipv6(builder) {
  return new Builder(
    builder.port,
    builder.handler,
    builder.after_start,
    builder.interface,
    true,
    builder.tls_options,
  );
}

function convert_body_types(resp) {
  let _block;
  let $ = resp.body;
  if ($ instanceof Websocket) {
    let selector = $[0];
    _block = new InternalWebsocket(selector);
  } else if ($ instanceof Bytes) {
    let data = $[0];
    _block = new InternalBytes(data);
  } else if ($ instanceof Chunked) {
    let iter = $[0];
    _block = new InternalChunked(iter);
  } else if ($ instanceof File) {
    let descriptor = $.descriptor;
    let offset = $.offset;
    let length = $.length;
    _block = new InternalFile(descriptor, offset, length);
  } else {
    let selector = $[0];
    _block = new InternalServerSentEvents(selector);
  }
  let new_body = _block;
  return $response.set_body(resp, new_body);
}

function internal_to_public_ws_message(msg) {
  if (msg instanceof Internal) {
    let $ = msg[0];
    if ($ instanceof Data) {
      let $1 = $[0];
      if ($1 instanceof TextFrame) {
        let data = $1.payload;
        let _pipe = data;
        let _pipe$1 = $bit_array.to_string(_pipe);
        return $result.map(_pipe$1, (var0) => { return new Text(var0); });
      } else {
        let data = $1.payload;
        return new Ok(new Binary(data));
      }
    } else {
      return new Error(undefined);
    }
  } else {
    let msg$1 = msg[0];
    return new Ok(new Custom(msg$1));
  }
}

export function event(data) {
  return new SSEEvent(new None(), new None(), new None(), data);
}

export function event_id(event, id) {
  return new SSEEvent(new Some(id), event.event, event.retry, event.data);
}

export function event_name(event, name) {
  return new SSEEvent(event.id, new Some(name), event.retry, event.data);
}

export function event_retry(event, retry) {
  return new SSEEvent(event.id, event.event, new Some(retry), event.data);
}
