import * as $filepath from "../filepath/filepath.mjs";
import * as $bool from "../gleam_stdlib/gleam/bool.mjs";
import * as $int from "../gleam_stdlib/gleam/int.mjs";
import * as $list from "../gleam_stdlib/gleam/list.mjs";
import * as $option from "../gleam_stdlib/gleam/option.mjs";
import { None, Some } from "../gleam_stdlib/gleam/option.mjs";
import * as $order from "../gleam_stdlib/gleam/order.mjs";
import * as $result from "../gleam_stdlib/gleam/result.mjs";
import * as $string from "../gleam_stdlib/gleam/string.mjs";
import * as $simplifile from "../simplifile/simplifile.mjs";
import { Eacces, Enoent } from "../simplifile/simplifile.mjs";
import * as $gleam from "./gleam.mjs";
import {
  Error as Err,
  Ok,
  toList,
  Empty as $Empty,
  prepend as listPrepend,
  CustomType as $CustomType,
  isEqual,
} from "./gleam.mjs";
import { repeatedly } from "./polly_ffi.mjs";

/**
 * A new file or dictionary was created!
 */
export class Created extends $CustomType {
  constructor(path) {
    super();
    this.path = path;
  }
}
export const Event$Created = (path) => new Created(path);
export const Event$isCreated = (value) => value instanceof Created;
export const Event$Created$path = (value) => value.path;
export const Event$Created$0 = (value) => value.path;

/**
 * A file got modified!
 */
export class Changed extends $CustomType {
  constructor(path) {
    super();
    this.path = path;
  }
}
export const Event$Changed = (path) => new Changed(path);
export const Event$isChanged = (value) => value instanceof Changed;
export const Event$Changed$path = (value) => value.path;
export const Event$Changed$0 = (value) => value.path;

/**
 * A file or dictionary got deleted :(
 */
export class Deleted extends $CustomType {
  constructor(path) {
    super();
    this.path = path;
  }
}
export const Event$Deleted = (path) => new Deleted(path);
export const Event$isDeleted = (value) => value instanceof Deleted;
export const Event$Deleted$path = (value) => value.path;
export const Event$Deleted$0 = (value) => value.path;

/**
 * An unexpected simplifile error happened :(
 *
 * Polly treats `Enoent` and `Eacces` errors as if the file got deleted,
 * and will therefore never pass those to you.
 */
export class Error extends $CustomType {
  constructor(path, reason) {
    super();
    this.path = path;
    this.reason = reason;
  }
}
export const Event$Error = (path, reason) => new Error(path, reason);
export const Event$isError = (value) => value instanceof Error;
export const Event$Error$path = (value) => value.path;
export const Event$Error$0 = (value) => value.path;
export const Event$Error$reason = (value) => value.reason;
export const Event$Error$1 = (value) => value.reason;

export const Event$path = (value) => value.path;

class Options extends $CustomType {
  constructor(interval, paths, max_depth, filter, ignore_initial_missing, callbacks) {
    super();
    this.interval = interval;
    this.paths = paths;
    this.max_depth = max_depth;
    this.filter = filter;
    this.ignore_initial_missing = ignore_initial_missing;
    this.callbacks = callbacks;
  }
}

class Watcher extends $CustomType {
  constructor(stop) {
    super();
    this.stop = stop;
  }
}

class State extends $CustomType {
  constructor(roots) {
    super();
    this.roots = roots;
  }
}

class Missing extends $CustomType {
  constructor(path) {
    super();
    this.path = path;
  }
}

class Initialised extends $CustomType {
  constructor(path, vfs) {
    super();
    this.path = path;
    this.vfs = vfs;
  }
}

class File extends $CustomType {
  constructor(name, modkey) {
    super();
    this.name = name;
    this.modkey = modkey;
  }
}

class Folder extends $CustomType {
  constructor(name, modkey, children) {
    super();
    this.name = name;
    this.modkey = modkey;
    this.children = children;
  }
}

