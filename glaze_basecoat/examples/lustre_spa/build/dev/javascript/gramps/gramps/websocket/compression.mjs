import * as $atom from "../../../gleam_erlang/gleam/erlang/atom.mjs";
import * as $process from "../../../gleam_erlang/gleam/erlang/process.mjs";
import * as $bit_array from "../../../gleam_stdlib/gleam/bit_array.mjs";
import * as $bytes_tree from "../../../gleam_stdlib/gleam/bytes_tree.mjs";
import { CustomType as $CustomType } from "../../gleam.mjs";

export class Context extends $CustomType {
  constructor(context, no_takeover) {
    super();
    this.context = context;
    this.no_takeover = no_takeover;
  }
}
export const Context$Context = (context, no_takeover) =>
  new Context(context, no_takeover);
export const Context$isContext = (value) => value instanceof Context;
export const Context$Context$context = (value) => value.context;
export const Context$Context$0 = (value) => value.context;
export const Context$Context$no_takeover = (value) => value.no_takeover;
export const Context$Context$1 = (value) => value.no_takeover;

class Sync extends $CustomType {}

class Deflated extends $CustomType {}

class Default extends $CustomType {}

export class ContextTakeover extends $CustomType {
  constructor(no_client, no_server) {
    super();
    this.no_client = no_client;
    this.no_server = no_server;
  }
}
export const ContextTakeover$ContextTakeover = (no_client, no_server) =>
  new ContextTakeover(no_client, no_server);
export const ContextTakeover$isContextTakeover = (value) =>
  value instanceof ContextTakeover;
export const ContextTakeover$ContextTakeover$no_client = (value) =>
  value.no_client;
export const ContextTakeover$ContextTakeover$0 = (value) => value.no_client;
export const ContextTakeover$ContextTakeover$no_server = (value) =>
  value.no_server;
export const ContextTakeover$ContextTakeover$1 = (value) => value.no_server;

export class Compression extends $CustomType {
  constructor(inflate, deflate) {
    super();
    this.inflate = inflate;
    this.deflate = deflate;
  }
}
export const Compression$Compression = (inflate, deflate) =>
  new Compression(inflate, deflate);
export const Compression$isCompression = (value) =>
  value instanceof Compression;
export const Compression$Compression$inflate = (value) => value.inflate;
export const Compression$Compression$0 = (value) => value.inflate;
export const Compression$Compression$deflate = (value) => value.deflate;
export const Compression$Compression$1 = (value) => value.deflate;
