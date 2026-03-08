import * as $atom from "../../../gleam_erlang/gleam/erlang/atom.mjs";
import * as $dict from "../../../gleam_stdlib/gleam/dict.mjs";
import * as $dynamic from "../../../gleam_stdlib/gleam/dynamic.mjs";
import * as $decode from "../../../gleam_stdlib/gleam/dynamic/decode.mjs";
import * as $list from "../../../gleam_stdlib/gleam/list.mjs";
import { toList, CustomType as $CustomType } from "../../gleam.mjs";

export class Binary extends $CustomType {}
export const SocketMode$Binary = () => new Binary();
export const SocketMode$isBinary = (value) => value instanceof Binary;

export class Once extends $CustomType {}
export const ActiveState$Once = () => new Once();
export const ActiveState$isOnce = (value) => value instanceof Once;

export class Passive extends $CustomType {}
export const ActiveState$Passive = () => new Passive();
export const ActiveState$isPassive = (value) => value instanceof Passive;

export class Count extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const ActiveState$Count = ($0) => new Count($0);
export const ActiveState$isCount = (value) => value instanceof Count;
export const ActiveState$Count$0 = (value) => value[0];

export class Active extends $CustomType {}
export const ActiveState$Active = () => new Active();
export const ActiveState$isActive = (value) => value instanceof Active;

export class Address extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const Interface$Address = ($0) => new Address($0);
export const Interface$isAddress = (value) => value instanceof Address;
export const Interface$Address$0 = (value) => value[0];

export class Any extends $CustomType {}
export const Interface$Any = () => new Any();
export const Interface$isAny = (value) => value instanceof Any;

export class Loopback extends $CustomType {}
export const Interface$Loopback = () => new Loopback();
export const Interface$isLoopback = (value) => value instanceof Loopback;

export class CertKeyFiles extends $CustomType {
  constructor(certfile, keyfile) {
    super();
    this.certfile = certfile;
    this.keyfile = keyfile;
  }
}
export const TlsCerts$CertKeyFiles = (certfile, keyfile) =>
  new CertKeyFiles(certfile, keyfile);
export const TlsCerts$isCertKeyFiles = (value) => value instanceof CertKeyFiles;
export const TlsCerts$CertKeyFiles$certfile = (value) => value.certfile;
export const TlsCerts$CertKeyFiles$0 = (value) => value.certfile;
export const TlsCerts$CertKeyFiles$keyfile = (value) => value.keyfile;
export const TlsCerts$CertKeyFiles$1 = (value) => value.keyfile;

export class Backlog extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const TcpOption$Backlog = ($0) => new Backlog($0);
export const TcpOption$isBacklog = (value) => value instanceof Backlog;
export const TcpOption$Backlog$0 = (value) => value[0];

export class Nodelay extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const TcpOption$Nodelay = ($0) => new Nodelay($0);
export const TcpOption$isNodelay = (value) => value instanceof Nodelay;
export const TcpOption$Nodelay$0 = (value) => value[0];

export class Linger extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const TcpOption$Linger = ($0) => new Linger($0);
export const TcpOption$isLinger = (value) => value instanceof Linger;
export const TcpOption$Linger$0 = (value) => value[0];

export class SendTimeout extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const TcpOption$SendTimeout = ($0) => new SendTimeout($0);
export const TcpOption$isSendTimeout = (value) => value instanceof SendTimeout;
export const TcpOption$SendTimeout$0 = (value) => value[0];

export class SendTimeoutClose extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const TcpOption$SendTimeoutClose = ($0) => new SendTimeoutClose($0);
export const TcpOption$isSendTimeoutClose = (value) =>
  value instanceof SendTimeoutClose;
export const TcpOption$SendTimeoutClose$0 = (value) => value[0];

export class Reuseaddr extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const TcpOption$Reuseaddr = ($0) => new Reuseaddr($0);
export const TcpOption$isReuseaddr = (value) => value instanceof Reuseaddr;
export const TcpOption$Reuseaddr$0 = (value) => value[0];

export class ActiveMode extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const TcpOption$ActiveMode = ($0) => new ActiveMode($0);
export const TcpOption$isActiveMode = (value) => value instanceof ActiveMode;
export const TcpOption$ActiveMode$0 = (value) => value[0];

export class Mode extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const TcpOption$Mode = ($0) => new Mode($0);
export const TcpOption$isMode = (value) => value instanceof Mode;
export const TcpOption$Mode$0 = (value) => value[0];

export class CertKeyConfig extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const TcpOption$CertKeyConfig = ($0) => new CertKeyConfig($0);
export const TcpOption$isCertKeyConfig = (value) =>
  value instanceof CertKeyConfig;
export const TcpOption$CertKeyConfig$0 = (value) => value[0];

export class AlpnPreferredProtocols extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const TcpOption$AlpnPreferredProtocols = ($0) =>
  new AlpnPreferredProtocols($0);
export const TcpOption$isAlpnPreferredProtocols = (value) =>
  value instanceof AlpnPreferredProtocols;
export const TcpOption$AlpnPreferredProtocols$0 = (value) => value[0];

export class Ipv6 extends $CustomType {}
export const TcpOption$Ipv6 = () => new Ipv6();
export const TcpOption$isIpv6 = (value) => value instanceof Ipv6;

export class Buffer extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const TcpOption$Buffer = ($0) => new Buffer($0);
export const TcpOption$isBuffer = (value) => value instanceof Buffer;
export const TcpOption$Buffer$0 = (value) => value[0];

export class Ip extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const TcpOption$Ip = ($0) => new Ip($0);
export const TcpOption$isIp = (value) => value instanceof Ip;
export const TcpOption$Ip$0 = (value) => value[0];

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

export const default_options = /* @__PURE__ */ toList([
  /* @__PURE__ */ new Backlog(1024),
  /* @__PURE__ */ new Nodelay(true),
  /* @__PURE__ */ new SendTimeout(30_000),
  /* @__PURE__ */ new SendTimeoutClose(true),
  /* @__PURE__ */ new Reuseaddr(true),
  /* @__PURE__ */ new Mode(/* @__PURE__ */ new Binary()),
  /* @__PURE__ */ new ActiveMode(/* @__PURE__ */ new Passive()),
]);
