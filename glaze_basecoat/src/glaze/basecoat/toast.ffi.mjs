import { config_to_json } from "./toast.mjs";

export function dispatch(config) {
  const payload = config_to_json(config);
  document.getElementById("toaster")?.toast(payload);

  return null;
}
