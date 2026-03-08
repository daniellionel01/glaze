import { Error, toList } from "../../gleam.mjs";

export const empty_list = /* @__PURE__ */ toList([]);

export const error_nil = /* @__PURE__ */ new Error(undefined);
