import * as $process from "../../../gleam_erlang/gleam/erlang/process.mjs";
import * as $option from "../../../gleam_stdlib/gleam/option.mjs";
import { CustomType as $CustomType } from "../../gleam.mjs";

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