/**
 * Tell Polly which directory to watch. If it does not exist, `watch` will return an error.
 *
 * If the directory goes away after watching has started, Polly will continue to
 * check on it to see if it came back.
 *
 * Paths are not expanded by default, so the paths reported by events and passed
 * to the filter function will be prefixed with whatever you specified here.
 */
export function add_dir(options, path) {
  return new Options(
    options.interval,
    listPrepend(path, options.paths),
    options.max_depth,
    options.filter,
    options.ignore_initial_missing,
    options.callbacks,
  );
}

/**
 * Tell Polly to watch a single file.
 *
 * Polly doesn't care if you tell her to watch a file or directory, but
 * using this function makes your intent clearer!
 */
export function add_file(options, path) {
  return add_dir(options, path);
}

/**
 * Limit the maximum depth that Polly will walk each directory.
 *
 * A limit of `0` would mean that Polly _only_ watches the specified list of
 * files or directories. A limit of `1` means that she will also look at the
 * files inside the given directories, but not at any nested directories.
 *
 * There is no limit by default, but setting a limit might be good to
 * better control resource usage of the watcher.
 *
 * Calling this function multiple times will cause polly to only remember the
 * lowest limit provided.
 */
export function max_depth(options, max_depth) {
  let $ = (options.max_depth < 0) || (max_depth < options.max_depth);
  if ($) {
    return new Options(
      options.interval,
      options.paths,
      max_depth,
      options.filter,
      options.ignore_initial_missing,
      options.callbacks,
    );
  } else {
    return options;
  }
}

/**
 * Set the interval in-between file-system polls, in milliseconds.
 *
 * This is the time that Polly rests between calls, so if scanning your directory
 * tree takes 100ms, and you configured 1000ms here, the total time between calls
 * will roughly be 1100ms.
 *
 * Doing it this way makes sure that Polly doesn't stumble over herself.
 */
export function interval(options, interval) {
  let $ = interval > 0;
  if ($) {
    return new Options(
      interval,
      options.paths,
      options.max_depth,
      options.filter,
      options.ignore_initial_missing,
      options.callbacks,
    );
  } else {
    return options;
  }
}

/**
 * Filter files using the given predicate.
 *
 * Polly will ignore files and directories for which the predicate returns `False`
 * completely, and any event happening for them or for a contained file of them
 * will not get reported.
 *
 * Keep in mind that the filter is checked for every part of a path, not just
 * leaf nodes! So for example, if you have a path `./src/app.gleam`, your filter
 * function will first be called on `.`, then on `./src`, and then finally on
 * `./src/app.gleam`.
 *
 * By default, all hidden files are ignored by using the `default_filter`.
 */
export function filter(options, filter) {
  return new Options(
    options.interval,
    options.paths,
    options.max_depth,
    filter,
    options.ignore_initial_missing,
    options.callbacks,
  );
}

/**
 * The default filter function, ignoring hidden files starting with a colon `"."`
 */
export function default_filter(_, path) {
  let $ = $filepath.base_name(path);
  if ($ === ".") {
    return true;
  } else if ($ === "..") {
    return true;
  } else {
    let basename = $;
    return !$string.starts_with(basename, ".");
  }
}

/**
 * Start creating a new configuration using the default options.
 *
 * By default, an interval of 1 second is set, and the `default_filter` is used.
 */
export function new$() {
  return new Options(1000, toList([]), -1, default_filter, false, toList([]));
}

/**
 * Tell Polly that it is fine if a file or directory does not exist initially.
 *
 * By default, if a file or directory cannot be found when calling `watch`,
 * Polly will immediately return to you with an `Enoent` error and refuse to run.
 *
 * When this option is active, Polly will instead note the missing directory,
 * and continuously check if it appears, similarly to how she does after a
 * file or directory goes away after she has first seen it.
 */
export function ignore_initial_missing(options) {
  return new Options(
    options.interval,
    options.paths,
    options.max_depth,
    options.filter,
    true,
    options.callbacks,
  );
}

