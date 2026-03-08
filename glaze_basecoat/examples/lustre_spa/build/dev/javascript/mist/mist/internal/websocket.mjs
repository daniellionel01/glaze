import * as $exception from "../../../exception/exception.mjs";
import * as $atom from "../../../gleam_erlang/gleam/erlang/atom.mjs";
import * as $process from "../../../gleam_erlang/gleam/erlang/process.mjs";
import * as $actor from "../../../gleam_otp/gleam/otp/actor.mjs";
import * as $decode from "../../../gleam_stdlib/gleam/dynamic/decode.mjs";
import * as $option from "../../../gleam_stdlib/gleam/option.mjs";
import { None, Some } from "../../../gleam_stdlib/gleam/option.mjs";
import * as $result from "../../../gleam_stdlib/gleam/result.mjs";
import * as $string from "../../../gleam_stdlib/gleam/string.mjs";
import * as $glisten from "../../../glisten/glisten.mjs";
import * as $options from "../../../glisten/glisten/socket/options.mjs";
import * as $transport from "../../../glisten/glisten/transport.mjs";
import * as $websocket from "../../../gramps/gramps/websocket.mjs";
import { CloseFrame, Control, PingFrame } from "../../../gramps/gramps/websocket.mjs";
import * as $compression from "../../../gramps/gramps/websocket/compression.mjs";
import * as $logging from "../../../logging/logging.mjs";
import { CustomType as $CustomType } from "../../gleam.mjs";
import * as $next from "../../mist/internal/next.mjs";
import { AbnormalStop, Continue, NormalStop } from "../../mist/internal/next.mjs";

export class SocketMessage extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const ValidMessage$SocketMessage = ($0) => new SocketMessage($0);
export const ValidMessage$isSocketMessage = (value) =>
  value instanceof SocketMessage;
export const ValidMessage$SocketMessage$0 = (value) => value[0];

export class SocketClosedMessage extends $CustomType {}
export const ValidMessage$SocketClosedMessage = () => new SocketClosedMessage();
export const ValidMessage$isSocketClosedMessage = (value) =>
  value instanceof SocketClosedMessage;

export class UserMessage extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const ValidMessage$UserMessage = ($0) => new UserMessage($0);
export const ValidMessage$isUserMessage = (value) =>
  value instanceof UserMessage;
export const ValidMessage$UserMessage$0 = (value) => value[0];

export class Valid extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const WebsocketMessage$Valid = ($0) => new Valid($0);
export const WebsocketMessage$isValid = (value) => value instanceof Valid;
export const WebsocketMessage$Valid$0 = (value) => value[0];

export class Invalid extends $CustomType {}
export const WebsocketMessage$Invalid = () => new Invalid();
export const WebsocketMessage$isInvalid = (value) => value instanceof Invalid;

export class WebsocketConnection extends $CustomType {
  constructor(socket, transport, deflate) {
    super();
    this.socket = socket;
    this.transport = transport;
    this.deflate = deflate;
  }
}
export const WebsocketConnection$WebsocketConnection = (socket, transport, deflate) =>
  new WebsocketConnection(socket, transport, deflate);
export const WebsocketConnection$isWebsocketConnection = (value) =>
  value instanceof WebsocketConnection;
export const WebsocketConnection$WebsocketConnection$socket = (value) =>
  value.socket;
export const WebsocketConnection$WebsocketConnection$0 = (value) =>
  value.socket;
export const WebsocketConnection$WebsocketConnection$transport = (value) =>
  value.transport;
export const WebsocketConnection$WebsocketConnection$1 = (value) =>
  value.transport;
export const WebsocketConnection$WebsocketConnection$deflate = (value) =>
  value.deflate;
export const WebsocketConnection$WebsocketConnection$2 = (value) =>
  value.deflate;

export class Internal extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const HandlerMessage$Internal = ($0) => new Internal($0);
export const HandlerMessage$isInternal = (value) => value instanceof Internal;
export const HandlerMessage$Internal$0 = (value) => value[0];

export class User extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const HandlerMessage$User = ($0) => new User($0);
export const HandlerMessage$isUser = (value) => value instanceof User;
export const HandlerMessage$User$0 = (value) => value[0];

export class WebsocketState extends $CustomType {
  constructor(buffer, user, permessage_deflate) {
    super();
    this.buffer = buffer;
    this.user = user;
    this.permessage_deflate = permessage_deflate;
  }
}
export const WebsocketState$WebsocketState = (buffer, user, permessage_deflate) =>
  new WebsocketState(buffer, user, permessage_deflate);
export const WebsocketState$isWebsocketState = (value) =>
  value instanceof WebsocketState;
export const WebsocketState$WebsocketState$buffer = (value) => value.buffer;
export const WebsocketState$WebsocketState$0 = (value) => value.buffer;
export const WebsocketState$WebsocketState$user = (value) => value.user;
export const WebsocketState$WebsocketState$1 = (value) => value.user;
export const WebsocketState$WebsocketState$permessage_deflate = (value) =>
  value.permessage_deflate;
export const WebsocketState$WebsocketState$2 = (value) =>
  value.permessage_deflate;
