import * as $atom from "../../../gleam_erlang/gleam/erlang/atom.mjs";
import * as $dict from "../../../gleam_stdlib/gleam/dict.mjs";
import * as $dynamic from "../../../gleam_stdlib/gleam/dynamic.mjs";
import * as $decode from "../../../gleam_stdlib/gleam/dynamic/decode.mjs";
import * as $int from "../../../gleam_stdlib/gleam/int.mjs";
import * as $result from "../../../gleam_stdlib/gleam/result.mjs";
import * as $string from "../../../gleam_stdlib/gleam/string.mjs";
import * as $logging from "../../../logging/logging.mjs";
import { toList, CustomType as $CustomType } from "../../gleam.mjs";

export class Start extends $CustomType {}
export const Event$Start = () => new Start();
export const Event$isStart = (value) => value instanceof Start;

export class Stop extends $CustomType {}
export const Event$Stop = () => new Stop();
export const Event$isStop = (value) => value instanceof Stop;

export class Mist extends $CustomType {}
export const Event$Mist = () => new Mist();
export const Event$isMist = (value) => value instanceof Mist;

export class ParseRequest extends $CustomType {}
export const Event$ParseRequest = () => new ParseRequest();
export const Event$isParseRequest = (value) => value instanceof ParseRequest;

export class ParseRequest2 extends $CustomType {}
export const Event$ParseRequest2 = () => new ParseRequest2();
export const Event$isParseRequest2 = (value) => value instanceof ParseRequest2;

export class DecodePacket extends $CustomType {}
export const Event$DecodePacket = () => new DecodePacket();
export const Event$isDecodePacket = (value) => value instanceof DecodePacket;

export class ConvertPath extends $CustomType {}
export const Event$ConvertPath = () => new ConvertPath();
export const Event$isConvertPath = (value) => value instanceof ConvertPath;

export class ParseMethod extends $CustomType {}
export const Event$ParseMethod = () => new ParseMethod();
export const Event$isParseMethod = (value) => value instanceof ParseMethod;

export class ParseHeaders extends $CustomType {}
export const Event$ParseHeaders = () => new ParseHeaders();
export const Event$isParseHeaders = (value) => value instanceof ParseHeaders;

export class ParseRest extends $CustomType {}
export const Event$ParseRest = () => new ParseRest();
export const Event$isParseRest = (value) => value instanceof ParseRest;

export class ParsePath extends $CustomType {}
export const Event$ParsePath = () => new ParsePath();
export const Event$isParsePath = (value) => value instanceof ParsePath;

export class ParseTransport extends $CustomType {}
export const Event$ParseTransport = () => new ParseTransport();
export const Event$isParseTransport = (value) =>
  value instanceof ParseTransport;

export class ParseHost extends $CustomType {}
export const Event$ParseHost = () => new ParseHost();
export const Event$isParseHost = (value) => value instanceof ParseHost;

export class ParsePort extends $CustomType {}
export const Event$ParsePort = () => new ParsePort();
export const Event$isParsePort = (value) => value instanceof ParsePort;

export class BuildRequest extends $CustomType {}
export const Event$BuildRequest = () => new BuildRequest();
export const Event$isBuildRequest = (value) => value instanceof BuildRequest;

export class ReadData extends $CustomType {}
export const Event$ReadData = () => new ReadData();
export const Event$isReadData = (value) => value instanceof ReadData;

export class Http1Handler extends $CustomType {}
export const Event$Http1Handler = () => new Http1Handler();
export const Event$isHttp1Handler = (value) => value instanceof Http1Handler;

export class HttpUpgrade extends $CustomType {}
export const Event$HttpUpgrade = () => new HttpUpgrade();
export const Event$isHttpUpgrade = (value) => value instanceof HttpUpgrade;

export class Http2Handler extends $CustomType {}
export const Event$Http2Handler = () => new Http2Handler();
export const Event$isHttp2Handler = (value) => value instanceof Http2Handler;

class Native extends $CustomType {}

class Microsecond extends $CustomType {}

export const events = /* @__PURE__ */ toList([
  /* @__PURE__ */ toList([
    /* @__PURE__ */ new Mist(),
    /* @__PURE__ */ new ParseRequest(),
    /* @__PURE__ */ new Stop(),
  ]),
  /* @__PURE__ */ toList([
    /* @__PURE__ */ new Mist(),
    /* @__PURE__ */ new ParseRequest2(),
    /* @__PURE__ */ new Stop(),
  ]),
  /* @__PURE__ */ toList([
    /* @__PURE__ */ new Mist(),
    /* @__PURE__ */ new Http1Handler(),
    /* @__PURE__ */ new Stop(),
  ]),
  /* @__PURE__ */ toList([
    /* @__PURE__ */ new Mist(),
    /* @__PURE__ */ new HttpUpgrade(),
    /* @__PURE__ */ new Stop(),
  ]),
  /* @__PURE__ */ toList([
    /* @__PURE__ */ new Mist(),
    /* @__PURE__ */ new Http2Handler(),
    /* @__PURE__ */ new Stop(),
  ]),
  /* @__PURE__ */ toList([
    /* @__PURE__ */ new Mist(),
    /* @__PURE__ */ new DecodePacket(),
    /* @__PURE__ */ new Stop(),
  ]),
  /* @__PURE__ */ toList([
    /* @__PURE__ */ new Mist(),
    /* @__PURE__ */ new ConvertPath(),
    /* @__PURE__ */ new Stop(),
  ]),
  /* @__PURE__ */ toList([
    /* @__PURE__ */ new Mist(),
    /* @__PURE__ */ new ParseMethod(),
    /* @__PURE__ */ new Stop(),
  ]),
  /* @__PURE__ */ toList([
    /* @__PURE__ */ new Mist(),
    /* @__PURE__ */ new ParseHeaders(),
    /* @__PURE__ */ new Stop(),
  ]),
  /* @__PURE__ */ toList([
    /* @__PURE__ */ new Mist(),
    /* @__PURE__ */ new ParseRest(),
    /* @__PURE__ */ new Stop(),
  ]),
  /* @__PURE__ */ toList([
    /* @__PURE__ */ new Mist(),
    /* @__PURE__ */ new ParsePath(),
    /* @__PURE__ */ new Stop(),
  ]),
  /* @__PURE__ */ toList([
    /* @__PURE__ */ new Mist(),
    /* @__PURE__ */ new ParseTransport(),
    /* @__PURE__ */ new Stop(),
  ]),
  /* @__PURE__ */ toList([
    /* @__PURE__ */ new Mist(),
    /* @__PURE__ */ new ParseHost(),
    /* @__PURE__ */ new Stop(),
  ]),
  /* @__PURE__ */ toList([
    /* @__PURE__ */ new Mist(),
    /* @__PURE__ */ new ParsePort(),
    /* @__PURE__ */ new Stop(),
  ]),
  /* @__PURE__ */ toList([
    /* @__PURE__ */ new Mist(),
    /* @__PURE__ */ new BuildRequest(),
    /* @__PURE__ */ new Stop(),
  ]),
  /* @__PURE__ */ toList([
    /* @__PURE__ */ new Mist(),
    /* @__PURE__ */ new ReadData(),
    /* @__PURE__ */ new Stop(),
  ]),
]);
