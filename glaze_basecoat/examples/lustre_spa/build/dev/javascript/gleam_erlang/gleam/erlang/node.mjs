import { CustomType as $CustomType } from "../../gleam.mjs";
import * as $atom from "../../gleam/erlang/atom.mjs";

export class FailedToConnect extends $CustomType {}
export const ConnectError$FailedToConnect = () => new FailedToConnect();
export const ConnectError$isFailedToConnect = (value) =>
  value instanceof FailedToConnect;

export class LocalNodeIsNotAlive extends $CustomType {}
export const ConnectError$LocalNodeIsNotAlive = () => new LocalNodeIsNotAlive();
export const ConnectError$isLocalNodeIsNotAlive = (value) =>
  value instanceof LocalNodeIsNotAlive;
