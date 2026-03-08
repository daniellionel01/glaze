import * as $booklet from "../../../booklet/booklet.mjs";
import * as $filepath from "../../../filepath/filepath.mjs";
import * as $ansi from "../../../gleam_community_ansi/gleam_community/ansi.mjs";
import * as $process from "../../../gleam_erlang/gleam/erlang/process.mjs";
import * as $actor from "../../../gleam_otp/gleam/otp/actor.mjs";
import { Started } from "../../../gleam_otp/gleam/otp/actor.mjs";
import * as $io from "../../../gleam_stdlib/gleam/io.mjs";
import * as $list from "../../../gleam_stdlib/gleam/list.mjs";
import * as $option from "../../../gleam_stdlib/gleam/option.mjs";
import { None, Some } from "../../../gleam_stdlib/gleam/option.mjs";
import * as $result from "../../../gleam_stdlib/gleam/result.mjs";
import * as $string from "../../../gleam_stdlib/gleam/string.mjs";
import * as $group_registry from "../../../group_registry/group_registry.mjs";
import * as $justin from "../../../justin/justin.mjs";
import * as $polly from "../../../polly/polly.mjs";
import * as $simplifile from "../../../simplifile/simplifile.mjs";
import { CustomType as $CustomType } from "../../gleam.mjs";
import * as $bun from "../../lustre_dev_tools/bin/bun.mjs";
import * as $gleam from "../../lustre_dev_tools/bin/gleam.mjs";
import * as $tailwind from "../../lustre_dev_tools/bin/tailwind.mjs";
import * as $cli from "../../lustre_dev_tools/cli.mjs";
import * as $error from "../../lustre_dev_tools/error.mjs";
import * as $project from "../../lustre_dev_tools/project.mjs";
import * as $system from "../../lustre_dev_tools/system.mjs";

export class Events extends $CustomType {}
export const Mode$Events = () => new Events();
export const Mode$isEvents = (value) => value instanceof Events;

export class Polling extends $CustomType {}
export const Mode$Polling = () => new Polling();
export const Mode$isPolling = (value) => value instanceof Polling;

export class Change extends $CustomType {
  constructor(in$, path) {
    super();
    this.in = in$;
    this.path = path;
  }
}
export const Event$Change = (in$, path) => new Change(in$, path);
export const Event$isChange = (value) => value instanceof Change;
export const Event$Change$in = (value) => value.in;
export const Event$Change$0 = (value) => value.in;
export const Event$Change$path = (value) => value.path;
export const Event$Change$1 = (value) => value.path;

export class Styles extends $CustomType {}
export const Event$Styles = () => new Styles();
export const Event$isStyles = (value) => value instanceof Styles;

export class BuildError extends $CustomType {}
export const Event$BuildError = () => new BuildError();
export const Event$isBuildError = (value) => value instanceof BuildError;

class Waiting extends $CustomType {
  constructor(self) {
    super();
    this.self = self;
  }
}

class Buffering extends $CustomType {
  constructor(self, timer) {
    super();
    this.self = self;
    this.timer = timer;
  }
}

class Building extends $CustomType {
  constructor(self, in$, path, queued) {
    super();
    this.self = self;
    this.in = in$;
    this.path = path;
    this.queued = queued;
  }
}

class BuildFinished extends $CustomType {
  constructor(result) {
    super();
    this.result = result;
  }
}

class FileChanged extends $CustomType {
  constructor(in$, path) {
    super();
    this.in = in$;
    this.path = path;
  }
}

class TimerCompleted extends $CustomType {
  constructor(in$, path) {
    super();
    this.in = in$;
    this.path = path;
  }
}

const build_debounce_ms = 50;