/**
 * Add a callback function that Polly will call whenever she spots an event.
 *
 * You can add multiple callbacks, and Polly will call them each with the event
 * in an undefined order. The callbacks are called synchronously while she's collecting
 * change events, so it's a good idea to keep them light and fast!
 */
export function add_callback(options, callback) {
  return new Options(
    options.interval,
    options.paths,
    options.max_depth,
    options.filter,
    options.ignore_initial_missing,
    listPrepend(callback, options.callbacks),
  );
}

function broadcast(callbacks, event) {
  return $list.each(callbacks, (callback) => { return callback(event); });
}

/**
 * Stop this watcher.
 *
 * If Polly currently scans your directories, she might not hear you rightdo_inity
 * and may still report events for one run, after which she will stop.
 */
export function stop(watcher) {
  return watcher.stop();
}

/**
 * Format a list of file errors into a human-readable string.
 *
 * This is handy when `watch` returns errors and you want to show them to
 * your users. Each error is formatted as "path: description" on its own line.
 */
export function describe_errors(errors) {
  let _pipe = errors;
  let _pipe$1 = $list.map(
    _pipe,
    (error) => {
      let path;
      let error$1;
      path = error[0];
      error$1 = error[1];
      return (path + ": ") + $simplifile.describe_error(error$1);
    },
  );
  return $string.join(_pipe$1, "\n");
}

function root(path, vfs) {
  if (vfs instanceof Some) {
    let vfs$1 = vfs[0];
    return new Initialised(path, vfs$1);
  } else {
    return new Missing(path);
  }
}

function delete$(full_path, vfs, events) {
  if (vfs instanceof File) {
    return listPrepend(new Deleted(full_path), events);
  } else {
    let children$1 = vfs.children;
    let events$1 = $list.fold(
      children$1,
      events,
      (events, child) => {
        return delete$($filepath.join(full_path, child.name), child, events);
      },
    );
    return listPrepend(new Deleted(full_path), events$1);
  }
}

function get_modkey(stat) {
  return $int.max(stat.mtime_seconds, stat.ctime_seconds);
}

function readdir(path) {
  let _pipe = $simplifile.read_directory(path);
  return $result.map(
    _pipe,
    (_capture) => { return $list.sort(_capture, $string.compare); },
  );
}

function children(
  loop$filter,
  loop$depth,
  loop$path,
  loop$old_children,
  loop$entries,
  loop$new_children,
  loop$events
) {
  while (true) {
    let filter = loop$filter;
    let depth = loop$depth;
    let path = loop$path;
    let old_children = loop$old_children;
    let entries = loop$entries;
    let new_children = loop$new_children;
    let events = loop$events;
    if (old_children instanceof $Empty) {
      if (entries instanceof $Empty) {
        return [$list.reverse(new_children), events];
      } else {
        let entry = entries.head;
        let entries$1 = entries.tail;
        let $ = create(filter, depth, path, entry, events);
        let vfs_opt;
        let events$1;
        vfs_opt = $[0];
        events$1 = $[1];
        let _block;
        if (vfs_opt instanceof Some) {
          let new_vfs = vfs_opt[0];
          _block = listPrepend(new_vfs, new_children);
        } else {
          _block = new_children;
        }
        let news = _block;
        loop$filter = filter;
        loop$depth = depth;
        loop$path = path;
        loop$old_children = old_children;
        loop$entries = entries$1;
        loop$new_children = news;
        loop$events = events$1;
      }
    } else if (entries instanceof $Empty) {
      let prev = old_children.head;
      let olds = old_children.tail;
      let events$1 = delete$($filepath.join(path, prev.name), prev, events);
      loop$filter = filter;
      loop$depth = depth;
      loop$path = path;
      loop$old_children = olds;
      loop$entries = entries;
      loop$new_children = new_children;
      loop$events = events$1;
    } else {
      let prev = old_children.head;
      let olds = old_children.tail;
      let entry = entries.head;
      let rest = entries.tail;
      let $ = $string.compare(prev.name, entry);
      if ($ instanceof $order.Lt) {
        let events$1 = delete$($filepath.join(path, prev.name), prev, events);
        loop$filter = filter;
        loop$depth = depth;
        loop$path = path;
        loop$old_children = olds;
        loop$entries = entries;
        loop$new_children = new_children;
        loop$events = events$1;
      } else if ($ instanceof $order.Eq) {
        let $1 = diff(filter, depth, path, prev, events);
        let vfs_opt;
        let events$1;
        vfs_opt = $1[0];
        events$1 = $1[1];
        let _block;
        if (vfs_opt instanceof Some) {
          let new_vfs = vfs_opt[0];
          _block = listPrepend(new_vfs, new_children);
        } else {
          _block = new_children;
        }
        let news = _block;
        loop$filter = filter;
        loop$depth = depth;
        loop$path = path;
        loop$old_children = olds;
        loop$entries = rest;
        loop$new_children = news;
        loop$events = events$1;
      } else {
        let $1 = create(filter, depth, path, entry, events);
        let vfs_opt;
        let events$1;
        vfs_opt = $1[0];
        events$1 = $1[1];
        let _block;
        if (vfs_opt instanceof Some) {
          let new_vfs = vfs_opt[0];
          _block = listPrepend(new_vfs, new_children);
        } else {
          _block = new_children;
        }
        let news = _block;
        loop$filter = filter;
        loop$depth = depth;
        loop$path = path;
        loop$old_children = old_children;
        loop$entries = rest;
        loop$new_children = news;
        loop$events = events$1;
      }
    }
  }
}

