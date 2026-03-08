import * as $crypto from "../../gleam_crypto/gleam/crypto.mjs";
import * as $bit_array from "../../gleam_stdlib/gleam/bit_array.mjs";
import * as $bool from "../../gleam_stdlib/gleam/bool.mjs";
import * as $bytes_tree from "../../gleam_stdlib/gleam/bytes_tree.mjs";
import * as $list from "../../gleam_stdlib/gleam/list.mjs";
import * as $option from "../../gleam_stdlib/gleam/option.mjs";
import { None, Some } from "../../gleam_stdlib/gleam/option.mjs";
import * as $result from "../../gleam_stdlib/gleam/result.mjs";
import * as $string from "../../gleam_stdlib/gleam/string.mjs";
import {
  Ok,
  Error,
  Empty as $Empty,
  prepend as listPrepend,
  CustomType as $CustomType,
  toBitArray,
  sizedInt,
} from "../gleam.mjs";
import * as $compression from "../gramps/websocket/compression.mjs";
import { ContextTakeover } from "../gramps/websocket/compression.mjs";

export class TextFrame extends $CustomType {
  constructor(payload) {
    super();
    this.payload = payload;
  }
}
export const DataFrame$TextFrame = (payload) => new TextFrame(payload);
export const DataFrame$isTextFrame = (value) => value instanceof TextFrame;
export const DataFrame$TextFrame$payload = (value) => value.payload;
export const DataFrame$TextFrame$0 = (value) => value.payload;

export class BinaryFrame extends $CustomType {
  constructor(payload) {
    super();
    this.payload = payload;
  }
}
export const DataFrame$BinaryFrame = (payload) => new BinaryFrame(payload);
export const DataFrame$isBinaryFrame = (value) => value instanceof BinaryFrame;
export const DataFrame$BinaryFrame$payload = (value) => value.payload;
export const DataFrame$BinaryFrame$0 = (value) => value.payload;

export const DataFrame$payload = (value) => value.payload;

export class NotProvided extends $CustomType {}
export const CloseReason$NotProvided = () => new NotProvided();
export const CloseReason$isNotProvided = (value) =>
  value instanceof NotProvided;

export class Normal extends $CustomType {
  constructor(body) {
    super();
    this.body = body;
  }
}
export const CloseReason$Normal = (body) => new Normal(body);
export const CloseReason$isNormal = (value) => value instanceof Normal;
export const CloseReason$Normal$body = (value) => value.body;
export const CloseReason$Normal$0 = (value) => value.body;

export class GoingAway extends $CustomType {
  constructor(body) {
    super();
    this.body = body;
  }
}
export const CloseReason$GoingAway = (body) => new GoingAway(body);
export const CloseReason$isGoingAway = (value) => value instanceof GoingAway;
export const CloseReason$GoingAway$body = (value) => value.body;
export const CloseReason$GoingAway$0 = (value) => value.body;

export class ProtocolError extends $CustomType {
  constructor(body) {
    super();
    this.body = body;
  }
}
export const CloseReason$ProtocolError = (body) => new ProtocolError(body);
export const CloseReason$isProtocolError = (value) =>
  value instanceof ProtocolError;
export const CloseReason$ProtocolError$body = (value) => value.body;
export const CloseReason$ProtocolError$0 = (value) => value.body;

export class UnexpectedDataType extends $CustomType {
  constructor(body) {
    super();
    this.body = body;
  }
}
export const CloseReason$UnexpectedDataType = (body) =>
  new UnexpectedDataType(body);
export const CloseReason$isUnexpectedDataType = (value) =>
  value instanceof UnexpectedDataType;
export const CloseReason$UnexpectedDataType$body = (value) => value.body;
export const CloseReason$UnexpectedDataType$0 = (value) => value.body;

export class InconsistentDataType extends $CustomType {
  constructor(body) {
    super();
    this.body = body;
  }
}
export const CloseReason$InconsistentDataType = (body) =>
  new InconsistentDataType(body);
export const CloseReason$isInconsistentDataType = (value) =>
  value instanceof InconsistentDataType;
export const CloseReason$InconsistentDataType$body = (value) => value.body;
export const CloseReason$InconsistentDataType$0 = (value) => value.body;

export class PolicyViolation extends $CustomType {
  constructor(body) {
    super();
    this.body = body;
  }
}
export const CloseReason$PolicyViolation = (body) => new PolicyViolation(body);
export const CloseReason$isPolicyViolation = (value) =>
  value instanceof PolicyViolation;
export const CloseReason$PolicyViolation$body = (value) => value.body;
export const CloseReason$PolicyViolation$0 = (value) => value.body;

