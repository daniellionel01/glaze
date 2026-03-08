import * as $atom from "../../../gleam_erlang/gleam/erlang/atom.mjs";
import * as $process from "../../../gleam_erlang/gleam/erlang/process.mjs";
import * as $actor from "../../../gleam_otp/gleam/otp/actor.mjs";
import * as $dynamic from "../../../gleam_stdlib/gleam/dynamic.mjs";
import * as $decode from "../../../gleam_stdlib/gleam/dynamic/decode.mjs";
import * as $option from "../../../gleam_stdlib/gleam/option.mjs";
import { None, Some } from "../../../gleam_stdlib/gleam/option.mjs";
import * as $result from "../../../gleam_stdlib/gleam/result.mjs";
import * as $string from "../../../gleam_stdlib/gleam/string.mjs";
import * as $logging from "../../../logging/logging.mjs";
import { CustomType as $CustomType } from "../../gleam.mjs";
import * as $socket from "../../glisten/socket.mjs";
import * as $options from "../../glisten/socket/options.mjs";
import * as $transport from "../../glisten/transport.mjs";

export class Close extends $CustomType {}
export const InternalMessage$Close = () => new Close();
export const InternalMessage$isClose = (value) => value instanceof Close;

export class Ready extends $CustomType {}
export const InternalMessage$Ready = () => new Ready();
export const InternalMessage$isReady = (value) => value instanceof Ready;

export class ReceiveMessage extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const InternalMessage$ReceiveMessage = ($0) => new ReceiveMessage($0);
export const InternalMessage$isReceiveMessage = (value) =>
  value instanceof ReceiveMessage;
export const InternalMessage$ReceiveMessage$0 = (value) => value[0];

export class SslClosed extends $CustomType {}
export const InternalMessage$SslClosed = () => new SslClosed();
export const InternalMessage$isSslClosed = (value) =>
  value instanceof SslClosed;

export class TcpClosed extends $CustomType {}
export const InternalMessage$TcpClosed = () => new TcpClosed();
export const InternalMessage$isTcpClosed = (value) =>
  value instanceof TcpClosed;

export class Internal extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const Message$Internal = ($0) => new Internal($0);
export const Message$isInternal = (value) => value instanceof Internal;
export const Message$Internal$0 = (value) => value[0];

export class User extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const Message$User = ($0) => new User($0);
export const Message$isUser = (value) => value instanceof User;
export const Message$User$0 = (value) => value[0];

export class Packet extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const LoopMessage$Packet = ($0) => new Packet($0);
export const LoopMessage$isPacket = (value) => value instanceof Packet;
export const LoopMessage$Packet$0 = (value) => value[0];

export class Custom extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const LoopMessage$Custom = ($0) => new Custom($0);
export const LoopMessage$isCustom = (value) => value instanceof Custom;
export const LoopMessage$Custom$0 = (value) => value[0];

export class LoopState extends $CustomType {
  constructor(client_ip, socket, sender, transport, state) {
    super();
    this.client_ip = client_ip;
    this.socket = socket;
    this.sender = sender;
    this.transport = transport;
    this.state = state;
  }
}
export const LoopState$LoopState = (client_ip, socket, sender, transport, state) =>
  new LoopState(client_ip, socket, sender, transport, state);
export const LoopState$isLoopState = (value) => value instanceof LoopState;
export const LoopState$LoopState$client_ip = (value) => value.client_ip;
export const LoopState$LoopState$0 = (value) => value.client_ip;
export const LoopState$LoopState$socket = (value) => value.socket;
export const LoopState$LoopState$1 = (value) => value.socket;
export const LoopState$LoopState$sender = (value) => value.sender;
export const LoopState$LoopState$2 = (value) => value.sender;
export const LoopState$LoopState$transport = (value) => value.transport;
export const LoopState$LoopState$3 = (value) => value.transport;
export const LoopState$LoopState$state = (value) => value.state;
export const LoopState$LoopState$4 = (value) => value.state;

export class Connection extends $CustomType {
  constructor(client_ip, socket, transport, sender) {
    super();
    this.client_ip = client_ip;
    this.socket = socket;
    this.transport = transport;
    this.sender = sender;
  }
}
export const Connection$Connection = (client_ip, socket, transport, sender) =>
  new Connection(client_ip, socket, transport, sender);
export const Connection$isConnection = (value) => value instanceof Connection;
export const Connection$Connection$client_ip = (value) => value.client_ip;
export const Connection$Connection$0 = (value) => value.client_ip;
export const Connection$Connection$socket = (value) => value.socket;
export const Connection$Connection$1 = (value) => value.socket;
export const Connection$Connection$transport = (value) => value.transport;
export const Connection$Connection$2 = (value) => value.transport;
export const Connection$Connection$sender = (value) => value.sender;
export const Connection$Connection$3 = (value) => value.sender;

export class Continue extends $CustomType {
  constructor(state, selector) {
    super();
    this.state = state;
    this.selector = selector;
  }
}
export const Next$Continue = (state, selector) => new Continue(state, selector);
export const Next$isContinue = (value) => value instanceof Continue;
export const Next$Continue$state = (value) => value.state;
export const Next$Continue$0 = (value) => value.state;
export const Next$Continue$selector = (value) => value.selector;
export const Next$Continue$1 = (value) => value.selector;

export class NormalStop extends $CustomType {}
export const Next$NormalStop = () => new NormalStop();
export const Next$isNormalStop = (value) => value instanceof NormalStop;

export class AbnormalStop extends $CustomType {
  constructor(reason) {
    super();
    this.reason = reason;
  }
}
export const Next$AbnormalStop = (reason) => new AbnormalStop(reason);
export const Next$isAbnormalStop = (value) => value instanceof AbnormalStop;
export const Next$AbnormalStop$reason = (value) => value.reason;
export const Next$AbnormalStop$0 = (value) => value.reason;

export class Handler extends $CustomType {
  constructor(socket, loop, on_init, on_close, transport) {
    super();
    this.socket = socket;
    this.loop = loop;
    this.on_init = on_init;
    this.on_close = on_close;
    this.transport = transport;
  }
}
export const Handler$Handler = (socket, loop, on_init, on_close, transport) =>
  new Handler(socket, loop, on_init, on_close, transport);
export const Handler$isHandler = (value) => value instanceof Handler;
export const Handler$Handler$socket = (value) => value.socket;
export const Handler$Handler$0 = (value) => value.socket;
export const Handler$Handler$loop = (value) => value.loop;
export const Handler$Handler$1 = (value) => value.loop;
export const Handler$Handler$on_init = (value) => value.on_init;
export const Handler$Handler$2 = (value) => value.on_init;
export const Handler$Handler$on_close = (value) => value.on_close;
export const Handler$Handler$3 = (value) => value.on_close;
export const Handler$Handler$transport = (value) => value.transport;
export const Handler$Handler$4 = (value) => value.transport;

export function continue$(state) {
  return new Continue(state, new None());
}

export function with_selector(next, selector) {
  if (next instanceof Continue) {
    let state = next.state;
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
