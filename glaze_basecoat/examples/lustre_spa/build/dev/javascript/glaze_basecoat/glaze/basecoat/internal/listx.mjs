import * as $list from "../../../../gleam_stdlib/gleam/list.mjs";

export function append3(first, second, tercary) {
  return $list.append(first, $list.append(second, tercary));
}
