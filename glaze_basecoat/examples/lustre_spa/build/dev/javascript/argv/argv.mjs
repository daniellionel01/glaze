import { load as do$ } from "./argv_ffi.mjs";
import { CustomType as $CustomType } from "./gleam.mjs";

export class Argv extends $CustomType {
  constructor(runtime, program, arguments$) {
    super();
    this.runtime = runtime;
    this.program = program;
    this.arguments = arguments$;
  }
}
export const Argv$Argv = (runtime, program, arguments$) =>
  new Argv(runtime, program, arguments$);
export const Argv$isArgv = (value) => value instanceof Argv;
export const Argv$Argv$runtime = (value) => value.runtime;
export const Argv$Argv$0 = (value) => value.runtime;
export const Argv$Argv$program = (value) => value.program;
export const Argv$Argv$1 = (value) => value.program;
export const Argv$Argv$arguments = (value) => value.arguments;
export const Argv$Argv$2 = (value) => value.arguments;

export function load() {
  let $ = do$();
  let runtime;
  let program;
  let arguments$;
  runtime = $[0];
  program = $[1];
  arguments$ = $[2];
  return new Argv(runtime, program, arguments$);
}