function diff(filter, depth, path, vfs, events) {
  let full_path = $filepath.join(path, vfs.name);
  let $ = $simplifile.link_info(full_path);
  if ($ instanceof Ok) {
    let stat = $[0];
    let $1 = filter($simplifile.file_info_type(stat), full_path);
    if ($1) {
      return do_diff(filter, depth, vfs, stat, full_path, events);
    } else {
      return [new None(), delete$(full_path, vfs, events)];
    }
  } else {
    let $1 = $[0];
    if ($1 instanceof Eacces) {
      return [new None(), delete$(full_path, vfs, events)];
    } else if ($1 instanceof Enoent) {
      return [new None(), delete$(full_path, vfs, events)];
    } else {
      let reason = $1;
      return [new Some(vfs), listPrepend(new Error(path, reason), events)];
    }
  }
}

function do_diff(filter, depth, vfs, stat, path, events) {
  let type_ = $simplifile.file_info_type(stat);
  if (vfs instanceof File) {
    if (type_ instanceof $simplifile.File) {
      let name = vfs.name;
      let old_key = vfs.modkey;
      let $ = get_modkey(stat);
      let key = $;
      if (key === old_key) {
        return [new Some(vfs), events];
      } else {
        let key = $;
        return [
          new Some(new File(name, key)),
          listPrepend(new Changed(path), events),
        ];
      }
    } else {
      let events$1 = delete$(path, vfs, events);
      return create_stat(filter, depth, vfs.name, path, stat, events$1);
    }
  } else if (type_ instanceof $simplifile.Directory) {
    if (depth === 0) {
      return [new Some(vfs), events];
    } else if (depth !== 0) {
      let name = vfs.name;
      let old_children = vfs.children;
      let $ = readdir(path);
      if ($ instanceof Ok) {
        let entries = $[0];
        let $1 = children(
          filter,
          depth - 1,
          path,
          old_children,
          entries,
          toList([]),
          events,
        );
        let children$1;
        let events$1;
        children$1 = $1[0];
        events$1 = $1[1];
        return [
          new Some(new Folder(name, get_modkey(stat), children$1)),
          events$1,
        ];
      } else {
        let $1 = $[0];
        if ($1 instanceof Eacces) {
          return [new None(), delete$(path, vfs, events)];
        } else if ($1 instanceof Enoent) {
          return [new None(), delete$(path, vfs, events)];
        } else {
          let reason = $1;
          return [new Some(vfs), listPrepend(new Error(path, reason), events)];
        }
      }
    } else {
      let events$1 = delete$(path, vfs, events);
      return create_stat(filter, depth, vfs.name, path, stat, events$1);
    }
  } else {
    let events$1 = delete$(path, vfs, events);
    return create_stat(filter, depth, vfs.name, path, stat, events$1);
  }
}