export class MessageTooBig extends $CustomType {
  constructor(body) {
    super();
    this.body = body;
  }
}
export const CloseReason$MessageTooBig = (body) => new MessageTooBig(body);
export const CloseReason$isMessageTooBig = (value) =>
  value instanceof MessageTooBig;
export const CloseReason$MessageTooBig$body = (value) => value.body;
export const CloseReason$MessageTooBig$0 = (value) => value.body;

export class MissingExtensions extends $CustomType {
  constructor(body) {
    super();
    this.body = body;
  }
}
export const CloseReason$MissingExtensions = (body) =>
  new MissingExtensions(body);
export const CloseReason$isMissingExtensions = (value) =>
  value instanceof MissingExtensions;
export const CloseReason$MissingExtensions$body = (value) => value.body;
export const CloseReason$MissingExtensions$0 = (value) => value.body;

export class UnexpectedCondition extends $CustomType {
  constructor(body) {
    super();
    this.body = body;
  }
}
export const CloseReason$UnexpectedCondition = (body) =>
  new UnexpectedCondition(body);
export const CloseReason$isUnexpectedCondition = (value) =>
  value instanceof UnexpectedCondition;
export const CloseReason$UnexpectedCondition$body = (value) => value.body;
export const CloseReason$UnexpectedCondition$0 = (value) => value.body;

/**
 * Usually used for `4000` codes.
 */
export class CustomCloseReason extends $CustomType {
  constructor(code, body) {
    super();
    this.code = code;
    this.body = body;
  }
}
export const CloseReason$CustomCloseReason = (code, body) =>
  new CustomCloseReason(code, body);
export const CloseReason$isCustomCloseReason = (value) =>
  value instanceof CustomCloseReason;
export const CloseReason$CustomCloseReason$code = (value) => value.code;
export const CloseReason$CustomCloseReason$0 = (value) => value.code;
export const CloseReason$CustomCloseReason$body = (value) => value.body;
export const CloseReason$CustomCloseReason$1 = (value) => value.body;

export class CloseFrame extends $CustomType {
  constructor(reason) {
    super();
    this.reason = reason;
  }
}
export const ControlFrame$CloseFrame = (reason) => new CloseFrame(reason);
export const ControlFrame$isCloseFrame = (value) => value instanceof CloseFrame;
export const ControlFrame$CloseFrame$reason = (value) => value.reason;
export const ControlFrame$CloseFrame$0 = (value) => value.reason;

export class PingFrame extends $CustomType {
  constructor(payload) {
    super();
    this.payload = payload;
  }
}
export const ControlFrame$PingFrame = (payload) => new PingFrame(payload);
export const ControlFrame$isPingFrame = (value) => value instanceof PingFrame;
export const ControlFrame$PingFrame$payload = (value) => value.payload;
export const ControlFrame$PingFrame$0 = (value) => value.payload;

export class PongFrame extends $CustomType {
  constructor(payload) {
    super();
    this.payload = payload;
  }
}
export const ControlFrame$PongFrame = (payload) => new PongFrame(payload);
export const ControlFrame$isPongFrame = (value) => value instanceof PongFrame;
export const ControlFrame$PongFrame$payload = (value) => value.payload;
export const ControlFrame$PongFrame$0 = (value) => value.payload;

export class Data extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const Frame$Data = ($0) => new Data($0);
export const Frame$isData = (value) => value instanceof Data;
export const Frame$Data$0 = (value) => value[0];

export class Control extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const Frame$Control = ($0) => new Control($0);
export const Frame$isControl = (value) => value instanceof Control;
export const Frame$Control$0 = (value) => value[0];

export class Continuation extends $CustomType {
  constructor(length, payload) {
    super();
    this.length = length;
    this.payload = payload;
  }
}
export const Frame$Continuation = (length, payload) =>
  new Continuation(length, payload);
export const Frame$isContinuation = (value) => value instanceof Continuation;
export const Frame$Continuation$length = (value) => value.length;
export const Frame$Continuation$0 = (value) => value.length;
export const Frame$Continuation$payload = (value) => value.payload;
export const Frame$Continuation$1 = (value) => value.payload;

export class NeedMoreData extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const FrameParseError$NeedMoreData = ($0) => new NeedMoreData($0);
export const FrameParseError$isNeedMoreData = (value) =>
  value instanceof NeedMoreData;
export const FrameParseError$NeedMoreData$0 = (value) => value[0];

export class InvalidFrame extends $CustomType {}
export const FrameParseError$InvalidFrame = () => new InvalidFrame();
export const FrameParseError$isInvalidFrame = (value) =>
  value instanceof InvalidFrame;

export class Complete extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const ParsedFrame$Complete = ($0) => new Complete($0);
export const ParsedFrame$isComplete = (value) => value instanceof Complete;
export const ParsedFrame$Complete$0 = (value) => value[0];

