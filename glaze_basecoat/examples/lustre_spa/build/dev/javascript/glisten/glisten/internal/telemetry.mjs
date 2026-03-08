import * as $atom from "../../../gleam_erlang/gleam/erlang/atom.mjs";
import * as $dict from "../../../gleam_stdlib/gleam/dict.mjs";
import * as $dynamic from "../../../gleam_stdlib/gleam/dynamic.mjs";
import * as $decode from "../../../gleam_stdlib/gleam/dynamic/decode.mjs";
import * as $int from "../../../gleam_stdlib/gleam/int.mjs";
import * as $result from "../../../gleam_stdlib/gleam/result.mjs";
import * as $string from "../../../gleam_stdlib/gleam/string.mjs";
import * as $logging from "../../../logging/logging.mjs";
import { toList, CustomType as $CustomType } from "../../gleam.mjs";

export class Data extends $CustomType {
  constructor(latency, metadata) {
    super();
    this.latency = latency;
    this.metadata = metadata;
  }
}
export const Data$Data = (latency, metadata) => new Data(latency, metadata);
export const Data$isData = (value) => value instanceof Data;
export const Data$Data$latency = (value) => value.latency;
export const Data$Data$0 = (value) => value.latency;
export const Data$Data$metadata = (value) => value.metadata;
export const Data$Data$1 = (value) => value.metadata;

export class Start extends $CustomType {}
export const Event$Start = () => new Start();
export const Event$isStart = (value) => value instanceof Start;

export class Stop extends $CustomType {}
export const Event$Stop = () => new Stop();
export const Event$isStop = (value) => value instanceof Stop;

export class Glisten extends $CustomType {}
export const Event$Glisten = () => new Glisten();
export const Event$isGlisten = (value) => value instanceof Glisten;

export class Handshake extends $CustomType {}
export const Event$Handshake = () => new Handshake();
export const Event$isHandshake = (value) => value instanceof Handshake;

export class HandlerLoop extends $CustomType {}
export const Event$HandlerLoop = () => new HandlerLoop();
export const Event$isHandlerLoop = (value) => value instanceof HandlerLoop;

export class Listener extends $CustomType {}
export const Event$Listener = () => new Listener();
export const Event$isListener = (value) => value instanceof Listener;

export class Acceptor extends $CustomType {}
export const Event$Acceptor = () => new Acceptor();
export const Event$isAcceptor = (value) => value instanceof Acceptor;

export class HandlerStart extends $CustomType {}
export const Event$HandlerStart = () => new HandlerStart();
export const Event$isHandlerStart = (value) => value instanceof HandlerStart;

export class HandlerInit extends $CustomType {}
export const Event$HandlerInit = () => new HandlerInit();
export const Event$isHandlerInit = (value) => value instanceof HandlerInit;

class Native extends $CustomType {}

class Microsecond extends $CustomType {}

export const events = /* @__PURE__ */ toList([
  /* @__PURE__ */ toList([
    /* @__PURE__ */ new Glisten(),
    /* @__PURE__ */ new Handshake(),
    /* @__PURE__ */ new Stop(),
  ]),
  /* @__PURE__ */ toList([
    /* @__PURE__ */ new Glisten(),
    /* @__PURE__ */ new HandlerLoop(),
    /* @__PURE__ */ new Stop(),
  ]),
  /* @__PURE__ */ toList([
    /* @__PURE__ */ new Glisten(),
    /* @__PURE__ */ new Acceptor(),
    /* @__PURE__ */ new HandlerStart(),
    /* @__PURE__ */ new Stop(),
  ]),
]);