function create_children(
  loop$filter,
  loop$depth,
  loop$path,
  loop$children,
  loop$oks,
  loop$events
) {
  while (true) {
    let filter = loop$filter;
    let depth = loop$depth;
    let path = loop$path;
    let children = loop$children;
    let oks = loop$oks;
    let events = loop$events;
    if (children instanceof $Empty) {
      return [$list.reverse(oks), events];
    } else {
      let first = children.head;
      let rest = children.tail;
      let $ = create(filter, depth, path, first, events);
      let vfs_opt;
      let events$1;
      vfs_opt = $[0];
      events$1 = $[1];
      let _block;
      if (vfs_opt instanceof Some) {
        let vfs = vfs_opt[0];
        _block = listPrepend(vfs, oks);
      } else {
        _block = oks;
      }
      let oks$1 = _block;
      loop$filter = filter;
      loop$depth = depth;
      loop$path = path;
      loop$children = rest;
      loop$oks = oks$1;
      loop$events = events$1;
    }
  }
}

function create(filter, depth, path, name, events) {
  let full_path = $filepath.join(path, name);
  let $ = $simplifile.link_info(full_path);
  if ($ instanceof Ok) {
    let stat = $[0];
    return create_stat(filter, depth, name, full_path, stat, events);
  } else {
    let $1 = $[0];
    if ($1 instanceof Eacces) {
      return [new None(), events];
    } else if ($1 instanceof Enoent) {
      return [new None(), events];
    } else {
      let reason = $1;
      return [new None(), listPrepend(new Error(full_path, reason), events)];
    }
  }
}

function create_stat(filter, depth, name, full_path, stat, events) {
  let type_ = $simplifile.file_info_type(stat);
  return $bool.guard(
    !filter(type_, full_path),
    [new None(), events],
    () => {
      if (type_ instanceof $simplifile.File) {
        return [
          new Some(new File(name, get_modkey(stat))),
          listPrepend(new Created(full_path), events),
        ];
      } else if (type_ instanceof $simplifile.Directory) {
        if (depth === 0) {
          return [
            new Some(new Folder(name, get_modkey(stat), toList([]))),
            listPrepend(new Created(full_path), events),
          ];
        } else if (depth !== 0) {
          let $ = readdir(full_path);
          if ($ instanceof Ok) {
            let entries = $[0];
            let depth$1 = depth - 1;
            let events$1 = listPrepend(new Created(full_path), events);
            let $1 = create_children(
              filter,
              depth$1,
              full_path,
              entries,
              toList([]),
              events$1,
            );
            let children$1;
            let events$2;
            children$1 = $1[0];
            events$2 = $1[1];
            return [
              new Some(new Folder(name, get_modkey(stat), children$1)),
              events$2,
            ];
          } else {
            let $1 = $[0];
            if ($1 instanceof Eacces) {
              return [new None(), events];
            } else if ($1 instanceof Enoent) {
              return [new None(), events];
            } else {
              let reason = $1;
              return [
                new None(),
                listPrepend(new Error(full_path, reason), events),
              ];
            }
          }
        } else {
          return [new None(), events];
        }
      } else {
        return [new None(), events];
      }
    },
  );
}