export class Incomplete extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const ParsedFrame$Incomplete = ($0) => new Incomplete($0);
export const ParsedFrame$isIncomplete = (value) => value instanceof Incomplete;
export const ParsedFrame$Incomplete$0 = (value) => value[0];

class Compressed extends $CustomType {}

class Uncompressed extends $CustomType {}

class Sha extends $CustomType {}

const websocket_key = "258EAFA5-E914-47DA-95CA-C5AB0DC85B11";

function make_length(length) {
  let length$1 = length;
  if (length$1 > 65_535) {
    return toBitArray([sizedInt(127, 7, true), sizedInt(length$1, 64, true)]);
  } else {
    let length$1 = length;
    if (length$1 >= 126) {
      return toBitArray([sizedInt(126, 7, true), sizedInt(length$1, 16, true)]);
    } else {
      return toBitArray([sizedInt(length, 7, true)]);
    }
  }
}

function make_frame(opcode, length, payload, compressed, mask) {
  let length_section = make_length(length);
  let _block;
  let $ = $option.is_some(mask);
  if ($) {
    _block = 1;
  } else {
    _block = 0;
  }
  let masked = _block;
  let mask_key = $option.unwrap(mask, toBitArray([]));
  let _block$1;
  if (compressed instanceof Compressed) {
    _block$1 = 1;
  } else {
    _block$1 = 0;
  }
  let compressed$1 = _block$1;
  let _pipe = toBitArray([
    sizedInt(1, 1, true),
    sizedInt(compressed$1, 1, true),
    sizedInt(0, 2, true),
    sizedInt(opcode, 4, true),
    sizedInt(masked, 1, true),
    length_section,
    mask_key,
    payload,
  ]);
  return $bytes_tree.from_bit_array(_pipe);
}

function append_frame(left, data) {
  if (left instanceof Data) {
    let $ = left[0];
    if ($ instanceof TextFrame) {
      let payload = $.payload;
      return new Data(new TextFrame(toBitArray([payload, data])));
    } else {
      let payload = $.payload;
      return new Data(new BinaryFrame(toBitArray([payload, data])));
    }
  } else if (left instanceof Control) {
    let $ = left[0];
    if ($ instanceof CloseFrame) {
      return left;
    } else if ($ instanceof PingFrame) {
      let payload = $.payload;
      return new Control(new PingFrame(toBitArray([payload, data])));
    } else {
      let payload = $.payload;
      return new Control(new PongFrame(toBitArray([payload, data])));
    }
  } else {
    return left;
  }
}

export function aggregate_frames(loop$frames, loop$previous, loop$joined) {
  while (true) {
    let frames = loop$frames;
    let previous = loop$previous;
    let joined = loop$joined;
    if (frames instanceof $Empty) {
      return new Ok($list.reverse(joined));
    } else if (previous instanceof Some) {
      let $ = frames.head;
      if ($ instanceof Complete) {
        let $1 = $[0];
        if ($1 instanceof Continuation) {
          let rest = frames.tail;
          let prev = previous[0];
          let data = $1.payload;
          let next = append_frame(prev, data);
          loop$frames = rest;
          loop$previous = new None();
          loop$joined = listPrepend(next, joined);
        } else {
          return new Error(undefined);
        }
      } else {
        let $1 = $[0];
        if ($1 instanceof Continuation) {
          let rest = frames.tail;
          let prev = previous[0];
          let data = $1.payload;
          let next = append_frame(prev, data);
          loop$frames = rest;
          loop$previous = new Some(next);
          loop$joined = joined;
        } else {
          return new Error(undefined);
        }
      }
    } else {
      let $ = frames.head;
      if ($ instanceof Complete) {
        let rest = frames.tail;
        let frame = $[0];
        loop$frames = rest;
        loop$previous = new None();
        loop$joined = listPrepend(frame, joined);
      } else {
        let rest = frames.tail;
        let frame = $[0];
        loop$frames = rest;
        loop$previous = new Some(frame);
        loop$joined = joined;
      }
    }
  }
}

export function make_client_key() {
  let bytes = $crypto.strong_random_bytes(16);
  return $bit_array.base64_encode(bytes, true);
}

export function has_deflate(extensions) {
  return $list.any(
    extensions,
    (str) => { return str === "permessage-deflate"; },
  );
}

export function get_context_takeovers(extensions) {
  let no_client_context_takeover = $list.any(
    extensions,
    (str) => { return str === "client_no_context_takeover"; },
  );
  let no_server_context_takeover = $list.any(
    extensions,
    (str) => { return str === "server_no_context_takeover"; },
  );
  return new ContextTakeover(
    no_client_context_takeover,
    no_server_context_takeover,
  );
}
