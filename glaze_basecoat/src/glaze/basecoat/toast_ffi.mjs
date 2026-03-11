import { config_to_json } from "./toast.mjs";

export function dispatch(config) {
  const payload = config_to_json(config);
  document.dispatchEvent(
    new CustomEvent("basecoat:toast", {
      detail: {
        config: { ...payload },
      },
    }),
  );
}