function step_roots(
  loop$filter,
  loop$max_depth,
  loop$roots,
  loop$new_roots,
  loop$events
) {
  while (true) {
    let filter = loop$filter;
    let max_depth = loop$max_depth;
    let roots = loop$roots;
    let new_roots = loop$new_roots;
    let events = loop$events;
    if (roots instanceof $Empty) {
      return [new_roots, events];
    } else {
      let $ = roots.head;
      if ($ instanceof Missing) {
        let rest = roots.tail;
        let path = $.path;
        let $1 = create(filter, max_depth, path, "", events);
        let new_vfs;
        let events$1;
        new_vfs = $1[0];
        events$1 = $1[1];
        let new_roots$1 = listPrepend(root(path, new_vfs), new_roots);
        loop$filter = filter;
        loop$max_depth = max_depth;
        loop$roots = rest;
        loop$new_roots = new_roots$1;
        loop$events = events$1;
      } else {
        let rest = roots.tail;
        let path = $.path;
        let vfs = $.vfs;
        let $1 = diff(filter, max_depth, path, vfs, events);
        let vfs$1;
        let events$1;
        vfs$1 = $1[0];
        events$1 = $1[1];
        let new_roots$1 = listPrepend(root(path, vfs$1), new_roots);
        loop$filter = filter;
        loop$max_depth = max_depth;
        loop$roots = rest;
        loop$new_roots = new_roots$1;
        loop$events = events$1;
      }
    }
  }
}

/**
 * Perform a single polling step, returning the updated state and any events
 * that were detected since the last step.
 *
 * Events are ordered the same way as with `watch`: directories are reported
 * before their contents on creation, and contents are reported before their
 * parent on deletion.
 *
 * Note that this function will NOT call the configured callbacks or send
 * messages to the registered subjects.
 */
export function step(options, state) {
  let max_depth$1;
  let filter$1;
  max_depth$1 = options.max_depth;
  filter$1 = options.filter;
  let $ = step_roots(filter$1, max_depth$1, state.roots, toList([]), toList([]));
  let new_roots;
  let events;
  new_roots = $[0];
  events = $[1];
  return [new State(new_roots), $list.reverse(events)];
}

/**
 * Create a child specification for running Polly under a supervisor.
 *
 * This lets you add Polly to your supervision tree, so she'll automatically
 * restart if something goes wrong. The supervisor will make sure she keeps
 * watching your files reliably!
 * Create a factory builder for dynamically starting multiple Polly watchers.
 *
 * This is useful when you want to spawn and manage multiple watchers at runtime,
 * each watching different paths with different options. The factory supervisor
 * handles starting, stopping, and supervising all your Polly instances!
 * 
 * @ignore
 */
function run(options, state) {
  let $ = step(options, state);
  let state$1;
  let events;
  state$1 = $[0];
  events = $[1];
  $list.each(
    events,
    (_capture) => { return broadcast(options.callbacks, _capture); },
  );
  return state$1;
}

function init_children(
  loop$filter,
  loop$depth,
  loop$path,
  loop$children,
  loop$oks,
  loop$errors
) {
  while (true) {
    let filter = loop$filter;
    let depth = loop$depth;
    let path = loop$path;
    let children = loop$children;
    let oks = loop$oks;
    let errors = loop$errors;
    if (children instanceof $Empty) {
      return [$list.reverse(oks), errors];
    } else {
      let first = children.head;
      let rest = children.tail;
      let $ = do_init(filter, depth, path, first, errors);
      let $1 = $[0];
      if ($1 instanceof Some) {
        let errors$1 = $[1];
        let vfs = $1[0];
        loop$filter = filter;
        loop$depth = depth;
        loop$path = path;
        loop$children = rest;
        loop$oks = listPrepend(vfs, oks);
        loop$errors = errors$1;
      } else {
        let errors$1 = $[1];
        loop$filter = filter;
        loop$depth = depth;
        loop$path = path;
        loop$children = rest;
        loop$oks = oks;
        loop$errors = errors$1;
      }
    }
  }
}

function do_init(filter, depth, path, name, errors) {
  let full_path = $filepath.join(path, name);
  let $ = $simplifile.link_info(full_path);
  if ($ instanceof Ok) {
    let stat = $[0];
    return init_stat(filter, depth, name, full_path, stat, errors);
  } else {
    let $1 = $[0];
    if ($1 instanceof Eacces) {
      return [new None(), errors];
    } else if ($1 instanceof Enoent) {
      return [new None(), errors];
    } else {
      let reason = $1;
      return [new None(), listPrepend([full_path, reason], errors)];
    }
  }
}

function init_stat(filter, depth, name, full_path, stat, errors) {
  let type_ = $simplifile.file_info_type(stat);
  return $bool.guard(
    !filter(type_, full_path),
    [new None(), errors],
    () => {
      if (type_ instanceof $simplifile.File) {
        return [new Some(new File(name, get_modkey(stat))), errors];
      } else if (type_ instanceof $simplifile.Directory) {
        if (depth === 0) {
          return [
            new Some(new Folder(name, get_modkey(stat), toList([]))),
            errors,
          ];
        } else if (depth !== 0) {
          let $ = readdir(full_path);
          if ($ instanceof Ok) {
            let entries = $[0];
            let depth$1 = depth - 1;
            let $1 = init_children(
              filter,
              depth$1,
              full_path,
              entries,
              toList([]),
              errors,
            );
            let children$1;
            let errors$1;
            children$1 = $1[0];
            errors$1 = $1[1];
            return [
              new Some(new Folder(name, get_modkey(stat), children$1)),
              errors$1,
            ];
          } else {
            let $1 = $[0];
            if ($1 instanceof Eacces) {
              return [new None(), errors];
            } else if ($1 instanceof Enoent) {
              return [new None(), errors];
            } else {
              let reason = $1;
              return [new None(), listPrepend([full_path, reason], errors)];
            }
          }
        } else {
          return [new None(), toList([])];
        }
      } else {
        return [new None(), toList([])];
      }
    },
  );
}

/**
 * Initialise Polly's internal state by scanning all the specified paths.
 *
 * This is the manual alternative to `watch` — it gives you direct access to
 * Polly's state so you can drive the polling loop yourself.
 *
 * Returns an error if any of the specified paths cannot be found and
 * `ignore_initial_missing` has not been set. Use `step` to advance the state
 * and collect events.
 */
export function init(options) {
  let paths;
  let max_depth$1;
  let filter$1;
  let ignore_initial_missing$1;
  paths = options.paths;
  max_depth$1 = options.max_depth;
  filter$1 = options.filter;
  ignore_initial_missing$1 = options.ignore_initial_missing;
  return $bool.guard(
    isEqual(paths, toList([])),
    new Err(toList([])),
    () => {
      let roots = $list.try_map(
        paths,
        (path) => {
          let $ = do_init(filter$1, max_depth$1, path, "", toList([]));
          let $1 = $[0];
          if ($1 instanceof Some) {
            let $2 = $[1];
            if ($2 instanceof $Empty) {
              let vfs = $1[0];
              return new Ok(new Initialised(path, vfs));
            } else {
              let errors = $2;
              return new Err(errors);
            }
          } else {
            let $2 = $[1];
            if ($2 instanceof $Empty) {
              if (ignore_initial_missing$1) {
                return new Ok(new Missing(path));
              } else {
                return new Err(toList([[path, new Enoent()]]));
              }
            } else {
              let errors = $2;
              return new Err(errors);
            }
          }
        },
      );
      return $result.map(roots, (var0) => { return new State(var0); });
    },
  );
}

/**
 * Tell Polly to start watching all the specified directories for changes.
 *
 * The callbacks are called synchronously while collecting change events since
 * the last run. It is adviseable to move heavier cpu-bound tasks from this
 * callback into their own processes or threads.
 *
 * When running on the Erlang target, this spawns a new linked process.
 */
export function watch(options) {
  return $result.try$(
    init(options),
    (roots) => {
      let stop$1 = repeatedly(
        options.interval,
        roots,
        (_capture) => { return run(options, _capture); },
      );
      return new Ok(new Watcher(stop$1));
    },
  );
}
